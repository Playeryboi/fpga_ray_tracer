`timescale 1ns / 1ps

module shadow_ray_sphr(
    input wire clk,            
    input wire [127:0] object1,
    input wire [127:0] object2,
    input wire input_hit_flag,
    
    //hit and normal engine inputs
    input wire [53:0] normal_packed,
    input wire [74:0] hit_point_packed,
    input wire module_done      
    );
    
    
    light_sqrt SQRT0 (
    .clk(clk),
    .light_normal_done(stage_5),
    .magnitude_sqrd(magnitude_sqrd[49:2]), //48bits Q22.26
    .square_root(magnitude_sqrt),// Q11.13
    .done(sqrt_done)
    );
    
    wire recip_hit_flag;
    wire div_done;
    wire [24:0] magnitude_recip;
    wire [23:0] magnitude_sqrt; //not signed because you can't have negative square roots
    wire sqrt_done;
        
    reciprocal_module RPM0 (
    .clk(clk),                                 
    .sqrt_done(sqrt_done),                           
    .sqrt_light(magnitude_sqrt), //Q11.13                                     
    .reciprocal(magnitude_recip), //Q9.16    
    .div_done(div_done),                           
    .output_hit(recip_hit_flag)      
    );

    
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
    reg signed [17:0] normal_pipeline [2:0];
    reg signed [17:0] object_2_cords [2:0];
    
    reg signed [24:0] light_sub [2:0]; //light_loc - hitpoint, could use an extra bit for overflow but don't want to use 3DSPs
    
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
        
        normal_pipeline[0] <= normal_packed[53:36];//x Q2.16
        normal_pipeline[1] <= normal_packed[35:18];//y Q2.16
        normal_pipeline[2] <= normal_packed[17:0]; //z Q2.16
        
        object_2_cords [0] <= object2_x;//Q9.9
        object_2_cords [1] <= object2_y;//Q9.9
        object_2_cords [2] <= object2_z;//Q9.9
        
    end
    
    always @(posedge clk) begin
        stage_1 <= stage_0;
        hit_flag_pipe[1] <= hit_flag_pipe[0];
        
        light_sub[0] <= $signed({{2{object_2_cords[0][17]}},object_2_cords[0],5'd0}) - hit_point_pipeline[0];//Q11.14
        light_sub[1] <= $signed({{2{object_2_cords[1][17]}},object_2_cords[1],5'd0}) - hit_point_pipeline[1];//Q11.14  
        light_sub[2] <= $signed({{2{object_2_cords[2][17]}},object_2_cords[2],5'd0}) - hit_point_pipeline[2];//Q11.14  
         
    end
  
    always @(posedge clk) begin
        stage_2 <= stage_1;
        hit_flag_pipe[2] <= hit_flag_pipe[1];
    
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
        //50 bit + overflow bit
        magnitude_sqrd_prelim[0] <= $signed({magnitude_sqrd_upprbits[0][32:0], 17'd0}) + $signed({{8{magnitude_sqrd_lwrbits[0][42]}}, magnitude_sqrd_lwrbits[0]});//Q23.28
        magnitude_sqrd_prelim[1] <= $signed({magnitude_sqrd_upprbits[1][32:0], 17'd0}) + $signed({{8{magnitude_sqrd_lwrbits[1][42]}}, magnitude_sqrd_lwrbits[1]});//Q23.28
        magnitude_sqrd_prelim[2] <= $signed({magnitude_sqrd_upprbits[2][32:0], 17'd0}) + $signed({{8{magnitude_sqrd_lwrbits[2][42]}}, magnitude_sqrd_lwrbits[2]});//Q23.28
        
    end
    
    always @(posedge clk) begin
        stage_4 <= stage_3;
        hit_flag_pipe[4] <= hit_flag_pipe[3];
        
        magnitude_sqrd_a <= magnitude_sqrd_prelim[0] + magnitude_sqrd_prelim[1];
        magnitude_sqrd_z_delayed <= magnitude_sqrd_prelim[2];
        
    end
    
    always @(posedge clk) begin
        stage_5 <= stage_4;
        hit_flag_pipe[5] <= hit_flag_pipe[4];
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

    integer i;
    always @(posedge clk) begin
        hit_flag_delay[0] <= hit_flag_pipe[5];
    
        light_vec_x_delay[0] <= light_sub[0];
        light_vec_y_delay[0] <= light_sub[1];
        light_vec_z_delay[0] <= light_sub[2];
        
        for (i = 0; i < DELAY_CYCLES - 1; i = i + 1) begin
            hit_flag_delay[i+1] <= hit_flag_delay[i];
        
            light_vec_x_delay[i+1] <= light_vec_x_delay[i];
            light_vec_y_delay[i+1] <= light_vec_y_delay[i];
            light_vec_z_delay[i+1] <= light_vec_z_delay[i];
        end
    end

    wire hit_flag_delayed = hit_flag_delay[DELAY_CYCLES-1];
    wire signed [24:0] light_sub_delayed_x = light_vec_x_delay[DELAY_CYCLES-1];
    wire signed [24:0] light_sub_delayed_y = light_vec_y_delay[DELAY_CYCLES-1];
    wire signed [24:0] light_sub_delayed_z = light_vec_z_delay[DELAY_CYCLES-1];
    
    

endmodule
