`timescale 1ns / 1ps
`default_nettype none

module vga_top(
    input wire clk,
    output wire VGA_HS,
    output wire VGA_VS,
    input wire[3:0] red_in,
    input wire[3:0] green_in,
    input wire[3:0] blue_in,
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B,
    output wire [9:0] horz_value,
    output wire [9:0] vert_value,
    output wire render,
    output wire new_frame,
    output wire frame_start, 
    output wire render_post_delay
    );
    
    
    //instantiating horizontal and vertical counter, reference 480p timing diagram
    wire V_enable;
    horz_counter horz_unit1 (.clk_25Mhz(clk), .horz_value(horz_value), .enable_V_counter(V_enable));
    vert_counter vert_unit1 (.clk_25Mhz(clk), .vert_value(vert_value), .enable_V_counter(V_enable));
    
    //output sync signals
    // They MUST be Active-Low (1'b0 during the sync window)
    assign VGA_HS = (horz_value < 96) ? 1'b0 : 1'b1; 
    assign VGA_VS = (vert_value < 2) ? 1'b0 : 1'b1;
    //assign read_en = 1'b1;
    assign render = (horz_value <= 783 && horz_value >= 144 && vert_value <= 514 && vert_value >= 35) ? 1'b1:1'b0;
    assign new_frame = (horz_value == 784 && vert_value == 515) ? 1'b1:1'b0; //new frame goes high the second the last frame ends
    assign frame_start = (horz_value == 116 && vert_value == 34) ? 1'b1:1'b0; //frame_start is used to start cores a little bit before render starts
    
    assign VGA_R = (render) ? 4'b1111:4'b0000;
    assign VGA_G = (render) ? 4'b1111:4'b0000;
    assign VGA_B = (render) ? 4'b1111:4'b0000;
    
    localparam DELAY_CYCLES = 140;
    
    (* shreg_extract = "yes" *)
    reg render_delay [DELAY_CYCLES-1:0];

    integer i;
    always @(posedge clk) begin
        render_delay[0] <= render;
        
        for (i = 0; i < DELAY_CYCLES - 1; i = i + 1) begin
            render_delay[i+1] <= render_delay[i];
        end
    end
    
    assign render_post_delay = render_delay[DELAY_CYCLES-1];
    
endmodule
