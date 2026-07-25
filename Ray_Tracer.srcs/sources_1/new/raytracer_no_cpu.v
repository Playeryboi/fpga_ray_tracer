`timescale 1ns / 1ps
`default_nettype none

module raytracer_no_cpu(
    input wire clk,
        
    output wire VGA_HS,
    output wire VGA_VS,
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B
    );

    //wire declarations
    wire [31:0] out_addr;
    reg [31:0] dout_bram; //output address and data output from bram
    wire [9:0] horz_value, vert_value;
    wire [3:0] red_wire, green_wire, blue_wire;
    wire clk_25Mhz;
    wire bram_en;
    wire rst;
    wire new_frame;
    wire render;
    wire frame_start;
    wire camera_grant, intersection_grant;
    wire camera_read, camera_ready, intersection_read, intersection_ready;
    wire [31:0] bram_camera_addr, bram_intersection_addr;
    wire [31:0] camera_data, intersection_data;
    wire signed [17:0] ray_x, ray_y, ray_z;
    wire signed [17:0] camera_x, camera_y, camera_z;
    wire setup_done;
    wire start_cores;
    wire hit_flag;
    
//    reg [1:0] counter = 0;
//    wire clk_25Mhz_logic;
//    always @(posedge clk) begin
//        counter <= counter + 1; // 00, 01, 10, 11, then overflows back to 00
//    end
    
//    assign clk_25Mhz_logic = counter[1];
    
//    BUFG clock_buffer_inst (
//        .I(clk_25Mhz_logic), // Input from your counter logic
//        .O(clk_25Mhz)        // Output to the dedicated clock tree
//    );    
    
     always @(posedge clk) begin
        if(bram_en) begin
            case(out_addr)
            //camera origin
            32'd0: dout_bram <= 32'sd0;
            32'd4: dout_bram <= 32'sd0;
            32'd8: dout_bram <= 32'sd0;
            //d_top_left
            32'd12: dout_bram <= 32'sd65536;
            32'd16: dout_bram <= 32'sd50370;
            32'd20: dout_bram <= 32'sd37758;
            //delta_u
            32'd24: dout_bram <= 32'sd0;
            32'd28: dout_bram <= -32'sd157;
            32'd32: dout_bram <= 32'sd0;
            //delta_v
            32'd36: dout_bram <= 32'sd0;
            32'd40: dout_bram <= 32'sd0;
            32'd44: dout_bram <= -32'sd157;
            //(4,0,0)
            32'd48: dout_bram <= 32'sd2048;
            32'd52: dout_bram <= 32'sd0;
            32'd56: dout_bram <= 32'sd0;
            
            32'd60: dout_bram <= 32'd12287; //packed data unsigned, white sphere of radius 2
            endcase
        
        end
    end 
     
    vga_top vga_module (.clk(clk), 
    .VGA_HS(VGA_HS), //horizontal and vertical sync signals
    .VGA_VS(VGA_VS),
    .horz_value(horz_value), 
    .vert_value(vert_value), 
    .red_in(red_wire), 
    .green_in(green_wire), 
    .blue_in(blue_wire), 
    .VGA_R(VGA_R), 
    .VGA_G(VGA_G), 
    .VGA_B(VGA_B), 
    .render(render),
    .new_frame(new_frame), //goes high after the end of a frame
    .frame_start(frame_start), //goes high a set amount of pixels before the new frame is drawn
    .hit_flag(hit_flag)
    );//each pixel takes 4 clock cycles in the 100Mhz domain
    
    
    camera_module camera1(
    .clk(clk),
    .frame_start(frame_start),
    .granted(camera_grant),
    .camera_read(camera_read),
    .camera_ready(camera_ready),
    .bram_data(camera_data),
    .bram_addr(bram_camera_addr),
    .ray_dir_x(ray_x),
    .ray_dir_y(ray_y),
    .ray_dir_z(ray_z),
    .camera_x(camera_x),
    .camera_y(camera_y),
    .camera_z(camera_z),
    .setup_done(setup_done),
    .render(render)
    );
    
    intersection_engine intersection_eng(
    .clk(clk),
    .setup_done(setup_done), 
    .render(render),
    .red_wire(red_wire),
    .green_wire(green_wire),
    .blue_wire(blue_wire),
    .ray_dir_x(ray_x),
    .ray_dir_y(ray_y),
    .ray_dir_z(ray_z),
    .camera_x(camera_x),
    .camera_y(camera_y),
    .camera_z(camera_z),
    .granted(intersection_grant),
    .intersect_read(intersection_read),
    .intersect_ready(intersection_ready),
    .bram_data(intersection_data),
    .bram_addr(bram_intersection_addr),
    .start_cores(start_cores),
    .hit_flag(hit_flag)  
    );
    
    object_bram_controller b_ctrl1(
    .clk(clk),
    .bram_camera_addr(bram_camera_addr),
    .camera_read(camera_read),
    .camera_ready(camera_ready),
    .camera_data(camera_data),
    .camera_grant(camera_grant),
    .bram_intersect_addr(bram_intersection_addr),
    .intersect_read(intersection_read),
    .intersect_ready(intersection_ready),
    .intersect_data(intersection_data),
    .intersect_grant(intersection_grant),
    .bram_data(dout_bram),
    .read_en(bram_en),
    .bram_addr(out_addr)
    );    
    
endmodule
