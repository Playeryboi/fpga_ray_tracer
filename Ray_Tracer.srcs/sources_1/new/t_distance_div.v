`timescale 1ns / 1ps
`default_nettype none

module t_distance_div (
    input wire clk,
    input wire sqrt_done,
    input wire signed [23:0] sqrt_delta, //Q13.11
    input wire signed [17:0] a, //Q2.16
    input wire signed [23:0] b, //Q13.11
    input wire input_hit,
    output reg signed [24:0] t_distance, //Q12.12
    output wire div_done,
    output wire output_hit
    );
    
    // b is Q13.11
    //Qout = Qnum - Qden
    //we want 12 bits of precision
    //12 + Qden (16) = 28 --> shift numerators left by 17 
    //fits nicely into 25x18 DSP multiplier
    localparam STAGES = 24;
    
    reg stage [STAGES + 3:0];
    reg hit_flag [STAGES + 4:0];
    assign div_done = stage[STAGES + 3]; 
    assign output_hit = hit_flag[STAGES + 4];
    
    reg signed [24:0] numerator_plus; 
    reg signed [24:0] numerator_minus; 
    
    reg signed [47:0] numerator_plus_norm [STAGES:0]; //division doesn't work on negative numbers
    reg was_neg_plus [STAGES:0]; 
    
    reg signed [47:0] numerator_minus_norm [STAGES:0]; //Q23.25 extra padding for shifts
    reg was_neg_minus [STAGES:0]; 
    
    reg [17:0] denominator [STAGES:0]; //a is always positive
    
    reg [23:0] qoutient_plus [STAGES:0];
    reg [23:0] qoutient_minus [STAGES:0];
    
    reg signed [24:0] qoutient_p_prelim;
    reg signed [24:0] qoutient_m_prelim;
    
    reg signed [24:0] qoutient_p_final;
    reg signed [24:0] qoutient_m_final;
    
    reg prelim_stg1;
    
    
    always @(posedge clk) begin
        hit_flag[0] <= input_hit;
        if(input_hit) prelim_stg1 <= sqrt_done;
        if(sqrt_done) begin
            numerator_plus <= -b + sqrt_delta; //Q13.11 + Q13.11 --> needs extra bit for overflow
            numerator_minus <= -b - sqrt_delta;          
        end
    end
 
     always @(posedge clk) begin
        hit_flag[1] <= hit_flag[0];
        stage[0] <= prelim_stg1;
        if(prelim_stg1) begin
            qoutient_plus[0] <= 24'd0;
            qoutient_minus[0] <= 24'd0;
            denominator[0] <= a << 1; //multiplying by 2 Q2.16
            
            was_neg_plus[0] <= numerator_plus[24]; //if sign bit is 1 then its negative
            if(numerator_plus[24]) numerator_plus_norm[0] <= (-numerator_plus) << 17;
            else numerator_plus_norm[0] <= numerator_plus << 17;     
            
            was_neg_minus[0] <= numerator_minus[24];
            if(numerator_minus[24]) numerator_minus_norm[0] <= (-numerator_minus) << 17;
            else numerator_minus_norm[0] <= numerator_minus << 17;                           
        end
    end
    
    genvar stg;
    generate
        for(stg = 0; stg < STAGES; stg = stg + 1) begin
            always @(posedge clk) begin
            hit_flag[stg + 2] <= hit_flag[stg + 1];
            stage[stg + 1] <= stage[stg];
            denominator[stg + 1] <= denominator[stg]; 
            was_neg_plus[stg + 1] <= was_neg_plus[stg]; 
            was_neg_minus[stg + 1] <= was_neg_minus[stg];
            
                if(stage[stg]) begin
                    if(!numerator_plus_norm[stg][47]) begin //if its greater than zero
                        numerator_plus_norm[stg + 1] <= (numerator_plus_norm[stg] << 1) - {denominator[stg], 24'd0};
                        qoutient_plus[stg + 1] <= {qoutient_plus[stg][22:0], 1'b1};
                    end
                    else begin
                        numerator_plus_norm[stg + 1] <= (numerator_plus_norm[stg] << 1) + {denominator[stg], 24'd0};
                        qoutient_plus[stg + 1] <= {qoutient_plus[stg][22:0], 1'b0};                    
                    end
                    
                    if(!numerator_minus_norm[stg][47]) begin //if its greater than zero
                        numerator_minus_norm[stg + 1] <= (numerator_minus_norm[stg] << 1) - {denominator[stg], 24'd0};
                        qoutient_minus[stg + 1] <= {qoutient_minus[stg][22:0], 1'b1};
                    end
                    else begin
                        numerator_minus_norm[stg + 1] <= (numerator_minus_norm[stg] << 1) + {denominator[stg], 24'd0};
                        qoutient_minus[stg + 1] <= {qoutient_minus[stg][22:0], 1'b0};                    
                    end                    
                end
            end       
        end
    endgenerate
    
    always @(posedge clk) begin
        hit_flag[26] <= hit_flag[25];
        stage[25] <= stage[24];
        was_neg_plus[25] <= was_neg_plus[24];  
        was_neg_minus[25] <= was_neg_minus[24];
        
        if(stage[24]) begin
            qoutient_p_prelim <= {1'b0, qoutient_plus[24]} - {1'b0, ~qoutient_plus[24]};
            qoutient_m_prelim <= {1'b0, qoutient_minus[24]} - {1'b0, ~qoutient_minus[24]};
        end
    end

    always @(posedge clk) begin
        hit_flag[27] <= hit_flag[26];
        stage[26] <= stage[25];
        if(stage[25]) begin
            if(was_neg_plus[25]) qoutient_p_final <= -qoutient_p_prelim;
            else qoutient_p_final <= qoutient_p_prelim;
            
            if(was_neg_minus[25]) qoutient_m_final <= -qoutient_m_prelim;
            else qoutient_m_final <= qoutient_m_prelim;
        end
    end    
 
     always @(posedge clk) begin
        hit_flag[28] <= hit_flag[27];
        stage[27] <= stage[26];
        if(stage[26]) begin
            if(!qoutient_p_final[24] && !qoutient_m_final[24] ) begin
                if(qoutient_p_final >= qoutient_m_final) t_distance <= qoutient_m_final;
                else t_distance <= qoutient_p_final;
            end
            else if(qoutient_p_final[24] && qoutient_m_final[24] ) begin
                if(qoutient_p_final >= qoutient_m_final) t_distance <= qoutient_p_final;
                else t_distance <= qoutient_m_final;
            end            
            else if(!qoutient_p_final[24] && qoutient_m_final[24] ) t_distance <= qoutient_p_final;
            else t_distance <= qoutient_m_final;
        end
    end  
    
endmodule
