# FPGA Ray Tracer

**Author:** Jesus Salinas  
**Platform:** Digilent Nexys A7-100T (Xilinx Artix-7)  
**Hardware:** Verilog RTL | **Firmware:** C++ for MicroBlaze  
**Development tools:** Vivado 2025.2

A hardware-accelerated ray tracer with custom pipelined Verilog cores for ray generation, sphere intersection, and shading. The design uses fixed-point arithmetic and includes a MicroBlaze processor with C++ firmware for configuring scene data through shared block RAM.

The target display is 640 × 480 through the Nexys A7's onboard 12-bit VGA output.

## Current Status

The design runs on the FPGA, and the rendering pipeline produces a shaded sphere in simulation. Alignment between the ray-tracing pipeline and VGA controller is still in progress, so correct end-to-end image output on a physical display has not yet been demonstrated.

<img width="640" height="480" alt="Simulation output showing a shaded sphere against a blue background" src="https://github.com/user-attachments/assets/c4c7f8e5-d695-4356-a4c9-da79dfe98bc1" />

*Simulation-generated image, not a photograph of hardware VGA output.*

## Implementation Highlights

- **Pipelined rendering:** Custom RTL computes primary rays, sphere intersections, hit points, surface normals, and shaded pixel values.
- **Fixed-point arithmetic:** The math engine uses fixed-point formats, including Q1.17 and Q21.30, instead of floating-point arithmetic.
- **Diffuse shading:** Lambertian lighting with an ambient term provides basic surface illumination. Pipeline delays align intermediate lighting and geometry data; final alignment with VGA timing remains in progress.
- **Hardware/software integration:** MicroBlaze C++ firmware configures scene data through shared block RAM, while the rendering calculations execute in FPGA logic.

## Performance and Verification

| Result | Scope |
| --- | --- |
| Shaded image generation at 640 × 480 | Verified in simulation; the testbench writes a PPM image. |
| Sustained throughput of one pixel per clock at 25 MHz | Simulation result for the rendering pipeline. |
| 200 MHz post-implementation timing closure | Achieved for custom ray-tracing and shading cores; this is not a measured end-to-end VGA rendering rate. |
| FPGA execution | Hardware bring-up reached; correct VGA image output remains under integration. |

## Repository Guide

| Location | Contents |
| --- | --- |
| `Ray_Tracer.xpr` | Vivado project. |
| `Ray_Tracer.srcs/sources_1/new/` | Custom RTL and several testbenches, including `Ray_Tracer_Top.v` and `ray_tracer_tb.v`. |
| `Ray_Tracer.srcs/sources_1/bd/` | MicroBlaze block design and associated configuration. |
| `Ray_Tracer.gen/sources_1/` | Vivado-generated design files. |
| `Nexys-A7-100T-Master.xdc` | Board constraints. |
| `Ray_Tracer_Top.xsa` | Exported hardware platform. |
| `render_output.ppm` | Saved simulation image. |

The custom rendering RTL is distinct from the MicroBlaze processor and other vendor IP used in the system.

## Running the Simulation

1. Clone or download the repository and open `Ray_Tracer.xpr` in Vivado 2025.2, the version recorded in the project file.
2. Check source and IP status, resolving any missing paths or generated IP output products before simulation.
3. Open `Ray_Tracer.srcs/sources_1/new/ray_tracer_tb.v` and change the `$fopen` output path to a writable location on your computer. The committed testbench currently contains an absolute development-machine path.
4. Set `ray_tracer_tb` as the simulation top and launch behavioral simulation.
5. Run until the testbench reports frame completion and finishes. It writes 307,200 pixels to a 640 × 480 PPM image, which can be opened with a PPM-compatible viewer or converted to PNG.

These steps describe the committed project and testbench; a clean-checkout reproduction has not yet been verified.

## Next Steps

The immediate priority is aligning pixel data and display timing to demonstrate correct VGA output on hardware.

Further planned work includes:

- Secondary rays for geometric shadows, additional geometry, and reflections.
- Separate rendering and display clock domains with FIFO buffering. A 250 MHz rendering clock is a future target, not an achieved result.
- Exploration of external display interfaces for 24-bit color output.
