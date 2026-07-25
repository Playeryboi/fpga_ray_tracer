`timescale 1ns / 1ps

module bram_controller(   
    input wire clk,
    input wire in_rst,
    
    //higher level module connections
    input wire [11:0] in_addr,
    input wire read_en,
    output reg data_ready,
    output reg [31:0] data_r, //width of data
    
    //Vivado bram connections
    input wire [31:0] dout_bram, 
    output wire rst,
    output wire [31:0] out_addr, //only 2048 addresses 
    output wire bram_en,
    output wire out_clk
    );
    //this block of ram will contain the following
    //camera position -> addresses 0-2 (x,y,z cordinates of topleft of camera plane)
    //object positions and properties
    //light positions and light properties
    //bram address starts at 0, and goes to 2047 -> 2048 addresses
    //this bram controller will use a counting system
    
    reg state = 1'b0; //FSM states, on idle it waits, on read it reads from bram
    localparam IDLE = 1'b0,
               READ = 1'b1;         
    
    reg [11:0] data_address;
    
    always @(posedge clk) begin
        if(in_rst) begin
            state <= IDLE;
            data_ready <= 1'b0;
            data_address <= 12'd0;
            data_r <= 32'd0;
        end
        else begin
            case(state) 
                IDLE: begin //giving bram address
                    data_ready <= 1'b0; //fetching data, not ready
                    if(read_en) begin
                        data_address <= in_addr;
                        state <= READ;
                    end
                end
                READ: begin //waits one clock cycle to receive data
                    data_r <= dout_bram;
                    data_ready <= 1'b1; //data is ready
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
    
    assign out_addr = {20'b0, data_address};
    assign rst = in_rst;
    assign bram_en = 1'b1;
    assign out_clk = clk;
endmodule
