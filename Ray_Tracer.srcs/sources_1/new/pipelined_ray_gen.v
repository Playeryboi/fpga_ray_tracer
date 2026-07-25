`timescale 1ns / 1ps
`default_nettype none
//will generate a new ray per pixel
//following modules will need to keep up with the ray generation

module pipelined_ray_gen(
    input wire clk,
    input wire render,
    input wire setup_done,
    
    input wire signed [31:0] D_top_left_x,
    input wire signed [31:0] D_top_left_y,
    input wire signed [31:0] D_top_left_z,
    
    input wire signed [31:0] delta_u_x,
    input wire signed [31:0] delta_u_y,
    input wire signed [31:0] delta_u_z,  
      
    input wire signed [31:0] delta_v_x,
    input wire signed [31:0] delta_v_y,
    input wire signed [31:0] delta_v_z,
    //double check if wires can be 18 bit or have to be larger
    output reg signed [17:0] ray_dir_x,
    output reg signed [17:0] ray_dir_y,
    output reg signed [17:0] ray_dir_z      
    );
    
    
    wire signed [17:0] D_tplft_truncated [2:0];
    //Q2.16 format 1 sign, 1 decimal, and 16 fractional bits
    assign D_tplft_truncated[0] = D_top_left_x[17:0];
    assign D_tplft_truncated[1] = D_top_left_y[17:0];
    assign D_tplft_truncated[2] = D_top_left_z[17:0];
    //Q2.16 format 1 sign, 1 decimal, and 16 fractional bits
    wire signed [17:0] delta_u_truncated [2:0];
    assign delta_u_truncated[0] = delta_u_x[17:0];
    assign delta_u_truncated[1] = delta_u_y[17:0];
    assign delta_u_truncated[2] = delta_u_z[17:0];    
    //Q2.16 format 1 sign, 1 decimal, and 16 fractional bits
    wire signed [17:0] delta_v_truncated [2:0];
    assign delta_v_truncated[0] = delta_v_x[17:0];
    assign delta_v_truncated[1] = delta_v_y[17:0];
    assign delta_v_truncated[2] = delta_v_z[17:0];  
    
    reg signed [17:0] delta_u_offset [2:0];
    reg signed [17:0] delta_v_offset [2:0];
    
    reg signed [10:0] horz_counter = 0;
    reg signed [10:0] vert_counter = 0;
    
    reg ready = 0;
    
    initial begin
        delta_u_offset[0] = 18'sd0; delta_u_offset[1] = 18'sd0; delta_u_offset[2] = 18'sd0;
        delta_v_offset[0] = 18'sd0; delta_v_offset[1] = 18'sd0; delta_v_offset[2] = 18'sd0;
    end

    //The Accumulator & Counter Block
    always @(posedge clk) begin       
        if (setup_done && render) begin
            // Horizontal Logic
            // If we are actively drawing a row, add delta_u every clock cycle
            if (horz_counter < 10'd639) begin
                horz_counter <= horz_counter + 1;
                
                delta_u_offset[0] <= delta_u_offset[0] + delta_u_truncated[0];
                delta_u_offset[1] <= delta_u_offset[1] + delta_u_truncated[1];
                delta_u_offset[2] <= delta_u_offset[2] + delta_u_truncated[2];
            end 
            // End of the row!
            else begin
                horz_counter <= 0;
                
                // Reset horizontal offset back to the left edge of the screen
                delta_u_offset[0] <= 18'sd0;
                delta_u_offset[1] <= 18'sd0;
                delta_u_offset[2] <= 18'sd0;
                
                // 3. Vertical Logic (Only triggers at the end of a row)
                if (vert_counter < 10'd479) begin
                    vert_counter <= vert_counter + 1;
                    
                    // Step down one row
                    delta_v_offset[0] <= delta_v_offset[0] + delta_v_truncated[0];
                    delta_v_offset[1] <= delta_v_offset[1] + delta_v_truncated[1];
                    delta_v_offset[2] <= delta_v_offset[2] + delta_v_truncated[2];
                end 
                // End of the frame!
                else begin
                    vert_counter <= 0;
                    
                    // Reset vertical offset back to the top of the screen
                    delta_v_offset[0] <= 18'sd0;
                    delta_v_offset[1] <= 18'sd0;
                    delta_v_offset[2] <= 18'sd0;
                end
            end
        end 
        else if (!setup_done) begin
            // If setup_done drops, reset the screen counters so we are ready for the next frame
            horz_counter <= 0;
            vert_counter <= 0;
            delta_u_offset[0] <= 18'sd0; delta_u_offset[1] <= 18'sd0; delta_u_offset[2] <= 18'sd0;
            delta_v_offset[0] <= 18'sd0; delta_v_offset[1] <= 18'sd0; delta_v_offset[2] <= 18'sd0;
        end
    end

    //Final Ray Addition
    always @(posedge clk) begin
        ray_dir_x <= D_tplft_truncated[0] + delta_u_offset[0] + delta_v_offset[0];
        ray_dir_y <= D_tplft_truncated[1] + delta_u_offset[1] + delta_v_offset[1];
        ray_dir_z <= D_tplft_truncated[2] + delta_u_offset[2] + delta_v_offset[2];      
    end 
endmodule


