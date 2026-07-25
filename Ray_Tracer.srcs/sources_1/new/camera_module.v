`timescale 1ns / 1ps
`default_nettype none

module camera_module(
    input wire clk,
    input wire frame_start,
    //bram controller connections
    input wire granted,
    output reg camera_read,
    input wire camera_ready,
    input wire [31:0] bram_data,
    output reg [31:0] bram_addr,
    // Intersect engine connections
    output wire signed [17:0] camera_x,
    output wire signed [17:0] camera_y,
    output wire signed [17:0] camera_z,
 
    output wire signed [17:0] ray_dir_x,
    output wire signed [17:0] ray_dir_y,
    output wire signed [17:0] ray_dir_z,    
    output reg setup_done,
    input wire render
    );
    
    localparam  Wait = 2'b00, 
                Read = 2'b01; 
                // Ray_Gen state removed as math is combinational wire logic
                
    reg state = Wait;      
    reg signed [31:0] camera_origin [2:0];
    reg signed [31:0] D_top_left [2:0];
    reg signed [31:0] delta_u [2:0];
    reg signed [31:0] delta_v [2:0];   
    
    reg [3:0] words_requested; 
    reg [3:0] words_received;  
    

    pipelined_ray_gen gen1 (
    .clk(clk),
    .render(render),
    .setup_done(setup_done),
    .D_top_left_x(D_top_left[0]),
    .D_top_left_y(D_top_left[1]),
    .D_top_left_z(D_top_left[2]),
    .delta_u_x(delta_u[0]),
    .delta_u_y(delta_u[1]),
    .delta_u_z(delta_u[2]),  
    .delta_v_x(delta_v[0]),
    .delta_v_y(delta_v[1]),
    .delta_v_z(delta_v[2]),
    .ray_dir_x(ray_dir_x),
    .ray_dir_y(ray_dir_y),
    .ray_dir_z(ray_dir_z)  
    );
    
    assign camera_x = camera_origin[0][17:0];
    assign camera_y = camera_origin[1][17:0];
    assign camera_z = camera_origin[2][17:0];  
    
    always @(posedge clk) begin
        case(state)
            Wait: begin
                if (frame_start) begin
                    state <= Read;
                    camera_read <= 1'b1;
                    bram_addr <= 32'd0;
                    words_requested <= 4'd0;
                    words_received <= 4'd0;
                    setup_done <= 1'b0; // Reset flag at start of new frame
                end
            end
            
            Read: begin
                // Address Blaster
                if (words_requested < 4'd12) begin
                    // Only step if the Arbiter actually granted us the bus
                    if(granted) begin
                        bram_addr <= bram_addr + 4;
                        words_requested <= words_requested + 1;
                    end
                end else begin
                    camera_read <= 1'b0; 
                end

                // Data Catcher
                if (camera_ready) begin
                    case (words_received)
                        4'd0: camera_origin[0] <= bram_data; 
                        4'd1: camera_origin[1] <= bram_data; 
                        4'd2: camera_origin[2] <= bram_data;                     
                    
                        4'd3: D_top_left[0] <= bram_data; 
                        4'd4: D_top_left[1] <= bram_data; 
                        4'd5: D_top_left[2] <= bram_data; 
                        
                        4'd6: delta_u[0] <= bram_data; 
                        4'd7: delta_u[1] <= bram_data; 
                        4'd8: delta_u[2] <= bram_data; 
                        
                        4'd9: delta_v[0] <= bram_data; 
                        4'd10: delta_v[1] <= bram_data; 
                        4'd11: delta_v[2] <= bram_data;  //address 44
                    endcase
                    
                    words_received <= words_received + 1;
                end

                // Exit Condition
                if (words_received == 4'd12) begin
                    state <= Wait;
                    setup_done <= 1'b1; //Intersection Engine can start.
                end
            end
        endcase     
    end    
endmodule