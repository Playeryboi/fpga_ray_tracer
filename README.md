<img width="640" height="480" alt="image" src="https://github.com/user-attachments/assets/c4c7f8e5-d695-4356-a4c9-da79dfe98bc1" />
# FPGA Real-Time 3D Ray Tracer

**Author:** Jesus Salinas
**Platform:** Nexys A7 (Xilinx Artix-7) | **Language:** Verilog

A custom hardware-accelerated 3D ray tracer built entirely in Verilog from the gate level up. This project bypasses traditional GPUs, calculating lighting vectors, geometry intersections, and pixel outputs directly on FPGA fabric. It utilizes a deeply pipelined System-on-Chip architecture featuring MicroBlaze hardware/software co-design to manage the scene.

Designed for real-time performance, the render engine outputs directly to the Nexys A7's 12-bit VGA port. It is specifically targeted for analog CRT displays (like the Sony VPH-D50) to leverage natural phosphor bloom for hardware color blending and visual anti-aliasing.

## Technical Architecture

* **Fixed-Point Math Cores:** Custom DSP-driven arithmetic (utilizing Q1.17 and Q21.30 radices) entirely eliminates the latency and fabric overhead of floating-point units.
* **Deep Pipelining:** Synchronized shift-register pipelines (e.g., 52-cycle latencies for Lambertian light vectors) maintain lockstep data flow across the pixel clock.
* **Gamma-Optimized Shading:** Mathematical ambient light injection (50% dynamic range scaling via single bit-shifts) stretches color bands to properly survive standard monitor gamma curves without crushing shadows into pitch black.

## Current Features

| Subsystem | Hardware Implementation |
| --- | --- |
| **Primary Ray Generation** | Fully pipelined directional math generation mapped to screen coordinates. |
| **Geometry Engine** | Sphere intersection cores with exact hit-point extraction and surface normal logic. |
| **Diffuse Lighting** | Lambertian dot-product shading constrained by fixed-point ambient baselines. |
| **Display Controller** | Real-time pixel streaming bound by physical VGA blanking synchronization. |

## Development Roadmap

* **Secondary Shadow Rays:** Implementing epsilon offset adders, secondary intersection cores, and occlusion multiplexers to cast true geometric shadows.
* **Expanded Geometry:** Adding distinct intersection cores for infinite floor planes and bounding-box cubes.
* **Recursive Reflections:** Routing bounce vectors off calculated surface normals to render mirrored surfaces.
* **Asynchronous Overclocking:** Decoupling the math engine from the display controller via FIFO buffers, allowing the intersection pipeline to run at maximum fabric speed independently of the 25 MHz pixel clock.
