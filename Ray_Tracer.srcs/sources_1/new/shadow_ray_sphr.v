`timescale 1ns / 1ps

module shadow_ray_sphr(
    input wire clk,            
    input wire [127:0] object1,
    input wire [127:0] object2,
    input wire input_hit_flag,
    
    //hit and normal engine inputs
    input wire [53:0] normal_packed,
    input wire [74:0] hit_point_packed,
    input wire module_done,
    
    //vga controller connections
    output wire [3:0] red,
    output wire [3:0] green,
    output wire [3:0] blue,
    output wire valid_hit      
    );
    
    
    
    light_sqrt SQRT0 (
    .clk(clk),
    .light_normal_done(stage_5),
    .magnitude_sqrd(magnitude_sqrd[49:2]), //48bits Q22.26
    .square_root(magnitude_sqrt),// Q11.13
    .done(sqrt_done)
    );
    
    wire recip_hit_flag;
    wire sqrt_done;
    wire [23:0] magnitude_sqrt; //not signed because you can't have negative square roots Q11.13 
    wire signed [24:0] magnitude_recip; //Q9.16
    wire div_done;   
     
    reciprocal_module RPM0 (
    .clk(clk),                                 
    .sqrt_done(sqrt_done),                           
    .sqrt_light(magnitude_sqrt), //Q11.13                                     
    .reciprocal(magnitude_recip), //Q9.16    
    .div_done(div_done),                           
    .output_hit(recip_hit_flag)      
    );


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
    
    reg stage_0, stage_1, stage_2, stage_3;
    reg stage_4, stage_5, stage_6;    
    
    reg signed [24:0] hit_point_pipeline [2:0]; //unpacking hit point back to x, y, z cordinates
    
    reg signed [17:0] normal_pipeline1 [2:0]; //transfer the normal throughout the pipeline
    reg signed [17:0] normal_pipeline2 [2:0];
    reg signed [17:0] normal_pipeline3 [2:0];
    reg signed [17:0] normal_pipeline4 [2:0];
    reg signed [17:0] normal_pipeline5 [2:0];
    reg signed [17:0] normal_pipeline6 [2:0];
    
    reg signed [17:0] object_2_cords [2:0];
    
    reg signed [24:0] light_sub [2:0]; //light_loc - hitpoint, could use an extra bit for overflow but don't want to use 3DSPs
    reg signed [24:0] light_sub_pipe1 [2:0];
    reg signed [24:0] light_sub_pipe2 [2:0];
    reg signed [24:0] light_sub_pipe3 [2:0];
    reg signed [24:0] light_sub_pipe4 [2:0];
    
    
    reg signed [42:0] magnitude_sqrd_lwrbits [2:0];
    reg signed [42:0] magnitude_sqrd_upprbits [2:0];
    reg signed [50:0] magnitude_sqrd_prelim [2:0]; 
    reg signed [51:0] magnitude_sqrd_a; 
    reg signed [50:0] magnitude_sqrd_z_delayed;
    reg signed [52:0] magnitude_sqrd; //final number 25 bity + 25 bit + 3 overflow bit Q25.28
    //will feed sqrt module Q22.26 so it outputs -> Q11.13
    reg hit_flag_pipe [5:0];
    
    always @(posedge clk) begin
        stage_0 <= module_done;
        hit_flag_pipe[0] <= input_hit_flag;
        //catching all the inputs before doing math on them
        hit_point_pipeline[0] <= hit_point_packed[74:50];//x Q11.14
        hit_point_pipeline[1] <= hit_point_packed[49:25];//y Q11.14
        hit_point_pipeline[2] <= hit_point_packed[24:0]; //z Q11.14
        
        normal_pipeline1[0] <= normal_packed[53:36];//x Q2.16
        normal_pipeline1[1] <= normal_packed[35:18];//y Q2.16
        normal_pipeline1[2] <= normal_packed[17:0]; //z Q2.16
        
        object_2_cords [0] <= object2_x;//Q9.9
        object_2_cords [1] <= object2_y;//Q9.9
        object_2_cords [2] <= object2_z;//Q9.9
        
    end
    
    always @(posedge clk) begin
        stage_1 <= stage_0;
        hit_flag_pipe[1] <= hit_flag_pipe[0];
        normal_pipeline2[0] <= normal_pipeline1[0];
        normal_pipeline2[1] <= normal_pipeline1[1];
        normal_pipeline2[2] <= normal_pipeline1[2];
        
        light_sub[0] <= $signed({{2{object_2_cords[0][17]}},object_2_cords[0],5'd0}) - hit_point_pipeline[0];//Q11.14
        light_sub[1] <= $signed({{2{object_2_cords[1][17]}},object_2_cords[1],5'd0}) - hit_point_pipeline[1];//Q11.14  
        light_sub[2] <= $signed({{2{object_2_cords[2][17]}},object_2_cords[2],5'd0}) - hit_point_pipeline[2];//Q11.14  
         
    end
  
    always @(posedge clk) begin
        stage_2 <= stage_1;
        hit_flag_pipe[2] <= hit_flag_pipe[1];
        light_sub_pipe1[0] <= light_sub[0];
        light_sub_pipe1[1] <= light_sub[1];
        light_sub_pipe1[2] <= light_sub[2];
        normal_pipeline3[0] <= normal_pipeline2[0];
        normal_pipeline3[1] <= normal_pipeline2[1];
        normal_pipeline3[2] <= normal_pipeline2[2];
        
        //lower 17 bits
        magnitude_sqrd_lwrbits [0] <= light_sub[0] * $signed({1'b0,light_sub[0][16:0]});// 25+18, all 43 bits are valid
        magnitude_sqrd_lwrbits [1] <= light_sub[1] * $signed({1'b0,light_sub[1][16:0]});// 25+18, all 43 bits are valid
        magnitude_sqrd_lwrbits [2] <= light_sub[2] * $signed({1'b0,light_sub[2][16:0]});// 25+18, all 43 bits are valid
        
        //uppper 8 bits
        magnitude_sqrd_upprbits [0] <= light_sub[0] * $signed({{10{light_sub[0][24]}},light_sub[0][24:17]}); //only 25+8 bits are valid
        magnitude_sqrd_upprbits [1] <= light_sub[1] * $signed({{10{light_sub[1][24]}},light_sub[1][24:17]}); //so 33 bits
        magnitude_sqrd_upprbits [2] <= light_sub[2] * $signed({{10{light_sub[2][24]}},light_sub[2][24:17]});
    
    end
    
    always @(posedge clk) begin
        stage_3 <= stage_2;
        hit_flag_pipe[3] <= hit_flag_pipe[2];
        light_sub_pipe2[0] <= light_sub_pipe1[0];
        light_sub_pipe2[1] <= light_sub_pipe1[1];
        light_sub_pipe2[2] <= light_sub_pipe1[2];
        normal_pipeline4[0] <= normal_pipeline3[0];
        normal_pipeline4[1] <= normal_pipeline3[1];
        normal_pipeline4[2] <= normal_pipeline3[2];
        
        //50 bit + overflow bit
        magnitude_sqrd_prelim[0] <= $signed({magnitude_sqrd_upprbits[0][32:0], 17'd0}) + $signed({{8{magnitude_sqrd_lwrbits[0][42]}}, magnitude_sqrd_lwrbits[0]});//Q23.28
        magnitude_sqrd_prelim[1] <= $signed({magnitude_sqrd_upprbits[1][32:0], 17'd0}) + $signed({{8{magnitude_sqrd_lwrbits[1][42]}}, magnitude_sqrd_lwrbits[1]});//Q23.28
        magnitude_sqrd_prelim[2] <= $signed({magnitude_sqrd_upprbits[2][32:0], 17'd0}) + $signed({{8{magnitude_sqrd_lwrbits[2][42]}}, magnitude_sqrd_lwrbits[2]});//Q23.28
        
    end
    
    always @(posedge clk) begin
        stage_4 <= stage_3;
        hit_flag_pipe[4] <= hit_flag_pipe[3];
        light_sub_pipe3[0] <= light_sub_pipe2[0];
        light_sub_pipe3[1] <= light_sub_pipe2[1];
        light_sub_pipe3[2] <= light_sub_pipe2[2];
        normal_pipeline5[0] <= normal_pipeline4[0];
        normal_pipeline5[1] <= normal_pipeline4[1];
        normal_pipeline5[2] <= normal_pipeline4[2];
        
        magnitude_sqrd_a <= magnitude_sqrd_prelim[0] + magnitude_sqrd_prelim[1];
        magnitude_sqrd_z_delayed <= magnitude_sqrd_prelim[2];
        
    end
    
    always @(posedge clk) begin
        stage_5 <= stage_4;
        hit_flag_pipe[5] <= hit_flag_pipe[4];
        light_sub_pipe4[0] <= light_sub_pipe3[0];
        light_sub_pipe4[1] <= light_sub_pipe3[1];
        light_sub_pipe4[2] <= light_sub_pipe3[2];
        normal_pipeline6[0] <= normal_pipeline5[0];
        normal_pipeline6[1] <= normal_pipeline5[1];
        normal_pipeline6[2] <= normal_pipeline5[2];
        
        //need to add a valid flag
        magnitude_sqrd <= magnitude_sqrd_a + magnitude_sqrd_z_delayed;
        // from here go to light_sqrt module
    end
    
    localparam DELAY_CYCLES = 52;
    
    (* shreg_extract = "yes" *)
    reg signed [24:0] light_vec_x_delay [DELAY_CYCLES-1:0];
    
    (* shreg_extract = "yes" *)                            
    reg signed [24:0] light_vec_y_delay [DELAY_CYCLES-1:0];
    
    (* shreg_extract = "yes" *)                            
    reg signed [24:0] light_vec_z_delay [DELAY_CYCLES-1:0];
    
    (* shreg_extract = "yes" *)                            
    reg hit_flag_delay [DELAY_CYCLES-1:0];
    
    (* shreg_extract = "yes" *)                            
    reg signed [17:0] normal_x_delay [DELAY_CYCLES-1:0];
                                                           
    (* shreg_extract = "yes" *)                            
    reg signed [17:0] normal_y_delay [DELAY_CYCLES-1:0];
                                                           
    (* shreg_extract = "yes" *)                            
    reg signed [17:0] normal_z_delay [DELAY_CYCLES-1:0];

    integer i;
    always @(posedge clk) begin
        hit_flag_delay[0] <= hit_flag_pipe[5];
    
        light_vec_x_delay[0] <= light_sub_pipe4[0];
        light_vec_y_delay[0] <= light_sub_pipe4[1];
        light_vec_z_delay[0] <= light_sub_pipe4[2];
        
        normal_x_delay[0] <= normal_pipeline6[0];
        normal_y_delay[0] <= normal_pipeline6[1];
        normal_z_delay[0] <= normal_pipeline6[2];
        
        for (i = 0; i < DELAY_CYCLES - 1; i = i + 1) begin
            hit_flag_delay[i+1] <= hit_flag_delay[i];
        
            light_vec_x_delay[i+1] <= light_vec_x_delay[i];
            light_vec_y_delay[i+1] <= light_vec_y_delay[i];
            light_vec_z_delay[i+1] <= light_vec_z_delay[i];
            
            normal_x_delay[i+1] <= normal_x_delay[i];
            normal_y_delay[i+1] <= normal_y_delay[i];
            normal_z_delay[i+1] <= normal_z_delay[i];
        end
    end

    reg stage_7, stage_8, stage_9, stage_10;
    reg stage_11, stage_12, stage_13, stage_14;
    reg stage_15, stage_16, stage_17;

    reg hit_flag_delayed_pipe [9:0];
       
    reg signed [24:0] magnitude_reciprocal_reg; //Q9.16
    reg signed [24:0] light_vector_reg [2:0]; //Q11.14
    reg signed [17:0] normal_delayed_pipeline1 [2:0];
    reg signed [17:0] normal_delayed_pipeline2 [2:0];
    reg signed [17:0] normal_delayed_pipeline3 [2:0];
    reg signed [17:0] normal_delayed_pipeline4 [2:0];
    
    reg signed [42:0] light_vector_prelim_lwr [2:0];
    reg signed [42:0] light_vector_prelim_uppr [2:0];
    
    reg signed [50:0] light_vector_norm [2:0];//Q20:30 + overflow bit
    reg signed [17:0] light_vector_norm_trunc [2:0]; //Q2.16, the ized light vector will be bounded between -1 and 1
    
    reg signed [35:0] lambertian_intensity [2:0]; //normal x light_dir
    reg signed [36:0] lamb_intensity_add_xy;
    reg signed [35:0] lamb_intensity_delay_z;
    
    reg signed [37:0] final_lamb_intensity; //Q6.32, needed 2 overflow bits
    
    always @(posedge clk) begin
        stage_7 <= div_done;
        hit_flag_delayed_pipe[0] <= hit_flag_delay[DELAY_CYCLES-1];
        
        normal_delayed_pipeline1[0] <= normal_x_delay[DELAY_CYCLES - 1];
        normal_delayed_pipeline1[1] <= normal_y_delay[DELAY_CYCLES - 1];
        normal_delayed_pipeline1[2] <= normal_z_delay[DELAY_CYCLES - 1];
        
        if(div_done) magnitude_reciprocal_reg <= magnitude_recip;
        else magnitude_reciprocal_reg <= 25'd0;
        
        light_vector_reg[0] <= light_vec_x_delay[DELAY_CYCLES-1];
        light_vector_reg[1] <= light_vec_y_delay[DELAY_CYCLES-1];
        light_vector_reg[2] <= light_vec_z_delay[DELAY_CYCLES-1]; 
        
    end

    always @(posedge clk) begin
        stage_8 <= stage_7;
        hit_flag_delayed_pipe[1] <= hit_flag_delayed_pipe[0];
        
        normal_delayed_pipeline2[0] <= normal_delayed_pipeline1[0];
        normal_delayed_pipeline2[1] <= normal_delayed_pipeline1[1];
        normal_delayed_pipeline2[2] <= normal_delayed_pipeline1[2];
        
        //lower 17 bits
        light_vector_prelim_lwr[0] <= magnitude_reciprocal_reg * $signed({1'b0,light_vector_reg[0][16:0]});// 25+18, all 43 bits are valid
        light_vector_prelim_lwr[1] <= magnitude_reciprocal_reg * $signed({1'b0,light_vector_reg[1][16:0]});// 25+18, all 43 bits are valid
        light_vector_prelim_lwr[2] <= magnitude_reciprocal_reg * $signed({1'b0,light_vector_reg[2][16:0]});// 25+18, all 43 bits are valid
        
        //uppper 8 bits
        light_vector_prelim_uppr[0] <= magnitude_reciprocal_reg * $signed({{10{light_vector_reg[0][24]}},light_vector_reg[0][24:17]}); //only 25+8 bits are valid
        light_vector_prelim_uppr[1] <= magnitude_reciprocal_reg * $signed({{10{light_vector_reg[1][24]}},light_vector_reg[1][24:17]}); //so 33 bits
        light_vector_prelim_uppr[2] <= magnitude_reciprocal_reg * $signed({{10{light_vector_reg[2][24]}},light_vector_reg[2][24:17]});        
        
        
    end

    always @(posedge clk) begin
        stage_9 <= stage_8;
        hit_flag_delayed_pipe[2] <= hit_flag_delayed_pipe[1];
        
        normal_delayed_pipeline3[0] <= normal_delayed_pipeline2[0];
        normal_delayed_pipeline3[1] <= normal_delayed_pipeline2[1];
        normal_delayed_pipeline3[2] <= normal_delayed_pipeline2[2];
        
        //Q21.30
        light_vector_norm[0] <= $signed({light_vector_prelim_uppr[0][32:0], 17'd0}) + $signed({{8{light_vector_prelim_lwr[0][42]}}, light_vector_prelim_lwr[0]});
        light_vector_norm[1] <= $signed({light_vector_prelim_uppr[1][32:0], 17'd0}) + $signed({{8{light_vector_prelim_lwr[1][42]}}, light_vector_prelim_lwr[1]});
        light_vector_norm[2] <= $signed({light_vector_prelim_uppr[2][32:0], 17'd0}) + $signed({{8{light_vector_prelim_lwr[2][42]}}, light_vector_prelim_lwr[2]});
    
    end

    always @(posedge clk) begin
        stage_10 <= stage_9;
        hit_flag_delayed_pipe[3] <= hit_flag_delayed_pipe[2];    
        
        normal_delayed_pipeline4[0] <= normal_delayed_pipeline3[0];//Q2.16
        normal_delayed_pipeline4[1] <= normal_delayed_pipeline3[1];//Q2.16
        normal_delayed_pipeline4[2] <= normal_delayed_pipeline3[2];//Q2.16
    
        light_vector_norm_trunc[0] <= light_vector_norm[0][31:14]; //Q2.16
        light_vector_norm_trunc[1] <= light_vector_norm[1][31:14]; //since they are normalized, everything after the 
        light_vector_norm_trunc[2] <= light_vector_norm[2][31:14]; //first interger bit is a sign bit
    end
    
    always @(posedge clk) begin
        stage_11 <= stage_10;
        hit_flag_delayed_pipe[4] <= hit_flag_delayed_pipe[3]; 
        
        lambertian_intensity[0] <= normal_delayed_pipeline4[0] * light_vector_norm_trunc[0];//Q2.16 * Q2.16 = Q4.32
        lambertian_intensity[1] <= normal_delayed_pipeline4[1] * light_vector_norm_trunc[1];//Q2.16 * Q2.16 = Q4.32
        lambertian_intensity[2] <= normal_delayed_pipeline4[2] * light_vector_norm_trunc[2];//Q2.16 * Q2.16 = Q4.32
    
    end
    
    always @(posedge clk) begin
        stage_12 <= stage_11;
        hit_flag_delayed_pipe[5] <= hit_flag_delayed_pipe[4]; 
        lamb_intensity_add_xy <= lambertian_intensity[0] + lambertian_intensity[1];
        lamb_intensity_delay_z <= lambertian_intensity[2];
    
    end

    always @(posedge clk) begin
        stage_13 <= stage_12;
        hit_flag_delayed_pipe[6] <= hit_flag_delayed_pipe[5]; 

        final_lamb_intensity <= lamb_intensity_add_xy + lamb_intensity_delay_z;
    end
    
    wire is_negative = final_lamb_intensity[37];
    wire greater_than_one = |final_lamb_intensity[36:32]; //bitwise OR, if any of the intenger bits are 1
    
    // 1. Raw Lambertian Intensity (0.0 to 1.0)
    wire [17:0] raw_intensity = is_negative ? 18'd0 : greater_than_one ? 18'd131072 : {1'b0, final_lamb_intensity[31:15]};
    
    // 2. Scale the dynamic range by 75% using bit shifts (50% + 25%)
    // This perfectly shrinks the curve so it fits the new ambient floor
    wire [17:0] scaled_intensity = (raw_intensity >> 1) + (raw_intensity >> 2);
    
    // 3. Inject 25% Ambient Light (0.25 * 131072 = 32768)
    // Max value is exactly 1.0 (98304 + 32768 = 131072), meaning no overflow clamping needed!
    wire [17:0] intensity = scaled_intensity + 18'd32768;
    
    reg [17:0] intensity_reg; 
    reg [17:0] intensity_reg_pipe1;

    
    reg [3:0] object1_color_channels [2:0]; //RGB
    reg [3:0] object2_color_channels [2:0];
    reg [20:0] colors_prelim [2:0]; //Q4.17
    reg [3:0] colors_trunc [2:0];// using top integer bits, floor operation
    
    always @(posedge clk) begin
        stage_14 <= stage_13;
        hit_flag_delayed_pipe[7] <= hit_flag_delayed_pipe[6]; 
        
        if(stage_13) intensity_reg <= intensity;
        else intensity_reg <= 18'd0;
        
        object1_color_channels[0] <= object1_color[11:8];
        object1_color_channels[1] <= object1_color[7:4];
        object1_color_channels[2] <= object1_color[3:0];
        
        object2_color_channels[0] <= object2_color[11:8]; //light source color
        object2_color_channels[1] <= object2_color[7:4];
        object2_color_channels[2] <= object2_color[3:0];
             
    end
    
    always @(posedge clk) begin
        stage_15 <= stage_14;
        hit_flag_delayed_pipe[8] <= hit_flag_delayed_pipe[7]; 
        
        //calculating without light source color for now
        intensity_reg_pipe1 <= intensity_reg;
        
        colors_prelim[0] <= object1_color_channels[0] * intensity_reg; //Red Q4.17
        colors_prelim[1] <= object1_color_channels[1] * intensity_reg; //Green
        colors_prelim[2] <= object1_color_channels[2] * intensity_reg; //Blue
        
    
    end
    
    always @(posedge clk) begin
        stage_16 <= stage_15;
        hit_flag_delayed_pipe[9] <= hit_flag_delayed_pipe[8]; 
        
        // Evaluate the truncation first, then apply the ambient floor
//        colors_trunc[0] <= (colors_prelim[0][20:17] == 4'h0) ? 4'h1 : colors_prelim[0][20:17];
//        colors_trunc[1] <= (colors_prelim[1][20:17] == 4'h0) ? 4'h1 : colors_prelim[1][20:17];
//        colors_trunc[2] <= (colors_prelim[2][20:17] == 4'h0) ? 4'h1 : colors_prelim[2][20:17];
        colors_trunc[0] <= colors_prelim[0][20:17];
        colors_trunc[1] <= colors_prelim[1][20:17];
        colors_trunc[2] <= colors_prelim[2][20:17];


    end
        
    assign valid_hit = hit_flag_delayed_pipe[9];
    assign red = colors_trunc[0];
    assign green = colors_trunc[1];
    assign blue = colors_trunc[2];
    
endmodule
