// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: xilinx.com:ip:microblaze:11.0
// IP Revision: 16

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
microblaze_0 your_instance_name (
  .Clk(Clk),                              // input wire Clk
  .Reset(Reset),                          // input wire Reset
  .Interrupt(Interrupt),                  // input wire Interrupt
  .Interrupt_Address(Interrupt_Address),  // input wire [0 : 31] Interrupt_Address
  .Interrupt_Ack(Interrupt_Ack),          // output wire [0 : 1] Interrupt_Ack
  .Ext_BRK(Ext_BRK),                      // input wire Ext_BRK
  .Ext_NM_BRK(Ext_NM_BRK),                // input wire Ext_NM_BRK
  .Wakeup(Wakeup),                        // input wire [0 : 1] Wakeup
  .Sleep(Sleep),                          // output wire Sleep
  .Hibernate(Hibernate),                  // output wire Hibernate
  .Suspend(Suspend),                      // output wire Suspend
  .Reset_Mode(Reset_Mode),                // input wire [0 : 1] Reset_Mode
  .Pause(Pause),                          // input wire Pause
  .Pause_Ack(Pause_Ack),                  // output wire Pause_Ack
  .Non_Secure(Non_Secure),                // input wire [0 : 3] Non_Secure
  .Instr_Addr(Instr_Addr),                // output wire [0 : 31] Instr_Addr
  .Instr(Instr),                          // input wire [0 : 31] Instr
  .IFetch(IFetch),                        // output wire IFetch
  .I_AS(I_AS),                            // output wire I_AS
  .IReady(IReady),                        // input wire IReady
  .IWAIT(IWAIT),                          // input wire IWAIT
  .ICE(ICE),                              // input wire ICE
  .IUE(IUE),                              // input wire IUE
  .Data_Addr(Data_Addr),                  // output wire [0 : 31] Data_Addr
  .Data_Read(Data_Read),                  // input wire [0 : 31] Data_Read
  .Data_Write(Data_Write),                // output wire [0 : 31] Data_Write
  .D_AS(D_AS),                            // output wire D_AS
  .Read_Strobe(Read_Strobe),              // output wire Read_Strobe
  .Write_Strobe(Write_Strobe),            // output wire Write_Strobe
  .DReady(DReady),                        // input wire DReady
  .DWait(DWait),                          // input wire DWait
  .DCE(DCE),                              // input wire DCE
  .DUE(DUE),                              // input wire DUE
  .Byte_Enable(Byte_Enable),              // output wire [0 : 3] Byte_Enable
  .M0_AXIS_TLAST(M0_AXIS_TLAST),          // output wire M0_AXIS_TLAST
  .M0_AXIS_TDATA(M0_AXIS_TDATA),          // output wire [31 : 0] M0_AXIS_TDATA
  .M0_AXIS_TVALID(M0_AXIS_TVALID),        // output wire M0_AXIS_TVALID
  .M0_AXIS_TREADY(M0_AXIS_TREADY),        // input wire M0_AXIS_TREADY
  .M1_AXIS_TLAST(M1_AXIS_TLAST),          // output wire M1_AXIS_TLAST
  .M1_AXIS_TDATA(M1_AXIS_TDATA),          // output wire [31 : 0] M1_AXIS_TDATA
  .M1_AXIS_TVALID(M1_AXIS_TVALID),        // output wire M1_AXIS_TVALID
  .M1_AXIS_TREADY(M1_AXIS_TREADY),        // input wire M1_AXIS_TREADY
  .M2_AXIS_TLAST(M2_AXIS_TLAST),          // output wire M2_AXIS_TLAST
  .M2_AXIS_TDATA(M2_AXIS_TDATA),          // output wire [31 : 0] M2_AXIS_TDATA
  .M2_AXIS_TVALID(M2_AXIS_TVALID),        // output wire M2_AXIS_TVALID
  .M2_AXIS_TREADY(M2_AXIS_TREADY),        // input wire M2_AXIS_TREADY
  .M3_AXIS_TLAST(M3_AXIS_TLAST),          // output wire M3_AXIS_TLAST
  .M3_AXIS_TDATA(M3_AXIS_TDATA),          // output wire [31 : 0] M3_AXIS_TDATA
  .M3_AXIS_TVALID(M3_AXIS_TVALID),        // output wire M3_AXIS_TVALID
  .M3_AXIS_TREADY(M3_AXIS_TREADY),        // input wire M3_AXIS_TREADY
  .S0_AXIS_TLAST(S0_AXIS_TLAST),          // input wire S0_AXIS_TLAST
  .S0_AXIS_TDATA(S0_AXIS_TDATA),          // input wire [31 : 0] S0_AXIS_TDATA
  .S0_AXIS_TVALID(S0_AXIS_TVALID),        // input wire S0_AXIS_TVALID
  .S0_AXIS_TREADY(S0_AXIS_TREADY),        // output wire S0_AXIS_TREADY
  .S1_AXIS_TLAST(S1_AXIS_TLAST),          // input wire S1_AXIS_TLAST
  .S1_AXIS_TDATA(S1_AXIS_TDATA),          // input wire [31 : 0] S1_AXIS_TDATA
  .S1_AXIS_TVALID(S1_AXIS_TVALID),        // input wire S1_AXIS_TVALID
  .S1_AXIS_TREADY(S1_AXIS_TREADY),        // output wire S1_AXIS_TREADY
  .S2_AXIS_TLAST(S2_AXIS_TLAST),          // input wire S2_AXIS_TLAST
  .S2_AXIS_TDATA(S2_AXIS_TDATA),          // input wire [31 : 0] S2_AXIS_TDATA
  .S2_AXIS_TVALID(S2_AXIS_TVALID),        // input wire S2_AXIS_TVALID
  .S2_AXIS_TREADY(S2_AXIS_TREADY),        // output wire S2_AXIS_TREADY
  .S3_AXIS_TLAST(S3_AXIS_TLAST),          // input wire S3_AXIS_TLAST
  .S3_AXIS_TDATA(S3_AXIS_TDATA),          // input wire [31 : 0] S3_AXIS_TDATA
  .S3_AXIS_TVALID(S3_AXIS_TVALID),        // input wire S3_AXIS_TVALID
  .S3_AXIS_TREADY(S3_AXIS_TREADY)        // output wire S3_AXIS_TREADY
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file microblaze_0.v when simulating
// the core, microblaze_0. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

