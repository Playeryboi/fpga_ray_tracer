`timescale 1ns / 1ps
`default_nettype none

module primary_ray_sphr(
    input wire clk,
    input wire start_core,
    input wire signed [17:0] ray_dir_x,
    input wire signed [17:0] ray_dir_y,
    input wire signed [17:0] ray_dir_z,
                       
    input wire [127:0] object1,
    input wire [127:0] object2,
    
    input wire signed [17:0] camera_x,
    input wire signed [17:0] camera_y,
    input wire signed [17:0] camera_z,
    
    output wire LED
    
    );
    //Master sphere intersection formula
    //a = Ray_Dir * Ray_Dir
    //b = 2.0 * (Ray_Dir * (Ray_origin - Sphere_origin))
    //c = (Ray_origin - Sphere_origin)*(Ray_origin - Sphere_origin) - Radius*Radius
    // DELTA  = b^2 -4ac
    
    
    delta_sqrt SQRT0 (
    .clk(clk),                                 
    .delta_done(stage_9),                              
    .delta(delta), //Q26.22    
    .a_trunc_in(a_trunc[3]),
    .b_trunc_in(b_trunc[3]),   
    .sqrt_delta(sqrt_delta), //Q13.11            
    .hit_flag(hit_flag_0),
    .a_trunc_out(a_to_div), 
    .b_trunc_out(b_to_div),                            
    .done(sqrt_done)                                 
   );
   
    t_distance_div DIV0 (
    .clk(clk),
    .sqrt_done(sqrt_done),
    .sqrt_delta(sqrt_delta), //Q13.11
    .a(a_to_div), //Q2.22
    .b(b_to_div), //Q13.11
    .t_distance(t_distance),
    .div_done(div_done),
    .input_hit(hit_flag_0),
    .output_hit(hit_flag_1)
    );
   
   
    wire signed [24:0] t_distance;
    wire signed [23:0] sqrt_delta;
    wire sqrt_done;
    wire div_done;
    wire hit_flag_0, hit_flag_1;
    
    assign LED = ^t_distance;
    
    //a and b have to be transferred to the pipeline to reach the division
    //module aligned
    wire signed [23:0] a_to_div;
    wire signed [23:0] b_to_div;
    
    //--------- Object 1 (Sphere) ----------------
    wire signed [17:0] object1_x = object1[113:96];//Q9.9
    wire signed [17:0] object1_y = object1[81:64]; //Q9.9
    wire signed [17:0] object1_z = object1[49:32]; //Q9.9
    
    wire [11:0] object1_color = object1[11:0];// object color which is 12bit 3 bytes
    wire [3:0] object1_size = object1[15:12]; // 1 byte
    wire [3:0] object1_shape_material = object1[19:16];// the shape parameter and material parameters only need 1 total byte
    
    //--------- Object 2 (light) ----------------
    wire signed [17:0] object2_x = object2[113:96];//Q9.9
    wire signed [17:0] object2_y = object2[81:64]; //Q9.9
    wire signed [17:0] object2_z = object2[49:32]; //Q9.9
    
    wire [11:0] object2_color = object2[11:0];// object color which is 12bit 3 bytes
    wire [3:0] object2_size = object2[15:12]; // 1 byte
    wire [3:0] object2_shape_material = object2[19:16];// the shape parameter and material parameters only need 1 total byte
 
    
    //EX 00 -> sphere 01-> square 11-> plane || 00 -> diffuse 01-> reflective
    // total object size: 9 bytes
    //defining registers for pipeline
    reg stage_0, stage_1, stage_2, stage_3;
    reg stage_4, stage_5, stage_6, stage_7;
    reg stage_8, stage_9;
    
    reg signed [17:0] camera_x_reg, camera_y_reg, camera_z_reg;
    reg signed [17:0] object1_x_reg, object1_y_reg, object1_z_reg;
    reg signed [17:0] ray_dir_x_reg, ray_dir_y_reg, ray_dir_z_reg;
    reg signed [17:0] ray_dir_x_reg_stg1, ray_dir_y_reg_stg1, ray_dir_z_reg_stg1;
    
    (* use_dsp = "no" *) reg signed [37:0] a; //Q6.32 need intermediate to not have long carry chain
    (* use_dsp = "no" *) reg signed [37:0] a_stg1;
    (* use_dsp = "no" *) reg signed [38:0] b; //Q14.25, shifting by 1 requires extra bits
    (* use_dsp = "no" *) reg signed [37:0] c; //Q20.18
    
    //intermediate stages to shorten propagation delay
    (* use_dsp = "no" *) reg signed [36:0] a_intermediate; //37 bits wide since adding 2 36 bit numbers could 
    (* use_dsp = "no" *) reg signed [36:0] b_intermediate; //result in overflow
    
    //truncated a, b, and c to optimize for DSP usage
    
    reg signed [23:0] a_trunc [3:0]; //Q2.22
    reg signed [23:0] b_trunc [3:0];//Q13.11
    reg signed [23:0] c_trunc;//Q19.5
    
    reg signed [47:0] b_sqrd; // 24-bit * 24-bit
    reg signed [47:0] four_ac; // 18-bit * 25-bit + 3 bit shift
    reg signed [47:0] delta; //26.22
    //combinational logic (math)
    //[0] represents x, [1] represents y, [2] represents z

    reg signed [17:0] ray_minus_origin_for_sqrd [2:0]; //Q9.9
    reg signed [17:0] ray_minus_origin_for_b [2:0];
    
    reg signed [35:0] a_mul [3:0]; //Q4.32       
    reg signed [35:0] b_mul [3:0]; //Q11.25
    (* use_dsp = "no" *) reg signed [36:0] c_add_1, c_add_2; //Q19.18
    
    reg signed [35:0] ray_minus_origin_sqrd [2:0];
    reg [3:0] object1_size_reg;
    
    reg signed [7:0] radius_sqrd_stg1;
    reg signed [35:0] radius_sqrd_reg_stg [1:0]; //need seperate stage registers
    reg signed [17:0] ray_dir_stg1 [2:0];
    
    reg signed [36:0] a_mul_z_stg1;
    reg signed [36:0] b_mul_z_stg1;
    
    
    reg signed [41:0] four_ac_prelim; //42 bits because 24 + 18 is 42
    reg signed [41:0] four_ac_hprod; //high bit product
    reg signed [41:0] b_prelim_sqrd;
    reg signed [41:0] b_high_prod; // Holds the upper multiplication result
    
    reg signed [17:0] ray_minus_origin_for_sqrd_stg1 [2:0];
    reg signed [17:0] ray_minus_origin_for_b_stg1 [2:0];    
    
    always @(posedge clk) begin
        stage_0 <= start_core;
    
        camera_x_reg <= camera_x;
        camera_y_reg <= camera_y;
        camera_z_reg <= camera_z;
        
        object1_x_reg <= object1_x;
        object1_y_reg <= object1_y;
        object1_z_reg <= object1_z;
        
        ray_dir_x_reg <= ray_dir_x;
        ray_dir_y_reg <= ray_dir_y;
        ray_dir_z_reg <= ray_dir_z;
        
        object1_size_reg <= object1_size;
    end        
    
    always @(posedge clk) begin
        stage_1 <= stage_0;
        
        radius_sqrd_stg1 <=  object1_size_reg * object1_size_reg; //4 bit * 4 bit = 8 bit
        
        ray_dir_x_reg_stg1 <= ray_dir_x_reg;
        ray_dir_y_reg_stg1 <= ray_dir_y_reg;
        ray_dir_z_reg_stg1 <= ray_dir_z_reg;
        
        ray_minus_origin_for_sqrd[0] <= camera_x_reg - object1_x_reg; //Q9.9
        ray_minus_origin_for_sqrd[1] <= camera_y_reg - object1_y_reg; //Q9.9
        ray_minus_origin_for_sqrd[2] <= camera_z_reg - object1_z_reg; //Q9.9
        
        ray_minus_origin_for_b[0] <= camera_x_reg - object1_x_reg; //Q9.9
        ray_minus_origin_for_b[1] <= camera_y_reg - object1_y_reg; //Q9.9
        ray_minus_origin_for_b[2] <= camera_z_reg - object1_z_reg; //Q9.9    
    end
    
    always @(posedge clk) begin
        stage_2 <= stage_1;
        
        a_mul[0] <= ray_dir_x_reg_stg1  * ray_dir_x_reg_stg1 ; //Q2.16 * Q2.16 -> Q4.32
        a_mul[1] <= ray_dir_y_reg_stg1  * ray_dir_y_reg_stg1 ; //Q2.16 * Q2.16 -> Q4.32
        a_mul[2] <= ray_dir_z_reg_stg1  * ray_dir_z_reg_stg1 ; //Q2.16 * Q2.16 -> Q4.32

        ray_dir_stg1[0] <= ray_dir_x_reg_stg1;
        ray_dir_stg1[1] <= ray_dir_y_reg_stg1;
        ray_dir_stg1[2] <= ray_dir_z_reg_stg1;
        
        radius_sqrd_reg_stg[0] <= radius_sqrd_stg1 <<< 18;//shifting so it aligns with the Q18.18 format                                        
        
        ray_minus_origin_for_sqrd_stg1[0] <= ray_minus_origin_for_sqrd[0]; //Q9.9
        ray_minus_origin_for_sqrd_stg1[1] <= ray_minus_origin_for_sqrd[1]; //Q9.9
        ray_minus_origin_for_sqrd_stg1[2] <= ray_minus_origin_for_sqrd[2]; //Q9.9
        
        ray_minus_origin_for_b_stg1[0] <= ray_minus_origin_for_b[0]; //Q9.9
        ray_minus_origin_for_b_stg1[1] <= ray_minus_origin_for_b[1]; //Q9.9
        ray_minus_origin_for_b_stg1[2] <= ray_minus_origin_for_b[2]; //Q9.9
    end
    
    always @(posedge clk) begin
        stage_3 <= stage_2;
        
        a_intermediate <= a_mul[0] + a_mul[1]; //Q4.32 + Q4.32
        a_mul_z_stg1 <= a_mul[2]; //Q4.32
        
        radius_sqrd_reg_stg[1] <= radius_sqrd_reg_stg[0];
        
        //          Q2.16             Q9.9
        b_mul[0] <= ray_dir_stg1[0] * ray_minus_origin_for_b_stg1[0]; //Q11.25
        b_mul[1] <= ray_dir_stg1[1] * ray_minus_origin_for_b_stg1[1]; //Q11.25
        b_mul[2] <= ray_dir_stg1[2] * ray_minus_origin_for_b_stg1[2]; //Q11.25
        
        ray_minus_origin_sqrd[0] <= ray_minus_origin_for_sqrd_stg1[0]*ray_minus_origin_for_sqrd_stg1[0]; //Q9.9 * Q9.9 -> Q18.18
        ray_minus_origin_sqrd[1] <= ray_minus_origin_for_sqrd_stg1[1]*ray_minus_origin_for_sqrd_stg1[1]; //Q9.9 * Q9.9 -> Q18.18
        ray_minus_origin_sqrd[2] <= ray_minus_origin_for_sqrd_stg1[2]*ray_minus_origin_for_sqrd_stg1[2]; //Q9.9 * Q9.9 -> Q18.18
    end
    
    always @(posedge clk) begin
        stage_4 <= stage_3;
        a <= a_intermediate + a_mul_z_stg1; //Q5.32 + Q5.32
        
        c_add_1 <= ray_minus_origin_sqrd[0] + ray_minus_origin_sqrd[1]; //Q18.18 + Q18.18
        c_add_2 <= ray_minus_origin_sqrd[2] - radius_sqrd_reg_stg[1]; //Q18.18 - Q18.18
        
        b_intermediate <= b_mul[0] + b_mul[1]; //Q11.25 + Q11.25
        b_mul_z_stg1 <= b_mul[2]; //Q11.25
    end    
 
    always @(posedge clk) begin
        stage_5 <= stage_4;
        a_stg1 <= a;
        c <= c_add_1 + c_add_2; //Q19.18 + Q19.18
        b <= (b_intermediate + b_mul_z_stg1) <<< 1; //Q13.25 << 1 -> Q14.25
        //shift left by 1 means multiplying by 2
    end  
    
    always @(posedge clk) begin
        stage_6 <= stage_5;
        a_trunc[0] <= {a_stg1[37],a_stg1[32:10]}; //Q6.32 --> Q2.22 24 bits
        
        b_trunc[0] <= {b[38],b[36:14]}; //Q14.25 --> Q13.11 24 bits
        c_trunc <= {c[37],c[35:13]}; //Q20.18 --> Q19.5 24 bits
    end     
    
    always @(posedge clk) begin
        stage_7 <= stage_6;
        a_trunc[1] <= a_trunc[0];
        b_trunc[1] <= b_trunc[0];
        
        four_ac_prelim <= c_trunc * $signed({1'b0,a_trunc[0][16:0]});//lower 17 bits 
        four_ac_hprod <= c_trunc * $signed({{11{a_trunc[0][23]}}, a_trunc[0][23:17]}); //upper 7 bits and sign extension
        
        b_prelim_sqrd <= b_trunc[0] * $signed({1'b0, b_trunc[0][16:0]}); //lower 17 bits 
        b_high_prod   <= b_trunc[0] * $signed({{11{b_trunc[0][23]}}, b_trunc[0][23:17]}); //upper 7 bits
    end      
    
    always @(posedge clk) begin
        stage_8 <= stage_7;
        
        four_ac <= ($signed({four_ac_hprod[30:0], 17'b0}) + four_ac_prelim) >>> 3;
        //shifting left 2 bits to multiply by 4, then 5 shifts right 
        b_sqrd <= $signed({b_high_prod[30:0], 17'b0}) + b_prelim_sqrd; //Q26.22
        
        a_trunc[2] <= a_trunc[1];
        b_trunc[2] <= b_trunc[1];        
    end   
      
    always @(posedge clk) begin
        stage_9 <= stage_8;
        a_trunc[3] <= a_trunc[2];
        b_trunc[3] <= b_trunc[2];   
        delta <= b_sqrd - four_ac; //Q26.22 - Q26.22     
    end  
endmodule
