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
   
   //currently only supports 2 objects, 1 sphere and 1 light
   
   //calculates primary ray and intersection
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
    .camera_z(camera_z),
    .div_done(div_done),
    .t_distance(t_distance),
    .delayed_ray_dir(ray_dir)
    );
    wire [53:0] ray_dir; //{x,y,z}
    wire signed [24:0] t_distance;
    wire div_done;
    
    //calculates hit point and sphere normal 
    sphere_hit_and_normal SHN0 (    
    .clk(clk),
    .start(div_done),
    .t_distance(t_distance), 
    .ray_dir(ray_dir),
    .object1(object1),
    .object2(object2),
    .camera_x(camera_x),
    .camera_y(camera_y),
    .camera_z(camera_z),
    .LED(LED)
    );
    
    //calculates secondary shadow ray and lightning
    shadow_ray_sphr SRS0 ();
    
endmodule
