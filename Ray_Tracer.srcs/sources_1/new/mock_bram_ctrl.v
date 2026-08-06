`timescale 1ns / 1ps
`default_nettype none

module mock_bram_controller(
    input wire clk,
    
    // Camera module connections (High Priority)
    input wire [31:0] bram_camera_addr,
    input wire camera_read,
    output reg camera_ready,
    output wire [31:0] camera_data,
    output wire camera_grant,
    
    // Intersect engine connections (Low Priority)
    input wire [31:0] bram_intersect_addr,
    input wire intersect_read,
    output reg intersect_ready,
    output wire [31:0] intersect_data,
    output wire intersect_grant
    );
    
    // Pipeline shift registers to track which module owns the data
    reg camera_owner_pipe;
    reg intersect_owner_pipe;
    
    reg [31:0] requested_addr;
    reg [31:0] mock_dout;

    // Both buses see the same data, just like physical BRAM
    assign camera_data    = mock_dout;
    assign intersect_data = mock_dout;
    
    // Combinational Priority Logic
    assign camera_grant = camera_read;
    assign intersect_grant = intersect_read & ~camera_read;   
    
    always @(posedge clk) begin
        // 1. Address Arbitration Stage
        if (camera_read) begin
            requested_addr <= bram_camera_addr;
            camera_owner_pipe <= 1'b1;
            intersect_owner_pipe <= 1'b0;
        end
        else if (intersect_read) begin
            requested_addr <= bram_intersect_addr;
            camera_owner_pipe <= 1'b0;
            intersect_owner_pipe <= 1'b1;
        end
        else begin    
            camera_owner_pipe <= 1'b0;
            intersect_owner_pipe <= 1'b0;
        end

        // 2. Data Output Validation Stage (1 cycle later)
        camera_ready    <= camera_owner_pipe;
        intersect_ready <= intersect_owner_pipe;
        
        // Mock Memory Matrix (Evaluates the requested_addr from cycle 1)
        if (camera_owner_pipe || intersect_owner_pipe) begin
            case(requested_addr)
                // --- CAMERA DATA ---
                // Camera origin (Q9.9) - (0, 0, 0)
                32'd0:  mock_dout <= 32'sd0;
                32'd4:  mock_dout <= 32'sd0;
                32'd8:  mock_dout <= 32'sd0;
                
                // D_top_left (Q2.16)
                32'd12: mock_dout <= 32'sd65536; 
                32'd16: mock_dout <= 32'sd50370;
                32'd20: mock_dout <= 32'sd37758;
                
                // delta_u (Q2.16)
                32'd24: mock_dout <= 32'sd0;
                32'd28: mock_dout <= -32'sd157;
                32'd32: mock_dout <= 32'sd0;
                
                // delta_v (Q2.16)
                32'd36: mock_dout <= 32'sd0;
                32'd40: mock_dout <= 32'sd0;
                32'd44: mock_dout <= -32'sd157;
                
                // --- INTERSECTION DATA ---
                // Object 1 Origin (Q9.9) - Sphere at (5, 0, 0)
                32'd48: mock_dout <= 32'sd2560; 
                32'd52: mock_dout <= 32'sd0;
                32'd56: mock_dout <= 32'sd0;
                
                // Object 1 Params: Sphere, Diffuse, Size 2, White
                32'd60: mock_dout <= 32'd12287; 


                // Object 2 Origin (Q9.9) - light at (5, 5, 5)
                32'd64: mock_dout <= 32'sd2560; 
                32'd68: mock_dout <= 32'sd2560;
                32'd72: mock_dout <= 32'sd2560;
                
                // Object 2 Params: light, n/a, n/a, White
                32'd76: mock_dout <= 32'd790527;
                                 
                default: mock_dout <= 32'sd0;
            endcase
        end
    end
endmodule