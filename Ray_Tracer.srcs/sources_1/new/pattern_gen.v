`timescale 1ns / 1ps

module pattern_gen(
    input clk,
    input [9:0] horz_value,
    input [9:0] vert_value,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );
    reg [3:0] VGA_R;
    reg [3:0] VGA_G;
    reg [3:0] VGA_B;
    //che
    always @(posedge clk)
    begin
        if ((horz_value < 784 && horz_value > 143 && vert_value < 515 && vert_value > 34)) begin
            if(horz_value < 224) begin //red
                VGA_R <= 4'hF;
                VGA_G <= 4'h0;
                VGA_B <= 4'h0;
                end
            else if(horz_value < 304) begin //orange
                VGA_R <= 4'hF;
                VGA_G <= 4'h8;
                VGA_B <= 4'h0;
                end
            else if(horz_value < 384) begin // yellow
                VGA_R <= 4'hF;
                VGA_G <= 4'hF;
                VGA_B <= 4'h0;
                end
            else if(horz_value < 464) begin // green
                VGA_R <= 4'h0;
                VGA_G <= 4'hF;
                VGA_B <= 4'h0;
                end   
            else if(horz_value < 544) begin // mint green
                VGA_R <= 4'h0;
                VGA_G <= 4'hF;
                VGA_B <= 4'h8;
                end
            else if(horz_value < 624) begin //cyan
                VGA_R <= 4'h0;
                VGA_G <= 4'hF;
                VGA_B <= 4'hF;
                end                                           
            else if(horz_value < 704) begin //blue
                VGA_R <= 4'h0;
                VGA_G <= 4'h0;
                VGA_B <= 4'hF;
                end
            else if(horz_value < 784) begin //magenta
                VGA_R <= 4'hF;
                VGA_G <= 4'h0;
                VGA_B <= 4'hF;
                end
            else begin
                VGA_R <= 4'h0;
                VGA_G <= 4'h0;
                VGA_B <= 4'h0; 
                end
            end
            else begin
                VGA_R <= 4'h0;
                VGA_G <= 4'h0;
                VGA_B <= 4'h0; 
                end
    end
    
    assign red = VGA_R;
    assign blue = VGA_B;
    assign green = VGA_G;
//    assign VGA_R = (horz_value < 784 && horz_value > 143 && vert_value < 515 && vert_value > 34) ? 4'hF:4'h0;
//    assign VGA_G = (horz_value < 784 && horz_value > 143 && vert_value < 515 && vert_value > 34) ? 4'hF:4'h0;
//    assign VGA_B = (horz_value < 784 && horz_value > 143 && vert_value < 515 && vert_value > 34) ? 4'hF:4'h0;
    
endmodule
