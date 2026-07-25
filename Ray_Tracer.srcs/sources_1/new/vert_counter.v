`timescale 1ns / 1ps
module vert_counter(
    input wire clk_25Mhz,
    input wire enable_V_counter,
    output reg [9:0] vert_value = 0
    );
    
    always@(posedge clk_25Mhz) begin   
        if(enable_V_counter == 1'b1) begin
            if (vert_value < 524)
                vert_value <= vert_value +1; //Adding 1 each clock cycle
            else
                vert_value <= 0; 
        end
    end
endmodule
