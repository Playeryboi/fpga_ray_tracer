`timescale 1ns / 1ps
`default_nettype none

module sphere_intersect_testbench;

    reg clk;
    reg [1:0] count = 0;
    reg start_cores;
    
    wire [3:0] object_size = 4'd2;
    wire [11:0] object_color = 12'd0;
    wire [3:0] object_shape_material = 4'd0;
    
    wire hit_flag;
    //camera origin is at (0,0,0)
    wire signed [17:0] camera_x = 18'sd0;
    wire signed [17:0] camera_y = 18'sd0;
    wire signed [17:0] camera_z = 18'sd0;
    
    //D_top-left (1,0.768598,0.576147)
    //in fixed point math that is (65536,50370,37758)
    wire signed [17:0] ray_dir_x = 18'sd65536; //Q2.16
    wire signed [17:0] ray_dir_y = 18'sd50370; 
    wire signed [17:0] ray_dir_z = 18'sd37758; 
    
    //testing sphere at cordinate (4,0,0)
    wire signed [17:0] object [2:0]; //Q9.9
    assign object[0] = {9'sd4,9'b0};
    assign object[1] = {9'sd0,9'b0};
    assign object[2] = {9'sd0,9'b0};
    
    sphere_intersect_core UUT (
    .clk(clk),
    .start_core(start_cores),
    .ray_dir_x(ray_dir_x),
    .ray_dir_y(ray_dir_y),
    .ray_dir_z(ray_dir_z),    
    .object_x(object[0]),
    .object_y(object[1]),
    .object_z(object[2]),
    .camera_x(camera_x),
    .camera_y(camera_y),
    .camera_z(camera_z),    
    .object_color(object_color),
    .object_size(object_size),
    .object_shape_material(object_shape_material),
    .hit_flag(hit_flag));


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    always @(posedge clk) begin
        start_cores <= 1'b0;
        if(count < 1) begin
            count <= count + 1;
            start_cores <= 1'b1;
        end
    end

    initial begin
        #200;     // Wait 200 nanoseconds
        $finish;  // Tell Vivado to stop the simulation
    end
endmodule