`timescale 1ns / 1ps

module pattern_gen_test;

reg clk = 0;
wire [9:0] horz_value;
wire [9:0] vert_value;
wire [3:0] VGA_R;
wire [3:0] VGA_G;
wire [3:0] VGA_B;

horz_counter horz_unit1 (.clk_25Mhz(clk), .horz_value(horz_value), .enable_V_counter(V_enable));
vert_counter vert_unit1 (.clk_25Mhz(clk), .vert_value(vert_value), .enable_V_counter(V_enable));
pattern_gen UUT2 (.clk(clk), .horz_value(horz_value), .vert_value(vert_value), .red(VGA_R),.green(VGA_G),.blue(VGA_B));
always #5 clk = ~clk;

endmodule
