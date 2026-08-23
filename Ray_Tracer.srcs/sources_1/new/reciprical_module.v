`timescale 1ns / 1ps
`default_nettype none

module reciprocal_module (
    input wire clk,
    input wire sqrt_done,
    input wire [23:0] sqrt_light, //Q11.13
    output reg signed [24:0] reciprocal, //Q9.16
    output wire div_done,
    output wire output_hit
    );
    //total delay 27 clock cycles
    
    //we want 16 bits of precision
    //16 + Qden (13) = 29 --> numerators have to be in QX.29 format
    //so for 1, it would be Q1.29 
    
    localparam STAGES = 24;
    
    reg stage [STAGES + 2:0]; //26 - 0 + 1 cycles
    
    reg hit_flag [STAGES + 2:0];
    assign div_done = stage[STAGES + 2]; 
    assign output_hit = hit_flag[STAGES + 2];
    
    wire [29:0] numerator = 30'd536870912; //1 in Q1.29 format
    
    reg signed [51:0] numerator_sub [STAGES:0];   
    
    reg [23:0] denominator [STAGES:0]; //sqrt_light and 1 are always positive
    
    reg [23:0] qoutient [STAGES:0];
    
    reg [24:0] qoutient_prelim;
  
    always @(posedge clk) begin
        stage[0] <= sqrt_done;
        
        denominator[0] <= sqrt_light;
        qoutient[0] <= 24'd0;
        numerator_sub[0] <= numerator;
    end
    
    genvar stg;
    generate
        for(stg = 0; stg < STAGES; stg = stg + 1) begin
            always @(posedge clk) begin
            hit_flag[stg + 1] <= hit_flag[stg];
            stage[stg + 1] <= stage[stg];
            denominator[stg + 1] <= denominator[stg]; 
            
                if(stage[stg]) begin
                    if(!numerator_sub[stg][51]) begin //if its greater than zero
                        numerator_sub[stg + 1] <= (numerator_sub[stg] << 1) - $signed({denominator[stg], 24'd0});
                        qoutient[stg + 1] <= {qoutient[stg][22:0], 1'b1};
                    end
                    else begin
                        numerator_sub[stg + 1] <= (numerator_sub[stg] << 1) + $signed({denominator[stg], 24'd0});
                        qoutient[stg + 1] <= {qoutient[stg][22:0], 1'b0};                    
                    end                 
                end
            end       
        end
    endgenerate
    
    always @(posedge clk) begin
        hit_flag[25] <= hit_flag[24];
        stage[25] <= stage[24];
      
        if(stage[24]) begin
            qoutient_prelim <= {1'b0, qoutient[24]} - {1'b0, ~qoutient[24]};
        end
    end

    always @(posedge clk) begin
        hit_flag[26] <= hit_flag[25];
        stage[26] <= stage[25];
        if(stage[25]) reciprocal <= qoutient_prelim;  
        else reciprocal <= 25'd0;
    end    
    
endmodule
