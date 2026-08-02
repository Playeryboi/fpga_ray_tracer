`timescale 1ns / 1ps
`default_nettype none

module t_distance_div (
    input wire clk,
    input wire stage_7,
    input wire signed [23:0] sqrt_delta,
    input wire signed [17:0] a,
    input wire signed [24:0] b,
    input wire signed [24:0] t_distance
    );
    
    localparam STAGES = 24;
    
    reg stage [STAGES:0];
    
    reg signed [24:0] numerator_plus [STAGES:0];
    reg signed [24:0] numerator_minus [STAGES:0];
    
    reg signed [17:0] denominator [STAGES:0];
    
    reg [23:0] qoutient_plus [STAGES:0];
    reg [23:0] qoutient_minus [STAGES:0];
    
    always @(posedge clk) begin
        stage[0] <= stage_7;
    end
    
    genvar stg;
    generate
        for(stg = 0; stg < STAGES; stg = stg + 1) begin
            always @(posedge clk) begin
                if(stage[stg]) begin
                    
                end
            end       
        end
    endgenerate
    
endmodule
