`timescale 1ns / 1ps
`default_nettype none

module ray_tracer_tb();

    reg clk;
  
   
    wire [3:0] VGA_R;
    wire [3:0] VGA_G;
    wire [3:0] VGA_B;
    
    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;
    
    wire valid_hit;
    wire render_flag;

    Ray_Tracer_Top UUT(
    .clk(clk),  
   
   .VGA_R(VGA_R),
   .VGA_G(VGA_G),
   .VGA_B(VGA_B),
   
   .red(red),
   .green(green),
   .blue(blue),
   .valid_hit(valid_hit),
   .delayed_render_flag(render_flag)      
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    
    integer file;   
    initial begin
        // OVERRIDE WITH ABSOLUTE PATH HERE:
        file = $fopen("C:/Users/herna/verilog_projects/Ray_Tracer/render_output.ppm", "w");
        
        // Write the PPM P3 header
        $fdisplay(file, "P3");
        $fdisplay(file, "640 480"); // Make sure this matches your VGA resolution
        $fdisplay(file, "255");     
    end   
integer pixel_count = 0;
    reg render_flag_d = 0;
    reg [1:0] pixel_phase = 0;
    
    // Monitor the output of your Ray Tracer Top module
    always @(posedge clk) begin
        // Delay register for edge detection
        render_flag_d <= render_flag;
        
        // Detect the start of a new line to synchronize the 4-clock pixel phase
        if (render_flag && !render_flag_d) begin
            pixel_phase <= 2'd0;
        end else if (render_flag) begin
            pixel_phase <= pixel_phase + 1'b1;
        end
        
        // ONLY write to the file on the first clock cycle of the VGA pixel
        if (render_flag && pixel_phase == 2'd0) begin
            
            // Multiply 4-bit output channels by 17 to scale to 8-bit RGB
            if(valid_hit) begin
                $fdisplay(file, "%d %d %d", 
                          red * 17, 
                          green * 17, 
                          blue * 17);
            end
            else begin
                $fdisplay(file, "%d %d %d", 
                      8 * 17, 
                      12 * 17, 
                      15 * 17); // Soft Cyan background
            end
            
            // Increment pixel counter and check for frame completion
            pixel_count = pixel_count + 1;
            
            // Debug tracker: Print progress to Vivado Tcl Console every 10,000 pixels
            if (pixel_count % 10000 == 0) begin
                $display("Rendered %d / 307200 pixels...", pixel_count);
            end
            
            if (pixel_count == 307200) begin // 640 x 480 total pixels
                $fclose(file);
                $display("Frame generation complete! Output saved to render_output.ppm");
                $finish; // Safely terminates the Vivado simulation
            end
            
        end
    end

endmodule