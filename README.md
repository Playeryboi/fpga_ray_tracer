<img width="640" height="480" alt="image" src="https://github.com/user-attachments/assets/c4c7f8e5-d695-4356-a4c9-da79dfe98bc1" />

# FPGA Real-Time 3D Ray Tracer

**Author:** Jesus Salinas

**Platform:** Nexys A7 (Xilinx Artix-7) | **Language:** Verilog

A custom hardware-accelerated 3D ray tracer built entirely in Verilog from the gate level up. This project bypasses traditional GPUs, calculating lighting vectors, geometry intersections, and pixel outputs directly on FPGA fabric. It utilizes a deeply pipelined System-on-Chip architecture featuring MicroBlaze hardware/software co-design to manage the scene.

Designed for real-time performance, the render engine outputs directly to the Nexys A7's 12-bit VGA port.
## Milestones Reached

* **Math Engine Validated:** Custom DSP-driven fixed-point arithmetic (Q1.17 and Q21.30) successfully implemented, entirely eliminating the fabric overhead and latency of floating-point units.
* **Pipeline Synchronization:** Shift-register pipelines are fully locked and synced for Lambertian light vectors, resolving data-slip artifacts and maintaining perfect pixel clock alignment.
* **Primary Geometry Rendering:** Sphere intersection cores with exact hit-point extraction and surface normal logic are active and rendering in simulation.
* **Gamma-Optimized Shading:** Mathematical ambient light injection successfully stretches 12-bit color bands to cleanly survive monitor gamma curves without crushing shadows.

## Development Roadmap

* **Align RT cores with VGA output for Hardware Validation: ** The VGA controller and the RT cores are not aligned, which prevents the hardware from outputting the correct image.
* **200 MHz Overclock & FIFO Decoupling:** Decoupling the math engine from the 25 MHz VGA display controller via FIFO buffers. This will allow the intersection pipeline to run asynchronously at maximum fabric speed (Target: 200 MHz).
* **Secondary Shadow Rays:** Implementing epsilon offset adders, secondary intersection cores, and occlusion multiplexers to evaluate light blockage and cast true geometric shadows.
* **Expanded Geometry:** Instantiating distinct mathematical intersection cores for infinite floor planes and bounding-box cubes.
* **Recursive Reflections:** Routing bounce vectors off calculated surface normals to sample environmental colors and render mirrored surfaces.
* **24-Bit Output Upgrade (Exploratory):** Investigating uncompressed 24-bit color output via external Pmod TMDS (HDMI) or triple video DACs to completely bypass the onboard 12-bit DAC limitations.
* **Asynchronous Overclocking:** Decoupling the math engine from the display controller via FIFO buffers, allowing the intersection pipeline to run at maximum fabric speed independently of the 25 MHz pixel clock.
