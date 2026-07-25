// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------
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

// MODULE VLNV: xilinx.com:ip:microblaze:11.0

`timescale 1ps / 1ps

`include "vivado_interfaces.svh"

module microblaze_0_sv (
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M0_AXIS" *)
  (* X_INTERFACE_MODE = "master M0_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M0_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.master M0_AXIS,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S0_AXIS" *)
  (* X_INTERFACE_MODE = "slave S0_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S0_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.slave S0_AXIS,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M1_AXIS" *)
  (* X_INTERFACE_MODE = "master M1_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M1_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.master M1_AXIS,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S1_AXIS" *)
  (* X_INTERFACE_MODE = "slave S1_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S1_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.slave S1_AXIS,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M2_AXIS" *)
  (* X_INTERFACE_MODE = "master M2_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M2_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.master M2_AXIS,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S2_AXIS" *)
  (* X_INTERFACE_MODE = "slave S2_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S2_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.slave S2_AXIS,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M3_AXIS" *)
  (* X_INTERFACE_MODE = "master M3_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M3_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.master M3_AXIS,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S3_AXIS" *)
  (* X_INTERFACE_MODE = "slave S3_AXIS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S3_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.slave S3_AXIS,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire Clk,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire Reset,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire Interrupt,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [0:31] Interrupt_Address,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:1] Interrupt_Ack,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire Ext_BRK,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire Ext_NM_BRK,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [0:1] Wakeup,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire Sleep,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire Hibernate,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire Suspend,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [0:1] Reset_Mode,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire Pause,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire Pause_Ack,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [0:3] Non_Secure,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:31] Instr_Addr,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [0:31] Instr,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire IFetch,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire I_AS,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire IReady,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire IWAIT,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire ICE,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire IUE,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:31] Data_Addr,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [0:31] Data_Read,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:31] Data_Write,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire D_AS,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire Read_Strobe,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire Write_Strobe,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire DReady,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire DWait,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire DCE,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire DUE,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:3] Byte_Enable
);

  // interface wire assignments
  assign M0_AXIS.TDEST = 0;
  assign M0_AXIS.TID = 0;
  assign M0_AXIS.TKEEP = 0;
  assign M0_AXIS.TSTRB = 0;
  assign M0_AXIS.TUSER = 0;
  assign M1_AXIS.TDEST = 0;
  assign M1_AXIS.TID = 0;
  assign M1_AXIS.TKEEP = 0;
  assign M1_AXIS.TSTRB = 0;
  assign M1_AXIS.TUSER = 0;
  assign M2_AXIS.TDEST = 0;
  assign M2_AXIS.TID = 0;
  assign M2_AXIS.TKEEP = 0;
  assign M2_AXIS.TSTRB = 0;
  assign M2_AXIS.TUSER = 0;
  assign M3_AXIS.TDEST = 0;
  assign M3_AXIS.TID = 0;
  assign M3_AXIS.TKEEP = 0;
  assign M3_AXIS.TSTRB = 0;
  assign M3_AXIS.TUSER = 0;

  microblaze_0 inst (
    .Clk(Clk),
    .Reset(Reset),
    .Interrupt(Interrupt),
    .Interrupt_Address(Interrupt_Address),
    .Interrupt_Ack(Interrupt_Ack),
    .Ext_BRK(Ext_BRK),
    .Ext_NM_BRK(Ext_NM_BRK),
    .Wakeup(Wakeup),
    .Sleep(Sleep),
    .Hibernate(Hibernate),
    .Suspend(Suspend),
    .Reset_Mode(Reset_Mode),
    .Pause(Pause),
    .Pause_Ack(Pause_Ack),
    .Non_Secure(Non_Secure),
    .Instr_Addr(Instr_Addr),
    .Instr(Instr),
    .IFetch(IFetch),
    .I_AS(I_AS),
    .IReady(IReady),
    .IWAIT(IWAIT),
    .ICE(ICE),
    .IUE(IUE),
    .Data_Addr(Data_Addr),
    .Data_Read(Data_Read),
    .Data_Write(Data_Write),
    .D_AS(D_AS),
    .Read_Strobe(Read_Strobe),
    .Write_Strobe(Write_Strobe),
    .DReady(DReady),
    .DWait(DWait),
    .DCE(DCE),
    .DUE(DUE),
    .Byte_Enable(Byte_Enable),
    .M0_AXIS_TLAST(M0_AXIS.TLAST),
    .M0_AXIS_TDATA(M0_AXIS.TDATA),
    .M0_AXIS_TVALID(M0_AXIS.TVALID),
    .M0_AXIS_TREADY(M0_AXIS.TREADY),
    .M1_AXIS_TLAST(M1_AXIS.TLAST),
    .M1_AXIS_TDATA(M1_AXIS.TDATA),
    .M1_AXIS_TVALID(M1_AXIS.TVALID),
    .M1_AXIS_TREADY(M1_AXIS.TREADY),
    .M2_AXIS_TLAST(M2_AXIS.TLAST),
    .M2_AXIS_TDATA(M2_AXIS.TDATA),
    .M2_AXIS_TVALID(M2_AXIS.TVALID),
    .M2_AXIS_TREADY(M2_AXIS.TREADY),
    .M3_AXIS_TLAST(M3_AXIS.TLAST),
    .M3_AXIS_TDATA(M3_AXIS.TDATA),
    .M3_AXIS_TVALID(M3_AXIS.TVALID),
    .M3_AXIS_TREADY(M3_AXIS.TREADY),
    .S0_AXIS_TLAST(S0_AXIS.TLAST),
    .S0_AXIS_TDATA(S0_AXIS.TDATA),
    .S0_AXIS_TVALID(S0_AXIS.TVALID),
    .S0_AXIS_TREADY(S0_AXIS.TREADY),
    .S1_AXIS_TLAST(S1_AXIS.TLAST),
    .S1_AXIS_TDATA(S1_AXIS.TDATA),
    .S1_AXIS_TVALID(S1_AXIS.TVALID),
    .S1_AXIS_TREADY(S1_AXIS.TREADY),
    .S2_AXIS_TLAST(S2_AXIS.TLAST),
    .S2_AXIS_TDATA(S2_AXIS.TDATA),
    .S2_AXIS_TVALID(S2_AXIS.TVALID),
    .S2_AXIS_TREADY(S2_AXIS.TREADY),
    .S3_AXIS_TLAST(S3_AXIS.TLAST),
    .S3_AXIS_TDATA(S3_AXIS.TDATA),
    .S3_AXIS_TVALID(S3_AXIS.TVALID),
    .S3_AXIS_TREADY(S3_AXIS.TREADY)
  );

endmodule
