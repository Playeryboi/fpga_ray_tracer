`timescale 1ns / 1ps

module vga_testbench;


reg clk = 0;
wire VGA_HS;
wire VGA_VS;
wire [3:0] VGA_R;
wire [3:0] VGA_G;
wire [3:0] VGA_B;

vga_top UUT (clk, VGA_HS, VGA_VS, VGA_R,VGA_G,VGA_B);
    
always #5 clk = ~clk;
endmodule
