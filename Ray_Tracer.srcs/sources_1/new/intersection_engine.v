`timescale 1ns / 1ps
`default_nettype none

module intersection_engine(
    input wire clk,

    // Using setup_done instead of frame_start
    input wire setup_done, 
    input wire render, //currently not being used
    output reg [3:0] red_wire,
    output reg [3:0] green_wire,
    output reg [3:0] blue_wire,
    
    output wire LED,
    //camera module connections
    input wire signed [17:0] camera_x,
    input wire signed [17:0] camera_y,
    input wire signed [17:0] camera_z,
    
    input wire signed [17:0] ray_dir_x,
    input wire signed [17:0] ray_dir_y,
    input wire signed [17:0] ray_dir_z, 
       
    output reg start_cores,
    //bram controller connections
    input wire granted,
    output reg intersect_read,
    input wire intersect_ready,
    input wire [31:0] bram_data,
    output reg [31:0] bram_addr 
    );
               
    reg signed [31:0] object [2:0];  
    reg [31:0] object_param;
    
    reg [127:0] object1;
    reg [127:0] object2;
    
    wire [11:0] object_color = object_param[11:0];// object color which is 12bit 3 bytes
    wire [3:0] object_size = object_param[15:12]; // 1 byte
    wire [3:0] object_shape_material = object_param[19:16];// the shape parameter and material parameters only need 1 total byte
    //EX 00 -> sphere 01-> square 11-> plane || 00 -> diffuse 01-> reflective
    // total object size: 9 bytes
        
    reg [3:0] object_counter = 4'd0; 
    reg [3:0] words_requested; 
    reg [3:0] words_received;  
    
    localparam  Wait = 2'b00,
                Read = 2'b01,
                Done = 2'b10; 
                
    reg [1:0] state = Wait;      


    always @(posedge clk) begin
        start_cores <= 1'b0; 
        case(state)
            Wait: begin
                // Wait for the camera to finish its memory reads
                if (setup_done) begin
                    state <= Read;
                    intersect_read <= 1'b1;
                    bram_addr <= 32'd48; 
                    words_requested <= 4'd0;
                    words_received <= 4'd0;
                    object_counter <= 8'd0;
                end
            end
            
            Read: begin
                // Address Blaster
                if (words_requested < 4'd4) begin
                    if (granted) begin
                        bram_addr <= bram_addr + 4;
                        words_requested <= words_requested + 1;
                    end
                end else begin
                    intersect_read <= 1'b0; 
                end

                // Data Catcher
                if (intersect_ready) begin
                    case (words_received)
                        4'd0: object[0] <= bram_data; 
                        4'd1: object[1] <= bram_data; 
                        4'd2: object[2] <= bram_data;
                        4'd3: begin
                            object_param <= bram_data;  
                            object_counter <= object_counter + 1;
                        end
                    endcase
                    words_received <= words_received + 1;
                end
                
                // Exit Condition 
                if (words_received == 4'd4) begin
                    if(object_counter == 4'd1) begin
                        object1 <= {object[0],object[1],object[2],object_param};
                    end
                    else if(object_counter == 4'd2) begin
                        object2 <= {object[0],object[1],object[2],object_param};
                    end   
                                     
                    if (object_counter == 8'd2) begin 
                        state <= Done; 
                    end else begin
                        words_requested <= 4'd0;
                        words_received <= 4'd0;
                        intersect_read <= 1'b1; 
                    end
                end
            end
            
            Done: begin
                // When the camera drops setup_done (start of new frame), 
                start_cores <= 1'b1;
                if (!setup_done) begin
                    state <= Wait;
                end
            end
        endcase     
    end    
    
    sphere_intersect_core s_core0 (
    .clk(clk),
    .start_core(start_cores),
    .ray_dir_x(ray_dir_x),
    .ray_dir_y(ray_dir_y),
    .ray_dir_z(ray_dir_z),    
    .object1(object1),
    .object2(object2),
    .camera_x(camera_x),
    .camera_y(camera_y),
    .camera_z(camera_z),
    .LED(LED) 
    );
    
endmodule
