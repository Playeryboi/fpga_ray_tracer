`timescale 1ns / 1ps
`default_nettype none

module sphere_intersect_core(
    input wire clk,
    input wire start_core,
    input wire signed [17:0] ray_dir_x,
    input wire signed [17:0] ray_dir_y,
    input wire signed [17:0] ray_dir_z,
                       
    input wire [127:0] object1,
    input wire [127:0] object2,
    
    input wire signed [17:0] camera_x,
    input wire signed [17:0] camera_y,
    input wire signed [17:0] camera_z,
    output wire LED
    );
   
   primary_ray_sphr PRS0 (
    .clk(clk),
    .start_core(start_core),
    .ray_dir_x(ray_dir_x),
    .ray_dir_y(ray_dir_y),
    .ray_dir_z(ray_dir_z),    
    .object1(object1),
    .object2(object2),
    .camera_x(camera_x),
    .camera_y(camera_y),
    .camera_z(camera_z)  ,
    .LED(LED)
    );
 
    
endmodule
