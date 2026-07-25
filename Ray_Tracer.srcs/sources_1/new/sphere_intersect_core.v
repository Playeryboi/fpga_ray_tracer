`timescale 1ns / 1ps
`default_nettype none

module sphere_intersect_core(
    input wire clk,
    input wire start_core,
    input wire signed [17:0] ray_dir_x,
    input wire signed [17:0] ray_dir_y,
    input wire signed [17:0] ray_dir_z,
                       
    input wire signed [17:0] object_x,
    input wire signed [17:0] object_y,
    input wire signed [17:0] object_z,
    
    input wire signed [17:0] camera_x,
    input wire signed [17:0] camera_y,
    input wire signed [17:0] camera_z,
        
    input wire [11:0] object_color,
    input wire [3:0] object_size,
    input wire [3:0] object_shape_material,
    output reg hit_flag
    );
    //Master sphere intersection formula
    //a = Ray_Dir * Ray_Dir
    //b = 2.0 * (Ray_Dir * (Ray_origin - Sphere_origin))
    //c = (Ray_origin - Sphere_origin)*(Ray_origin - Sphere_origin) - Radius*Radius
    // DELTA  = b^2 -4ac
   
    //defining registers for pipeline
    reg stage_1, stage_2, stage_3, stage_4, stage_5, stage_6, stage_7;
    
    reg signed [37:0] a, a_intermediate; //Q6.32 need intermediate to not have long carry chain
    reg signed [38:0] b, b_intermediate; //Q14.25, shifting by 1 requires extra bits
    reg signed [37:0] c; //Q20.18
    //truncated a, b, and c to optimize for DSP usage
    reg signed [18:0] a_trunc;//Q6.13
    reg signed [23:0] b_trunc;//Q14.10
    reg signed [24:0] c_trunc;//Q20.5
    
    reg signed [47:0] b_sqrd; // 24-bit * 24-bit
    reg signed [47:0] four_ac; // 19-bit * 25-bit + 4 bit shift
    reg signed [47:0] delta; //28.20
    //combinational logic (math)
    //[0] represents x, [1] represents y, [2] represents z
    //each * is one DSP slice being used

    reg signed [17:0] ray_minus_origin [2:0]; //Q9.9

    reg signed [35:0] a_mul [2:0]; //Q4.32       
    reg signed [35:0] b_mul [2:0]; //Q11.25
    reg signed [36:0] c_mul_1, c_mul_2; //Q19.18
    reg signed [35:0] ray_minus_origin_sqrd [2:0];
    wire signed [8:0] radius_sqrd = object_size*object_size;
    
    reg signed [35:0] radius_sqrd_reg_stg1, radius_sqrd_reg_stg2; //need seperate stage registers
    reg signed [17:0] ray_dir_stg1 [2:0];
    
    reg signed [35:0] a_mul_z_stg1;
    reg signed [35:0] b_mul_z_stg1;
    
    always @(posedge clk) begin
        stage_1 <= start_core;
        if(start_core) begin
            a_mul[0] <= ray_dir_x * ray_dir_x;
            a_mul[1] <= ray_dir_y * ray_dir_y;
            a_mul[2] <= ray_dir_z * ray_dir_z;

            ray_dir_stg1[0] <= ray_dir_x;
            ray_dir_stg1[1] <= ray_dir_y;
            ray_dir_stg1[2] <= ray_dir_z;
            
            radius_sqrd_reg_stg1 <= radius_sqrd <<< 18;//arithmetic alignment for stage 2
                                                       //subtraction
            
            ray_minus_origin[0] <= camera_x - object_x;
            ray_minus_origin[1] <= camera_y - object_y;
            ray_minus_origin[2] <= camera_z - object_z;
            
        end
    end
    
    always @(posedge clk) begin
        stage_2 <= stage_1;
        if(stage_1) begin
        
            a_intermediate <= a_mul[0] + a_mul[1];
            a_mul_z_stg1 <= a_mul[2];
            
            radius_sqrd_reg_stg2 <= radius_sqrd_reg_stg1;
            
            b_mul[0] <= ray_dir_stg1[0] * ray_minus_origin[0];
            b_mul[1] <= ray_dir_stg1[1] * ray_minus_origin[1];
            b_mul[2] <= ray_dir_stg1[2] * ray_minus_origin[2]; 
            
            ray_minus_origin_sqrd[0] <= ray_minus_origin[0]*ray_minus_origin[0];
            ray_minus_origin_sqrd[1] <= ray_minus_origin[1]*ray_minus_origin[1];
            ray_minus_origin_sqrd[2] <= ray_minus_origin[2]*ray_minus_origin[2];
            
        end
    end
    
    always @(posedge clk) begin
        stage_3 <= stage_2;
        if(stage_2) begin
            a <= a_intermediate + a_mul_z_stg1;
            
            c_mul_1 <= ray_minus_origin_sqrd[0] + ray_minus_origin_sqrd[1];
            c_mul_2 <= ray_minus_origin_sqrd[2] - radius_sqrd_reg_stg2;
            
            b_intermediate <= b_mul[0] + b_mul[1];
            b_mul_z_stg1 <= b_mul[2];
        end
    end    
 
     always @(posedge clk) begin
        stage_4 <= stage_3;
        if(stage_3) begin
            c <= c_mul_1 + c_mul_2;
            b <= (b_intermediate + b_mul_z_stg1) <<< 1;
        end
    end  
    
    always @(posedge clk) begin
        stage_5 <= stage_4;
        if(stage_4) begin
            a_trunc <= a[37:19]; //Q6.32 --> Q6.13
            b_trunc <= b[38:15]; //Q14.25 --> Q14.10
            c_trunc <= c[37:13]; //Q20.18 --> Q20.5 -> will use 25bit DSP input
        end
    end     
    
    always @(posedge clk) begin
        stage_6 <= stage_5;
        if(stage_5) begin
            four_ac <= (a_trunc * c_trunc) * 16;
            b_sqrd <= b_trunc * b_trunc;
        end
    end      
    
    always @(posedge clk) begin
        stage_7 <= stage_6;
        if(stage_6) begin
            delta <= b_sqrd - four_ac;
        end
    end     
    
    always @(posedge clk) begin
        hit_flag <= 1'b0;
        if(delta[47] == 1'b0 && stage_7) begin
            hit_flag <= 1'b1;
        end
    end    
    
endmodule
