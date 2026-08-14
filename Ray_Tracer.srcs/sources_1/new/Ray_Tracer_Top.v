`timescale 1ns / 1ps
`default_nettype none

module Ray_Tracer_Top(
    input wire clk,
    input wire cpu_reset,
    output wire VGA_HS,
    output wire VGA_VS,
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B,
    output wire LED    
    );

    //wire declarations
    wire [31:0] out_addr, dout_bram; //output address and data output from bram
    wire [9:0] horz_value, vert_value;
    wire [3:0] red_wire, green_wire, blue_wire;
    wire clk_25Mhz;
    wire clk_200Mhz;
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
    
//// Add this right below your wire declarations
//    reg [1:0] counter = 0;
//    always @(posedge clk) begin
//        counter <= counter + 1;
//    end
    
//    wire clk_25Mhz_logic = counter[1];
    
//    BUFG clock_buffer_inst (
//        .I(clk_25Mhz_logic), 
//        .O(clk_25Mhz)        
//    );    
    //processor and bram controller connections
    co_processor_design_wrapper CPU0 (
    .BRAM_PORTB_0_addr(out_addr),
    .BRAM_PORTB_0_clk(clk_25Mhz),
    .BRAM_PORTB_0_dout(dout_bram),
    .BRAM_PORTB_0_en(bram_en),
    .BRAM_PORTB_0_rst(rst),
    .clk_in1_0(clk),
    .clk_out2_0(clk_25Mhz),
    .clk_out3_0(clk_200Mhz),
    .intr_0(new_frame),
    .reset(cpu_reset)
    );
     
    vga_top vga_module (
    .clk(clk_25Mhz), 
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
    .frame_start(frame_start) //goes high a set amount of pixels before the new frame is drawn
    );//each pixel takes 4 clock cycles in the 100Mhz domain
    
    
    camera_module camera1(
    .clk(clk_200Mhz),
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
    .clk(clk_200Mhz),
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
    .LED(LED)
    );
    
//    mock_bram_controller mock_ctrl (
//        .clk(clk_25Mhz), // MUST be tied to your 25MHz pixel clock!
//        .bram_camera_addr(bram_camera_addr),
//        .camera_read(camera_read),
//        .camera_ready(camera_ready),
//        .camera_data(camera_data),
//        .camera_grant(camera_grant),
//        .bram_intersect_addr(bram_intersection_addr),
//        .intersect_read(intersection_read),
//        .intersect_ready(intersection_ready),
//        .intersect_data(intersection_data),
//        .intersect_grant(intersection_grant)
//    );    
    object_bram_controller b_ctrl1(
    .clk(clk_200Mhz),
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
