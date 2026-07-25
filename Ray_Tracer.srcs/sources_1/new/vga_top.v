`timescale 1ns / 1ps
`default_nettype none

module vga_top(
    input wire clk,
    input wire hit_flag,
    output wire VGA_HS,
    output wire VGA_VS,
    input wire[3:0] red_in,
    input wire[3:0] green_in,
    input wire[3:0] blue_in,
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B,
    output wire [9:0] horz_value,
    output wire [9:0] vert_value,
    output wire render,
    output wire new_frame,
    output wire frame_start  
    );
    
    
    //instantiating horizontal and vertical counter, reference 480p timing diagram
    wire V_enable;
    horz_counter horz_unit1 (.clk_25Mhz(clk), .horz_value(horz_value), .enable_V_counter(V_enable));
    vert_counter vert_unit1 (.clk_25Mhz(clk), .vert_value(vert_value), .enable_V_counter(V_enable));
    
    //output sync signals
    // They MUST be Active-Low (1'b0 during the sync window)
    assign VGA_HS = (horz_value < 96) ? 1'b0 : 1'b1; 
    assign VGA_VS = (vert_value < 2) ? 1'b0 : 1'b1;
    //assign read_en = 1'b1;
    assign render = (horz_value <= 783 && horz_value >= 144 && vert_value <= 514 && vert_value >= 35) ? 1'b1:1'b0;
    assign new_frame = (horz_value == 784 && vert_value == 515) ? 1'b1:1'b0; //new frame goes high the second the last frame ends
    assign frame_start = (horz_value == 112 && vert_value == 35) ? 1'b1:1'b0; //frame start goes high 20 pixels before the actual frame starts
    
    assign VGA_R = (render && hit_flag) ? 4'b1111:4'b0000;
    assign VGA_G = (render && hit_flag) ? 4'b1111:4'b0000;
    assign VGA_B = (render && hit_flag) ? 4'b1111:4'b0000;
    
endmodule
