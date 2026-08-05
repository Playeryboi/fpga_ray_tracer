`timescale 1ns / 1ps
`default_nettype none

module ray_tracer_tb();

    reg clk;
  
   
    wire [3:0] VGA_R;
    wire [3:0] VGA_G;
    wire [3:0] VGA_B;



    Ray_Tracer_Top UUT(
    .clk(clk),  
   
   .VGA_R(VGA_R),
   .VGA_G(VGA_G),
   .VGA_B(VGA_B)      
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end


    initial begin
        #10000;     // Wait 10000 nanoseconds
        $finish;  // Tell Vivado to stop the simulation
    end
endmodule

