`timescale 1ns / 1ps
`default_nettype none

module Ray_Gradient_debug(
    input wire clk,
    input wire [9:0] horz_value,
    input wire [9:0] vert_value,
    input wire new_frame,
    input wire render,
    output reg [3:0] red_wire,
    output reg [3:0] green_wire,
    output reg [3:0] blue_wire,
    //bram controller connections
    input wire [31:0] bram_data,
    output wire read_en,
    output reg [31:0] bram_addr  
    );
    
    //for now, always have read enabled
    assign read_en = 1'b1;    
    
    
    localparam  Wait = 1'b0,
                Read = 1'b1;  
    reg state = 1'b0;      
    //delta_u[0] represents the x axis
    //delta_u[1] represents the y axis
    //delta_u[2] represents the z axis
    reg signed [31:0] D_top_left [2:0];
    reg signed [31:0] delta_u [2:0];
    reg signed [31:0] delta_v [2:0];   
    
    // 1. Calculate the current Ray Direction on the fly
    // We cast the counters to signed integers by padding them with a 0.
    // Q16.16 multiplied by an integer naturally results in a Q16.16 value    
    wire signed [31:0] ray_dir_x = D_top_left[0] + ($signed({1'b0, horz_value}) * delta_u[0]) + ($signed({1'b0, vert_value}) * delta_v[0]);
    wire signed [31:0] ray_dir_y = D_top_left[1] + ($signed({1'b0, horz_value}) * delta_u[1]) + ($signed({1'b0, vert_value}) * delta_v[1]);
    wire signed [31:0] ray_dir_z = D_top_left[2] + ($signed({1'b0, horz_value}) * delta_u[2]) + ($signed({1'b0, vert_value}) * delta_v[2]);
    
    always @(posedge clk) begin
        case(state)
            Wait: begin
                if (new_frame) begin
                    state <= Read;
                    bram_addr <= 32'd0; // Request Address 0
                end
            end
            
            Read: begin
                // Continuously increment the address every clock cycle
                bram_addr <= bram_addr + 4; 

                // Because of 1-cycle latency, the data for address 0 
                // arrives on the exact clock cycle that bram_addr becomes 1.
                if (bram_addr == 32'd4) D_top_left[0] <= bram_data; // Got Addr 0
                if (bram_addr == 32'd8) D_top_left[1] <= bram_data; // Got Addr 1
                if (bram_addr == 32'd12) D_top_left[2] <= bram_data; // Got Addr 2
                                
                if (bram_addr == 32'd16) delta_u[0] <= bram_data; // Got Addr 3
                if (bram_addr == 32'd20) delta_u[1] <= bram_data; // Got Addr 4
                if (bram_addr == 32'd24) delta_u[2] <= bram_data; // Got Addr 5
                
                if (bram_addr == 32'd28) delta_v[0] <= bram_data; // Got Addr 6
                if (bram_addr == 32'd32) delta_v[1] <= bram_data; // Got Addr 7
                if (bram_addr == 32'd36) delta_v[2] <= bram_data; // Got Addr 8                
                // Exit condition
                if (bram_addr == 32'd36) begin
                    state <= Wait;
                end
            end
        endcase
        
        if(render) begin
            red_wire <= ray_dir_x[15:12];
            green_wire <= ray_dir_y[15:12];
            blue_wire <= ray_dir_z[15:12];
        end
        else begin
            red_wire <= 4'b0000;
            green_wire <= 4'b0000;
            blue_wire <= 4'b0000;        
        end       
    end
    
endmodule
