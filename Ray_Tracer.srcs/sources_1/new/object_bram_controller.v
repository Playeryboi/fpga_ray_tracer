`timescale 1ns / 1ps
`default_nettype none

module object_bram_controller(
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
    output wire intersect_grant,
    
    // BRAM physical interface
    input wire [31:0] bram_data,
    output wire read_en,
    output reg [31:0] bram_addr
    );
    
    assign read_en = 1'b1; //for now, always have read enabled
    
    // Pipeline shift registers to track which module owns the arriving data
    // Shift register length matches the 1-cycle read latency of the BRAM
    reg camera_owner_pipe;
    reg intersect_owner_pipe;

    // Data is always exposed on both busses; the ready flags tell them when to look
    assign camera_data    = bram_data;
    assign intersect_data = bram_data;
    // Combinational Priority Logic (Evaluates instantly)
    assign camera_grant = camera_read;
    // Intersect only gets the bus if it asks AND the camera isn't asking
    assign intersect_grant = intersect_read & ~camera_read;   
    

    always @(posedge clk) begin
        // 1. Address Arbitration Stage (Executes every single clock cycle)
        if (camera_read) begin
            // Camera takes the bus immediately with 0 delay cycles
            bram_addr <= bram_camera_addr;
            camera_owner_pipe <= 1'b1;
            intersect_owner_pipe <= 1'b0;
        end
        else if (intersect_read) begin
            // Intersection engine gets the bus if camera doesn't want it
            bram_addr <= bram_intersect_addr;
            camera_owner_pipe <= 1'b0;
            intersect_owner_pipe <= 1'b1;
        end
        else begin
            // Nobody requested a read     
            camera_owner_pipe <= 1'b0;
            intersect_owner_pipe <= 1'b0;
            
        end

        // 2. Data Output Validation Stage (1 cycle later)
        // The pipeline registers tell us exactly who owns the data currently on the bus       
        camera_ready    <= camera_owner_pipe;
        intersect_ready <= intersect_owner_pipe;
    end
    

endmodule