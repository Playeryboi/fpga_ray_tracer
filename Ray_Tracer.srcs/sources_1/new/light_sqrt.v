`timescale 1ns / 1ps
`default_nettype none

module light_sqrt #(parameter W = 48)(
    input wire clk,
    input wire light_normal_done,
    input wire [47:0] magnitude_sqrd, //Q22.26 all information bits no sign bit
    output wire [23:0] square_root, //Q11.13
    output wire done
    );
    localparam STAGES = W/2;
    //total delay 25 cycles
    //W is the width of the incoming radicand which is delta
    reg stages [STAGES:0]; //N + 1 stages
    reg [W-1:0] radicand [STAGES:0]; //W bits wide
    reg signed [25:0] remainder [STAGES:0]; 
    reg [23:0] root [STAGES:0]; 
    reg intersected [STAGES:0];
   
    
    assign done = stages[STAGES];
    assign square_root = root[STAGES];
   
    always @(posedge clk) begin
        root[0] <= 24'b0;
        stages[0] <= light_normal_done;
        radicand[0] <= magnitude_sqrd;
        remainder[0] <= 26'b0; 
    end
    
    genvar stg;
    generate
        for(stg = 0; stg < STAGES; stg = stg + 1) begin
        
            wire signed [25:0] shifted_rmd = {remainder[stg][23:0],radicand[stg][W-1-stg*2:W-2-stg*2]};
            wire signed [25:0] computed_rmd = (!remainder[stg][25]) ? shifted_rmd - $signed({root[stg], 2'b01}) : shifted_rmd + $signed({root[stg], 2'b11});
            wire next_bit = !computed_rmd[25];
            
            always @(posedge clk) begin 
                stages[stg + 1] <= stages[stg];
                radicand[stg +1] <= radicand[stg];
                if(stages[stg]) begin 
                    root[stg + 1] <= {root[stg][22:0], next_bit};
                    remainder[stg + 1] <= computed_rmd;                  
                end
            end
        end
    endgenerate
    
    
endmodule