`timescale 1ns / 1ps
module horz_counter(
    input wire clk_25Mhz,
    output reg [9:0] horz_value = 0, //initializing variables with 0
    output reg enable_V_counter = 0
    );
    
    always@(posedge clk_25Mhz) begin    
        if (horz_value < 799) begin
            horz_value <= horz_value +1; //Adding 1 each clock cycle
            enable_V_counter <= 0; //disabling vert counter, while horizontal counter is active
        end
        else begin  
            horz_value <= 0; //after counting 800 pixels, the counter resets
            enable_V_counter <= 1;
        end
    end
endmodule
