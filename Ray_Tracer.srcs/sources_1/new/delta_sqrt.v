`timescale 1ns / 1ps
`default_nettype none

module delta_sqrt #(parameter W = 48)(
    input wire clk,
    input wire delta_done,
    input wire signed [23:0] a_trunc_in,
    input wire signed [23:0] b_trunc_in,
    input wire signed [47:0] delta, //Q26.22
    output wire signed [23:0] sqrt_delta,
    output wire hit_flag,
    output wire signed [23:0] a_trunc_out,
    output wire signed [23:0] b_trunc_out,
    output wire done
    );
    localparam STAGES = W/2;
    
    //W is the width of the incoming radicand which is delta
    reg stages [STAGES:0];
    reg signed [W-1:0] radicand [STAGES:0]; //W bits wide
    reg signed [25:0] remainder [STAGES:0]; 
    reg [23:0] root [STAGES:0]; 
    reg intersected [STAGES:0];
    
    reg signed [23:0] a_trunc [STAGES:0];//Q2.22
    reg signed [23:0] b_trunc [STAGES:0];//Q13.11
    
    
    assign hit_flag = intersected[STAGES]; //assign the hit flag to the final intersect flag
    assign a_trunc_out = a_trunc[STAGES];
    assign b_trunc_out = b_trunc[STAGES];
    assign done = stages[STAGES];
    assign sqrt_delta = root[STAGES];
   
    always @(posedge clk) begin
        a_trunc[0] <= a_trunc_in;
        b_trunc[0] <= b_trunc_in;
        
        root[0] <= 24'b0;
        stages[0] <= delta_done;
        radicand[0] <= delta;
        remainder[0] <= 26'b0; 
        intersected[0] <= !delta[W-1];// if the msb is 0, then it did intersect
    end
    
    genvar stg;
    generate
        for(stg = 0; stg < STAGES; stg = stg + 1) begin
        
            wire signed [25:0] shifted_rmd = {remainder[stg][23:0],radicand[stg][W-1-stg*2:W-2-stg*2]};
            wire signed [25:0] computed_rmd = (!remainder[stg][25]) ? shifted_rmd - $signed({root[stg], 2'b01}) : shifted_rmd + $signed({root[stg], 2'b11});
            wire next_bit = !computed_rmd[25];
            
            always @(posedge clk) begin
                a_trunc[stg+1] <= a_trunc[stg];
                b_trunc[stg+1] <= b_trunc[stg];
            
                stages[stg + 1] <= stages[stg];
                radicand[stg +1] <= radicand[stg];
                intersected[stg + 1] <= intersected[stg];
                if(stages[stg]) begin 
                    root[stg + 1] <= {root[stg][22:0], next_bit};
                    remainder[stg + 1] <= computed_rmd;                  
                end
            end
        end
    endgenerate
    
    
endmodule