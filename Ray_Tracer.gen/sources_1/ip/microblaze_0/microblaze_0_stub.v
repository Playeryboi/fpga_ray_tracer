// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat Jun 27 20:51:13 2026
// Host        : OmenLaptop16 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/herna/verilog_projects/Ray_Tracer/Ray_Tracer.gen/sources_1/ip/microblaze_0/microblaze_0_stub.v
// Design      : microblaze_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "microblaze_0,MicroBlaze,{}" *) (* core_generation_info = "microblaze_0,MicroBlaze,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=microblaze,x_ipVersion=11.0,x_ipCoreRevision=16,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_SCO=0,C_FREQ=0,C_USE_CONFIG_RESET=0,C_NUM_SYNC_FF_CLK=2,C_NUM_SYNC_FF_CLK_IRQ=1,C_NUM_SYNC_FF_CLK_DEBUG=2,C_NUM_SYNC_FF_DBG_CLK=1,C_NUM_SYNC_FF_DBG_TRACE_CLK=2,C_FAULT_TOLERANT=0,C_ECC_USE_CE_EXCEPTION=0,C_LOCKSTEP_SLAVE=0,C_LOCKSTEP_MASTER=0,C_TEMPORAL_DEPTH=0,C_ENDIANNESS=1,C_FAMILY=artix7,C_PART=xc7a100tcsg324-1,C_DATA_SIZE=32,C_LMB_DATA_SIZE=32,C_INSTR_SIZE=32,C_IADDR_SIZE=32,C_PIADDR_SIZE=32,C_DADDR_SIZE=32,C_INSTANCE=microblaze_0,C_AVOID_PRIMITIVES=0,C_AREA_OPTIMIZED=0,C_OPTIMIZATION=0,C_INTERCONNECT=2,C_BASE_VECTORS=0x0000000000000000,C_M_AXI_DP_THREAD_ID_WIDTH=1,C_M_AXI_DP_DATA_WIDTH=32,C_M_AXI_DP_ADDR_WIDTH=32,C_M_AXI_DP_EXCLUSIVE_ACCESS=0,C_M_AXI_D_BUS_EXCEPTION=0,C_M_AXI_IP_THREAD_ID_WIDTH=1,C_M_AXI_IP_DATA_WIDTH=32,C_M_AXI_IP_ADDR_WIDTH=32,C_M_AXI_I_BUS_EXCEPTION=0,C_D_LMB=1,C_D_LMB_PROTOCOL=0,C_D_LMB_HAS_PROT=0,C_D_AXI=0,C_I_LMB=1,C_I_LMB_PROTOCOL=0,C_I_LMB_HAS_PROT=0,C_I_AXI=0,G_TEMPLATE_LIST=0,C_USE_MSR_INSTR=0,C_USE_PCMP_INSTR=0,C_USE_BARREL=0,C_USE_DIV=0,C_USE_HW_MUL=0,C_USE_FPU=0,C_USE_REORDER_INSTR=1,C_UNALIGNED_EXCEPTIONS=0,C_ILL_OPCODE_EXCEPTION=0,C_DIV_ZERO_EXCEPTION=0,C_FPU_EXCEPTION=0,C_FSL_LINKS=4,C_USE_EXTENDED_FSL_INSTR=0,C_FSL_EXCEPTION=0,C_USE_STACK_PROTECTION=0,C_IMPRECISE_EXCEPTIONS=0,C_USE_INTERRUPT=0,C_USE_EXT_BRK=1,C_USE_EXT_NM_BRK=1,C_USE_NON_SECURE=1,C_USE_MMU=0,C_MMU_DTLB_SIZE=4,C_MMU_ITLB_SIZE=2,C_MMU_TLB_ACCESS=3,C_MMU_ZONES=16,C_MMU_PRIVILEGED_INSTR=0,C_USE_BRANCH_TARGET_CACHE=0,C_BRANCH_TARGET_CACHE_SIZE=0,C_PC_WIDTH=32,C_PVR=0,C_PVR_USER1=0x00,C_PVR_USER2=0x00000000,C_DYNAMIC_BUS_SIZING=0,C_RESET_MSR=0x00000000,C_OPCODE_0x0_ILLEGAL=0,C_DEBUG_ENABLED=0,C_DEBUG_INTERFACE=0,C_NUMBER_OF_PC_BRK=1,C_NUMBER_OF_RD_ADDR_BRK=0,C_NUMBER_OF_WR_ADDR_BRK=0,C_DEBUG_EVENT_COUNTERS=5,C_DEBUG_LATENCY_COUNTERS=1,C_DEBUG_COUNTER_WIDTH=32,C_DEBUG_TRACE_SIZE=8192,C_DEBUG_EXTERNAL_TRACE=0,C_DEBUG_TRACE_ASYNC_RESET=0,C_DEBUG_PROFILE_SIZE=0,C_INTERRUPT_IS_EDGE=0,C_EDGE_IS_POSITIVE=1,C_ASYNC_INTERRUPT=1,C_ASYNC_WAKEUP=1,C_M0_AXIS_DATA_WIDTH=32,C_S0_AXIS_DATA_WIDTH=32,C_M1_AXIS_DATA_WIDTH=32,C_S1_AXIS_DATA_WIDTH=32,C_M2_AXIS_DATA_WIDTH=32,C_S2_AXIS_DATA_WIDTH=32,C_M3_AXIS_DATA_WIDTH=32,C_S3_AXIS_DATA_WIDTH=32,C_M4_AXIS_DATA_WIDTH=32,C_S4_AXIS_DATA_WIDTH=32,C_M5_AXIS_DATA_WIDTH=32,C_S5_AXIS_DATA_WIDTH=32,C_M6_AXIS_DATA_WIDTH=32,C_S6_AXIS_DATA_WIDTH=32,C_M7_AXIS_DATA_WIDTH=32,C_S7_AXIS_DATA_WIDTH=32,C_M8_AXIS_DATA_WIDTH=32,C_S8_AXIS_DATA_WIDTH=32,C_M9_AXIS_DATA_WIDTH=32,C_S9_AXIS_DATA_WIDTH=32,C_M10_AXIS_DATA_WIDTH=32,C_S10_AXIS_DATA_WIDTH=32,C_M11_AXIS_DATA_WIDTH=32,C_S11_AXIS_DATA_WIDTH=32,C_M12_AXIS_DATA_WIDTH=32,C_S12_AXIS_DATA_WIDTH=32,C_M13_AXIS_DATA_WIDTH=32,C_S13_AXIS_DATA_WIDTH=32,C_M14_AXIS_DATA_WIDTH=32,C_S14_AXIS_DATA_WIDTH=32,C_M15_AXIS_DATA_WIDTH=32,C_S15_AXIS_DATA_WIDTH=32,C_ICACHE_BASEADDR=0x0000000000000000,C_ICACHE_HIGHADDR=0x000000003fffffff,C_USE_ICACHE=0,C_ALLOW_ICACHE_WR=1,C_ADDR_TAG_BITS=0,C_CACHE_BYTE_SIZE=8192,C_ICACHE_LINE_LEN=4,C_ICACHE_ALWAYS_USED=1,C_ICACHE_STREAMS=0,C_ICACHE_VICTIMS=0,C_ICACHE_FORCE_TAG_LUTRAM=0,C_ICACHE_DATA_WIDTH=0,C_M_AXI_IC_THREAD_ID_WIDTH=1,C_M_AXI_IC_DATA_WIDTH=32,C_M_AXI_IC_ADDR_WIDTH=32,C_M_AXI_IC_USER_VALUE=31,C_M_AXI_IC_AWUSER_WIDTH=5,C_M_AXI_IC_ARUSER_WIDTH=5,C_M_AXI_IC_WUSER_WIDTH=1,C_M_AXI_IC_RUSER_WIDTH=1,C_M_AXI_IC_BUSER_WIDTH=1,C_DCACHE_BASEADDR=0x0000000000000000,C_DCACHE_HIGHADDR=0x000000003fffffff,C_USE_DCACHE=0,C_ALLOW_DCACHE_WR=1,C_DCACHE_ADDR_TAG=0,C_DCACHE_BYTE_SIZE=8192,C_DCACHE_LINE_LEN=4,C_DCACHE_ALWAYS_USED=1,C_DCACHE_USE_WRITEBACK=0,C_DCACHE_VICTIMS=0,C_DCACHE_FORCE_TAG_LUTRAM=0,C_DCACHE_DATA_WIDTH=0,C_M_AXI_DC_THREAD_ID_WIDTH=1,C_M_AXI_DC_DATA_WIDTH=32,C_M_AXI_DC_ADDR_WIDTH=32,C_M_AXI_DC_EXCLUSIVE_ACCESS=0,C_M_AXI_DC_USER_VALUE=31,C_M_AXI_DC_AWUSER_WIDTH=5,C_M_AXI_DC_ARUSER_WIDTH=5,C_M_AXI_DC_WUSER_WIDTH=1,C_M_AXI_DC_RUSER_WIDTH=1,C_M_AXI_DC_BUSER_WIDTH=1}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "MicroBlaze,Vivado 2025.2" *) 
module microblaze_0(Clk, Reset, Interrupt, Interrupt_Address, 
  Interrupt_Ack, Ext_BRK, Ext_NM_BRK, Wakeup, Sleep, Hibernate, Suspend, Reset_Mode, Pause, 
  Pause_Ack, Non_Secure, Instr_Addr, Instr, IFetch, I_AS, IReady, IWAIT, ICE, IUE, Data_Addr, Data_Read, 
  Data_Write, D_AS, Read_Strobe, Write_Strobe, DReady, DWait, DCE, DUE, Byte_Enable, M0_AXIS_TLAST, 
  M0_AXIS_TDATA, M0_AXIS_TVALID, M0_AXIS_TREADY, M1_AXIS_TLAST, M1_AXIS_TDATA, 
  M1_AXIS_TVALID, M1_AXIS_TREADY, M2_AXIS_TLAST, M2_AXIS_TDATA, M2_AXIS_TVALID, 
  M2_AXIS_TREADY, M3_AXIS_TLAST, M3_AXIS_TDATA, M3_AXIS_TVALID, M3_AXIS_TREADY, 
  S0_AXIS_TLAST, S0_AXIS_TDATA, S0_AXIS_TVALID, S0_AXIS_TREADY, S1_AXIS_TLAST, S1_AXIS_TDATA, 
  S1_AXIS_TVALID, S1_AXIS_TREADY, S2_AXIS_TLAST, S2_AXIS_TDATA, S2_AXIS_TVALID, 
  S2_AXIS_TREADY, S3_AXIS_TLAST, S3_AXIS_TDATA, S3_AXIS_TVALID, S3_AXIS_TREADY)
/* synthesis syn_black_box black_box_pad_pin="Reset,Interrupt,Interrupt_Address[0:31],Interrupt_Ack[0:1],Ext_BRK,Ext_NM_BRK,Wakeup[0:1],Sleep,Hibernate,Suspend,Reset_Mode[0:1],Pause,Pause_Ack,Non_Secure[0:3],Instr_Addr[0:31],Instr[0:31],IFetch,I_AS,IReady,IWAIT,ICE,IUE,Data_Addr[0:31],Data_Read[0:31],Data_Write[0:31],D_AS,Read_Strobe,Write_Strobe,DReady,DWait,DCE,DUE,Byte_Enable[0:3],M0_AXIS_TLAST,M0_AXIS_TDATA[31:0],M0_AXIS_TVALID,M0_AXIS_TREADY,M1_AXIS_TLAST,M1_AXIS_TDATA[31:0],M1_AXIS_TVALID,M1_AXIS_TREADY,M2_AXIS_TLAST,M2_AXIS_TDATA[31:0],M2_AXIS_TVALID,M2_AXIS_TREADY,M3_AXIS_TLAST,M3_AXIS_TDATA[31:0],M3_AXIS_TVALID,M3_AXIS_TREADY,S0_AXIS_TLAST,S0_AXIS_TDATA[31:0],S0_AXIS_TVALID,S0_AXIS_TREADY,S1_AXIS_TLAST,S1_AXIS_TDATA[31:0],S1_AXIS_TVALID,S1_AXIS_TREADY,S2_AXIS_TLAST,S2_AXIS_TDATA[31:0],S2_AXIS_TVALID,S2_AXIS_TREADY,S3_AXIS_TLAST,S3_AXIS_TDATA[31:0],S3_AXIS_TVALID,S3_AXIS_TREADY" */
/* synthesis syn_force_seq_prim="Clk" */;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* x_interface_mode = "slave CLK.CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_BUSIF M0_AXIS:S0_AXIS:M1_AXIS:S1_AXIS:M2_AXIS:S2_AXIS:M3_AXIS:S3_AXIS:M4_AXIS:S4_AXIS:M5_AXIS:S5_AXIS:M6_AXIS:S6_AXIS:M7_AXIS:S7_AXIS:M8_AXIS:S8_AXIS:M9_AXIS:S9_AXIS:M10_AXIS:S10_AXIS:M11_AXIS:S11_AXIS:M12_AXIS:S12_AXIS:M13_AXIS:S13_AXIS:M14_AXIS:S14_AXIS:M15_AXIS:S15_AXIS:DLMB:ILMB:M_AXI_DP:M_AXI_IP:M_AXI_DC:M_AXI_IC:M_ACE_DC:M_ACE_IC:MON_DLMB:MON_ILMB:MON_AXI_DP:MON_AXI_IP:MON_AXI_DC:MON_AXI_IC:MON_ACE_DC:MON_ACE_IC, ASSOCIATED_RESET Reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input Clk /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* x_interface_mode = "slave RST.RESET" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.RESET, POLARITY ACTIVE_HIGH, TYPE PROCESSOR, INSERT_VIP 0" *) input Reset;
  (* x_interface_info = "xilinx.com:interface:mbinterrupt:1.0 INTERRUPT INTERRUPT" *) (* x_interface_mode = "slave INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME INTERRUPT, SENSITIVITY LEVEL_HIGH, LOW_LATENCY 0" *) input Interrupt;
  (* x_interface_info = "xilinx.com:interface:mbinterrupt:1.0 INTERRUPT ADDRESS" *) input [0:31]Interrupt_Address;
  (* x_interface_info = "xilinx.com:interface:mbinterrupt:1.0 INTERRUPT ACK" *) output [0:1]Interrupt_Ack;
  input Ext_BRK;
  input Ext_NM_BRK;
  input [0:1]Wakeup;
  output Sleep;
  output Hibernate;
  output Suspend;
  input [0:1]Reset_Mode;
  input Pause;
  output Pause_Ack;
  input [0:3]Non_Secure;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB ABUS" *) (* x_interface_mode = "master ILMB" *) (* x_interface_parameter = "XIL_INTERFACENAME ILMB, ADDR_WIDTH 32, DATA_WIDTH 32, PROTOCOL STANDARD, HAS_PROT 0, READ_WRITE_MODE READ_ONLY" *) output [0:31]Instr_Addr;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB READDBUS" *) input [0:31]Instr;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB READSTROBE" *) output IFetch;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB ADDRSTROBE" *) output I_AS;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB READY" *) input IReady;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB WAIT" *) input IWAIT;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB CE" *) input ICE;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 ILMB UE" *) input IUE;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB ABUS" *) (* x_interface_mode = "master DLMB" *) (* x_interface_parameter = "XIL_INTERFACENAME DLMB, ADDR_WIDTH 32, DATA_WIDTH 32, PROTOCOL STANDARD, HAS_PROT 0, READ_WRITE_MODE READ_WRITE" *) output [0:31]Data_Addr;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB READDBUS" *) input [0:31]Data_Read;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB WRITEDBUS" *) output [0:31]Data_Write;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB ADDRSTROBE" *) output D_AS;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB READSTROBE" *) output Read_Strobe;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB WRITESTROBE" *) output Write_Strobe;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB READY" *) input DReady;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB WAIT" *) input DWait;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB CE" *) input DCE;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB UE" *) input DUE;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 DLMB BE" *) output [0:3]Byte_Enable;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M0_AXIS TLAST" *) (* x_interface_mode = "master M0_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME M0_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output M0_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M0_AXIS TDATA" *) output [31:0]M0_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M0_AXIS TVALID" *) output M0_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M0_AXIS TREADY" *) input M0_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M1_AXIS TLAST" *) (* x_interface_mode = "master M1_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME M1_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output M1_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M1_AXIS TDATA" *) output [31:0]M1_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M1_AXIS TVALID" *) output M1_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M1_AXIS TREADY" *) input M1_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M2_AXIS TLAST" *) (* x_interface_mode = "master M2_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME M2_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output M2_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M2_AXIS TDATA" *) output [31:0]M2_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M2_AXIS TVALID" *) output M2_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M2_AXIS TREADY" *) input M2_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M3_AXIS TLAST" *) (* x_interface_mode = "master M3_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME M3_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output M3_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M3_AXIS TDATA" *) output [31:0]M3_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M3_AXIS TVALID" *) output M3_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M3_AXIS TREADY" *) input M3_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S0_AXIS TLAST" *) (* x_interface_mode = "slave S0_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME S0_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input S0_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S0_AXIS TDATA" *) input [31:0]S0_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S0_AXIS TVALID" *) input S0_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S0_AXIS TREADY" *) output S0_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S1_AXIS TLAST" *) (* x_interface_mode = "slave S1_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME S1_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input S1_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S1_AXIS TDATA" *) input [31:0]S1_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S1_AXIS TVALID" *) input S1_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S1_AXIS TREADY" *) output S1_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S2_AXIS TLAST" *) (* x_interface_mode = "slave S2_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME S2_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input S2_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S2_AXIS TDATA" *) input [31:0]S2_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S2_AXIS TVALID" *) input S2_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S2_AXIS TREADY" *) output S2_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S3_AXIS TLAST" *) (* x_interface_mode = "slave S3_AXIS" *) (* x_interface_parameter = "XIL_INTERFACENAME S3_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input S3_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S3_AXIS TDATA" *) input [31:0]S3_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S3_AXIS TVALID" *) input S3_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S3_AXIS TREADY" *) output S3_AXIS_TREADY;
endmodule
