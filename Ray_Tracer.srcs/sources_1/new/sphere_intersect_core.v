`timescale 1ns / 1ps
`default_nettype none

module sphere_intersect_core(
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
        
    
    output reg hit_flag
    );
    //Master sphere intersection formula
    //a = Ray_Dir * Ray_Dir
    //b = 2.0 * (Ray_Dir * (Ray_origin - Sphere_origin))
    //c = (Ray_origin - Sphere_origin)*(Ray_origin - Sphere_origin) - Radius*Radius
    // DELTA  = b^2 -4ac
   
   
    t_distance_div DIV0 (
    .clk(clk),
    .stage_7(stage_7),
    .sqrt_delta(sqrt_delta),
    .a(a_trunc),
    .b(b_trunc),
    .t_distance(t_distance)
    );
   
    reg signed [24:0] t_distance;
    reg signed [24:0] sqrt_delta;
    
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
    reg stage_1, stage_2, stage_3, stage_4, stage_5, stage_6, stage_7;
    reg stage_8, stage_9, stage_10, stage_11, stage_12, stage_13, stage_14;
    
    reg signed [37:0] a; //Q6.32 need intermediate to not have long carry chain
    reg signed [37:0] a_stg1;
    reg signed [38:0] b; //Q14.25, shifting by 1 requires extra bits
    reg signed [37:0] c; //Q20.18
    
    //intermediate stages to shorten propagation delay
    reg signed [36:0] a_intermediate; //37 bits wide since adding 2 36 bit numbers could 
    reg signed [36:0] b_intermediate; //result in overflow
    
    //truncated a, b, and c to optimize for DSP usage
    reg signed [17:0] a_trunc;//Q3.15
    reg signed [23:0] b_trunc;//Q14.10
    reg signed [24:0] c_trunc;//Q20.5
    
    reg signed [47:0] b_sqrd; // 24-bit * 24-bit
    reg signed [47:0] four_ac; // 19-bit * 25-bit + 4 bit shift
    reg signed [47:0] delta; //28.20
    //combinational logic (math)
    //[0] represents x, [1] represents y, [2] represents z

    reg signed [17:0] ray_minus_origin [2:0]; //Q9.9

    reg signed [35:0] a_mul [2:0]; //Q4.32       
    reg signed [35:0] b_mul [2:0]; //Q11.25
    reg signed [36:0] c_add_1, c_add_2; //Q19.18
    
    reg signed [35:0] ray_minus_origin_sqrd [2:0];
    wire signed [7:0] radius_sqrd = object1_size*object1_size; //intenger * intenger
    
    reg signed [35:0] radius_sqrd_reg_stg1, radius_sqrd_reg_stg2; //need seperate stage registers
    reg signed [17:0] ray_dir_stg1 [2:0];
    
    reg signed [36:0] a_mul_z_stg1;
    reg signed [36:0] b_mul_z_stg1;
    
    //division wires and regs
    // Force Vivado to map this to Block RAM rather than Distributed RAM
    (* rom_style = "block" *) 
    reg signed [17:0] LUT_reciprical [0:511]; //ascending memory depth, same as mem file
    //stores 17-bit initial guesses
    //and then a sign bit
    initial begin
        $readmemh("C:/Users/herna/source/repos/Look_up_table_RT/Look_up_table_RT/LUT_file.mem", LUT_reciprical);
    end  
    
    //X := X + X × (1 - D' × X)
    reg signed [17:0] initial_x; //initial 17 bit guess + sign bit Q1.17
    reg signed [17:0] initial_x_stg1; //shifting needed to subtract
    reg signed [17:0] initial_x_stg2;
    reg signed [42:0] initial_x_stg3_shifted;
    
    reg signed [35:0] a_times_initialx; // 18bit * 18bit => 36bit Q4.32
    wire signed [35:0] number_1 = 36'sh01_0000_0000; //verilog doesn't like numbers larger than 32 bits
    reg signed [35:0] one_minus_ax; //1 - D * X
    reg signed [42:0] x_times_oax;//x times 1 minus a times x
    reg signed [43:0] refined_x; //refined 44 bit reciprical
    
    always @(posedge clk) begin
        stage_1 <= start_core;
        if(start_core) begin
            a_mul[0] <= ray_dir_x * ray_dir_x; //Q2.16 * Q2.16 -> Q4.32
            a_mul[1] <= ray_dir_y * ray_dir_y; //Q2.16 * Q2.16 -> Q4.32
            a_mul[2] <= ray_dir_z * ray_dir_z; //Q2.16 * Q2.16 -> Q4.32

            ray_dir_stg1[0] <= ray_dir_x;
            ray_dir_stg1[1] <= ray_dir_y;
            ray_dir_stg1[2] <= ray_dir_z;
            
            radius_sqrd_reg_stg1 <= radius_sqrd <<< 18;//shifting so it aligns with the Q18.18 format
                                                       
            
            ray_minus_origin[0] <= camera_x - object1_x; //Q9.9
            ray_minus_origin[1] <= camera_y - object1_y; //Q9.9
            ray_minus_origin[2] <= camera_z - object1_z; //Q9.9
            
        end
    end
    
    always @(posedge clk) begin
        stage_2 <= stage_1;
        if(stage_1) begin
        
            a_intermediate <= a_mul[0] + a_mul[1]; //Q4.32 + Q4.32
            a_mul_z_stg1 <= a_mul[2]; //Q4.32
            
            radius_sqrd_reg_stg2 <= radius_sqrd_reg_stg1;
            
            //          Q2.16             Q9.9
            b_mul[0] <= ray_dir_stg1[0] * ray_minus_origin[0]; //Q11.25
            b_mul[1] <= ray_dir_stg1[1] * ray_minus_origin[1]; //Q11.25
            b_mul[2] <= ray_dir_stg1[2] * ray_minus_origin[2]; //Q11.25
            
            ray_minus_origin_sqrd[0] <= ray_minus_origin[0]*ray_minus_origin[0]; //Q9.9 * Q9.9 -> Q18.18
            ray_minus_origin_sqrd[1] <= ray_minus_origin[1]*ray_minus_origin[1]; //Q9.9 * Q9.9 -> Q18.18
            ray_minus_origin_sqrd[2] <= ray_minus_origin[2]*ray_minus_origin[2]; //Q9.9 * Q9.9 -> Q18.18
            
        end
    end
    
    always @(posedge clk) begin
        stage_3 <= stage_2;
        if(stage_2) begin
            a <= a_intermediate + a_mul_z_stg1; //Q5.32 + Q5.32
            
            c_add_1 <= ray_minus_origin_sqrd[0] + ray_minus_origin_sqrd[1]; //Q18.18 + Q18.18
            c_add_2 <= ray_minus_origin_sqrd[2] - radius_sqrd_reg_stg2; //Q18.18 - Q18.18
            
            b_intermediate <= b_mul[0] + b_mul[1]; //Q11.25 + Q11.25
            b_mul_z_stg1 <= b_mul[2]; //Q11.25
        end
    end    
 
    always @(posedge clk) begin
        stage_4 <= stage_3;
        if(stage_3) begin
            a_stg1 <= a;
            c <= c_add_1 + c_add_2; //Q19.18 + Q19.18
            b <= (b_intermediate + b_mul_z_stg1) <<< 1; //Q13.25 << 1 -> Q14.25
            //shift left by 1 means multiplying by 2
            
            //load reciprical estimate early using 9 decimal bits
            //always positive so don't worry about sign bit            
            initial_x <= LUT_reciprical[a[31:23]];
        end
    end  
    
    always @(posedge clk) begin
        stage_5 <= stage_4;
        if(stage_4) begin
            a_trunc <= {a_stg1[37],a_stg1[33:17]}; //Q6.32 --> Q3.15
            b_trunc <= b[38:15]; //Q14.25 --> Q14.10
            c_trunc <= c[37:13]; //Q20.18 --> Q20.5 -> will use 25bit DSP input
            
            //wait one clock cycle for bram to load data to initial_x
        end
    end     
    
    always @(posedge clk) begin
        stage_6 <= stage_5;
        if(stage_5) begin
            four_ac <= (a_trunc * c_trunc) <<< 2; //Q3.15 * Q20.5 -> Q23.20 <<< 2 -> Q25.20 -> four_ac is a 48 bit so it gets sign extended
            //shifting 2 bits to multiply by 4
            b_sqrd <= b_trunc * b_trunc; //Q14.10 * Q14.10
            
            a_times_initialx <= a_trunc * initial_x; //Q4.32               
            initial_x_stg1 <= initial_x;         
        end
    end      
    
    always @(posedge clk) begin
        stage_7 <= stage_6;
        if(stage_6) begin
            delta <= b_sqrd - four_ac; //Q28.20 - Q28.20
            
             //              1 in Q4.32 format
            one_minus_ax <= number_1 - a_times_initialx;
            initial_x_stg2 <= initial_x_stg1;              
            
        end
    end     
    
    always @(posedge clk) begin
        stage_8 <= stage_7;
        
        hit_flag <= 1'b0;//fix this later
        if(delta[47] == 1'b0 && stage_7) begin
            hit_flag <= 1'b1;
        end
        
        if(stage_7) begin
            // 25x18 --> One DSP slice! (Hopefully)
            //Q1.24 * Q1.17 => Q2.41
            x_times_oax <= $signed({one_minus_ax[35],one_minus_ax[31:8]}) * initial_x_stg2;
            initial_x_stg3_shifted <= initial_x_stg2 <<< 24;
        end
    end    
    
    always @(posedge clk) begin
        stage_9 <= stage_8;
        if(stage_8) begin     
            refined_x <= initial_x_stg3_shifted + x_times_oax; //Q3.41
        end  
    end    
    
endmodule
