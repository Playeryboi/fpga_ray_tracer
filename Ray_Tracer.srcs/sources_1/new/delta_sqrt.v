`timescale 1ns / 1ps
`default_nettype none

module delta_sqrt #(parameter W = 48)(
    input wire clk,
    input wire stage_7,
    input wire signed [47:0] delta, //Q28.20
    output wire signed [23:0] sqrt_delta,
    output wire hit_flag,
    output wire done
    );
    localparam STAGES = W/2;
    
    //W is the width of the incoming radicand which is delta
    reg stages [STAGES:0];
    reg signed [W-1:0] radicand [STAGES:0]; //W bits wide
    reg signed [25:0] remainder [STAGES:0]; 
    reg [23:0] root [STAGES:0]; 
    reg intersected [STAGES:0];
    
    assign hit_flag = intersected[STAGES]; //assign the hit flag to the final intersect flag
    assign done = stages[STAGES];
    assign sqrt_delta = root[STAGES];
   
    always @(posedge clk) begin
        root[0] <= 24'b0;
        stages[0] <= stage_7;
        radicand[0] <= delta;
        remainder[0] <= 26'b0; 
        if(!delta[W-1]) begin
            intersected[0] <= 1'b1;           
        end
        else begin
            intersected[0] <= 1'b0;
        end
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
                intersected[stg + 1] <= intersected[stg];
                if(stages[stg]) begin 
                    root[stg + 1] <= {root[stg][22:0], next_bit};
                    remainder[stg + 1] <= computed_rmd;                  
                end
            end
        end
    endgenerate
    
    
endmodule
