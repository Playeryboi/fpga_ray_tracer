`timescale 1ns / 1ps

module sphere_hit_and_normal(
    input wire clk,
    input wire start,    
    input wire signed [24:0] t_distance, //Q9.16
    input wire [53:0] ray_dir,               
    input wire [127:0] object1,
    input wire [127:0] object2,
    input wire input_hit_flag,
    
    input wire signed [17:0] camera_x, //Q9.9
    input wire signed [17:0] camera_y,
    input wire signed [17:0] camera_z,
    
    output wire [53:0] normal_packed,
    output wire [74:0] hit_point_packed,
    output wire module_done,
    output wire output_hit_flag,
    
    output wire LED
    );
     assign LED = ^normal_packed;
    //keeping in mind that this currently works with a fixed amount of objects
    
    //object variables stay the same throughout the frame, no need to pipeline
    
    //--------- Object 1 (Sphere) ----------------                                                                           
    wire signed [17:0] object1_x = object1[113:96];//Q9.9                                                                    
    wire signed [17:0] object1_y = object1[81:64]; //Q9.9                                                                    
    wire signed [17:0] object1_z = object1[49:32]; //Q9.9                                                                    
                                                                                                                             
    wire [11:0] object1_color = object1[11:0];// object color which is 12bit 3 bytes                                         
    wire [3:0] object1_size = object1[15:12]; // 1 byte                                                                      
    wire [3:0] object1_shape_material = object1[19:16];// the shape parameter and material parameters only need 1 total byte 
    
    //ray vectors unpacked {ray_dir_x, ray_dir_y, ray_dir_z}
    wire signed [17:0] ray_dir_x = ray_dir[53:36];
    wire signed [17:0] ray_dir_y = ray_dir[35:18];
    wire signed [17:0] ray_dir_z = ray_dir[17:0];
    
    reg stage_0, stage_1, stage_2, stage_3;
    reg stage_4, stage_5, stage_6;
    
    reg signed [17:0] ray_dir_pipeline [2:0];
    reg signed [42:0] ray_origin_pipeline [2:0];
    reg signed [24:0] t_distance_pipeline;
    
    reg signed [17:0] inv_radius; // Q2.16
    //25 bit + 18 bit = 43 bit output
    reg signed [42:0] prelim_hp [2:0]; //seperate pipeline to use DSP multiplier and post adder
    
    reg signed [43:0] hit_point [2:0]; // 43 bits + 1 overflow bit
    reg signed [24:0] hit_point_trunc [2:0]; //25 bits wide for DSP multiplier Q13.12
    reg [74:0] hit_point_pipeline [2:0]; //packing data to leave module
    reg signed [24:0] normal_prelim [2:0]; //hit point - sphere origin
    reg signed [42:0] normal [2:0]; //43 bit result from multiplication
    reg signed [17:0] final_normal [2:0]; //truncated to be Q2.16
    
    reg hit_flag_pipe [6:0];
    assign output_hit_flag = hit_flag_pipe[6];
    
    assign normal_packed = {final_normal[0],final_normal[1],final_normal[2]}; //packing normal to transfer to another module
    assign module_done = stage_6;
    assign hit_point_packed = hit_point_pipeline[2];
    
    always @(*) begin
       case(object1_size)
            4'd0: inv_radius <= 65536; //don't allow division by zero, make it one
            4'd1: inv_radius <=65536; //Q2.16 format
            4'd2: inv_radius <=32768;
            4'd3: inv_radius <=21845;
            4'd4: inv_radius <=16384;
            4'd5: inv_radius <=13107;
            4'd6: inv_radius <=10923;
            4'd7: inv_radius <=9362;
            4'd8: inv_radius <=8192;
            4'd9: inv_radius <=7282;
            4'd10: inv_radius <=6554;
            4'd11: inv_radius <=5958;
            4'd12: inv_radius <=5461;
            4'd13: inv_radius <=5041;
            4'd14: inv_radius <=4681;
            4'd15: inv_radius <=4369;
       endcase
    end

    //hit is ray_origin + t*ray_dir 
    //ray_origin is the camera origin
    always @(posedge clk) begin
        stage_0 <= start;
        hit_flag_pipe[0] <= input_hit_flag;
        
        t_distance_pipeline <= t_distance;
        
        ray_dir_pipeline[0] <= ray_dir_x; //input changes every clock cycle, need to catch immediately
        ray_dir_pipeline[1] <= ray_dir_y;
        ray_dir_pipeline[2] <= ray_dir_z;
    
    end
    
    always @(posedge clk) begin
        stage_1 <= stage_0;
        hit_flag_pipe[1] <= hit_flag_pipe[0];
        
        ray_origin_pipeline[0] <= {{2{camera_x[17]}}, camera_x, 23'd0}; //input doesnt change until the frame ends
        ray_origin_pipeline[1] <= {{2{camera_y[17]}}, camera_y, 23'd0}; // but need registers so Vivado uses the DSPs
        ray_origin_pipeline[2] <= {{2{camera_z[17]}}, camera_z, 23'd0};//internal registers
        //camera is Q9.9, to align to Q11.32, need to shift 23 bits and sign extend
        
        prelim_hp[0] <= ray_dir_pipeline[0] * t_distance_pipeline; //Q2.16 * Q9.16
        prelim_hp[1] <= ray_dir_pipeline[1] * t_distance_pipeline; //Q2.16 * Q9.16
        prelim_hp[2] <= ray_dir_pipeline[2] * t_distance_pipeline; //Q2.16 * Q9.16
        //result = Q11.32 = 43 bits
    end
    
    always @(posedge clk) begin
        stage_2 <= stage_1;
        hit_flag_pipe[2] <= hit_flag_pipe[1];
        
        hit_point[0] <=  prelim_hp[0] + ray_origin_pipeline[0];// x  44 bit result  Q12.32
        hit_point[1] <=  prelim_hp[1] + ray_origin_pipeline[1];// y  44 bit result  Q12.32
        hit_point[2] <=  prelim_hp[2] + ray_origin_pipeline[2];// z  44 bit result  Q12.32
    
    end
    
    reg [24:0] object1_loc [2:0];
    
    always @(posedge clk) begin
        stage_3 <= stage_2;
        hit_flag_pipe[3] <= hit_flag_pipe[2];
        
        // [43] is the sign bit. [41:18] are the 24 magnitude bits. 1 + 24 = 25 bits exactly.
        hit_point_trunc[0] <= {hit_point[0][43], hit_point[0][41:18]};//Q11.14
        hit_point_trunc[1] <= {hit_point[1][43], hit_point[1][41:18]};//Q11.14
        hit_point_trunc[2] <= {hit_point[2][43], hit_point[2][41:18]};//Q11.14   
        
        object1_loc[0] <= {{2{object1_x[17]}},object1_x, 5'd0}; //Q9.9 -> //Q11.14
        object1_loc[1] <= {{2{object1_y[17]}},object1_y, 5'd0}; //Q9.9 -> //Q11.14
        object1_loc[2] <= {{2{object1_z[17]}},object1_z, 5'd0}; //Q9.9 -> //Q11.14
    
    end
    
    always @(posedge clk) begin
        stage_4 <= stage_3;
        hit_flag_pipe[4] <= hit_flag_pipe[3];
        
        hit_point_pipeline[0] <= {hit_point_trunc[0],hit_point_trunc[1],hit_point_trunc[2]};
        
        normal_prelim[0] <= hit_point_trunc[0] - object1_loc[0]; // Q11.14 - Q11.14
        normal_prelim[1] <= hit_point_trunc[1] - object1_loc[1]; // Q11.14 - Q11.14
        normal_prelim[2] <= hit_point_trunc[2] - object1_loc[2]; // Q11.14 - Q11.14
        
    end
    
    always @(posedge clk) begin
        stage_5 <= stage_4;
        hit_flag_pipe[5] <= hit_flag_pipe[4];
        
        hit_point_pipeline[1] <= hit_point_pipeline[0];
        
        normal[0] <= normal_prelim[0] * inv_radius; //Q13.30
        normal[1] <= normal_prelim[1] * inv_radius; //Q13.30
        normal[2] <= normal_prelim[2] * inv_radius; //Q13.30            
    end
     
     always @(posedge clk) begin
        stage_6 <= stage_5;
        hit_flag_pipe[6] <= hit_flag_pipe[5];
        
        hit_point_pipeline[2] <= hit_point_pipeline[1];
        
        final_normal[0] <= $signed({normal[0][42],normal[0][30:14]}); //Q2.16  
        final_normal[1] <= $signed({normal[1][42],normal[1][30:14]}); //Q2.16  
        final_normal[2] <= $signed({normal[2][42],normal[2][30:14]}); //Q2.16  
        
     end
endmodule
