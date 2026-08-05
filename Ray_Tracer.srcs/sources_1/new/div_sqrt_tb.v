`timescale 1ns / 1ps
`default_nettype none

module div_sqrt_tb();
    reg clk;
  
    wire signed [47:0] delta = 48'sd84934656; //23
    wire [24:0] sqrt_delta = 24'd13312;
    wire signed [24:0] b = 24'sd3072;
    wire signed [17:0] a = 18'sd44236;
   // wire stage_7 = 1'b1;
    
//    delta_sqrt UUT0(
//    .clk(clk),  
//    .stage_7(count),            
//    .delta(delta)
//    );

    t_distance_div UUT1(
    .clk(clk),  
    .sqrt_done(count),            
    .sqrt_delta(sqrt_delta),
    .a(a),
    .b(b)
    );
    
    reg count = 1;
    reg [1:0] state = 0;
    always @(posedge clk) begin
        if(state == 0)begin
            count <= count - 1;
            state <= 1'b1;
        end
        
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        #500;     // Wait 10000 nanoseconds
        $finish;  // Tell Vivado to stop the simulation
    end

endmodule
