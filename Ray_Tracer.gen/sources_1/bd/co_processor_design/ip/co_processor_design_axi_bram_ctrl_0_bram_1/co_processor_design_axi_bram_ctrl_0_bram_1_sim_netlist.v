// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat Jul 25 11:37:18 2026
// Host        : OmenLaptop16 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/herna/verilog_projects/Ray_Tracer/Ray_Tracer.gen/sources_1/bd/co_processor_design/ip/co_processor_design_axi_bram_ctrl_0_bram_1/co_processor_design_axi_bram_ctrl_0_bram_1_sim_netlist.v
// Design      : co_processor_design_axi_bram_ctrl_0_bram_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "co_processor_design_axi_bram_ctrl_0_bram_1,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module co_processor_design_axi_bram_ctrl_0_bram_1
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    web,
    addrb,
    dinb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 4096, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 4096, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire rsta;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.9299 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "co_processor_design_axi_bram_ctrl_0_bram_1.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  co_processor_design_axi_bram_ctrl_0_bram_1_blk_mem_gen_v8_4_12 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[11:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[11:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YqH9kwIC39+qbZg4PSfFsXuB9k9wnuxNryS/CfnEri6Ci9fSC6fsrQ/T/hnt3u/yolbJ8DJa1Qu6
Qnm24A9jLbA+fu3Nsmm6/rM6a4vU6OfVl/gTFd/CiWDutv6Dhn6Lim4uUNPahoOR/A2Yc4Zo2tdI
kMLO9gn9WlH2l3O2oXs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XJYO2VHd/cnMxQd3i7/2qRhl57dl+doEKuhAunQyv3vpGRG/jlNxj8PqrgLoF0HMdqE3qJUVE/oq
kBSapqjVjLDMOrNGQ+Tc6VGsKMZH8FE/TXHQJ/IM5Iuiu2eozEwwVUomF+7cfqn+9OsVsqCONQ1M
g0oRlangiqasJDhhMfnlGGqwAwmgWRGQA6dmhTuua1s8zdvIv540zY6p5au8cAKVhqyyKK7wbxEE
SGuFqX+NYoyRV+rfWCcWM+hJEmnWS8LNAKkd13YE2+17sPYzUdZ23DmTxXK6KlAxKFW27CBySUfg
qdNXp2DSs2KAQYih27pBNMuHfGbM/ATFPWFvxg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lYoEi/e8HsDTz6N11EDe/B/iitERmeYndlCklmCluwgb0N4W80JUGVlkd7NlRZHRNhxaNBJPkcjC
n61nO0tb17NwsMwjbY5TF8JWRYTNw1JXCFacvQYrdKv4/7QNQEtwVGiCLxFhOA8aHlWMZIrc2fri
VRMVWaEBcPwCGorlVIM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QEw9fEsWFbdX0OQLvYs/gl+zyEOW3ak9TdQVaq+0AXXOT3LIqF7wDxJ6ZBnlf9mNbdsUVH5tAz1o
H8u7ihJl1L3THEvugW+TS8hkvVbEA9rKO2vV15KAj4Lla7UdFT/xDfe79RFarlLI7yGrubjgdoRi
QWy//UKsffG7IWNwmoSuppWiWB4ZHJtkunNyIkm70JPGyZF62VxJg1MTT+5LUbZG5vZjjuHZud9w
xJaKv1tFP/x8RVqLU5gPOqGqTW7/nKO2S+450Vo4D9vAmBVVcXpaL1EbSmCvQ+qJmcQKtf9qYFRV
Zko08hbpHjPxstqvTDro01jRzB8592m4xU2TWA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TC7q853CWBPPJgbRfgDV1lmjUwSAtliljShAyNFg8sfRfwDzchthzoSPH1UCHV++E2JXacEKq1lB
UWsNP92U4Xh0/Gu+6esOI0pJb8I+TRTxyBN1I4cRQEfQHcwfhbSdeH3yX9OV3opLEqYmT37hWU+J
zCawYnxVESI0FtRzEXve9gdEWlrKKckrT/hp4mvxxOjvOkOSQBvy0elgUOqh6mEOZl+JnUbsR+Wm
CoZLE1eefMZy3FnVmyDNPv3JPXi88aLXMyimal0MYFkTiS4XJiGT3eAIMIbksehXY+eYi/KFpZWQ
GHpX+lG3UmiWWLwyPakFwKEHbrBc70AlJ2eV9g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j9nmCKgjPWNChPbpSW6EWLrMA6oCG2JGPoum8px09v0PEAh0DRXZi0J8HPzXUsZgOEMcKpA7X54u
YFcDDCLAQ+urha/eSPbQYHQh4yGCursxAQ1C6LEyNQ2wJ0eLlO2bJeAl/gof06zqsYVM2lLJVNv5
wao1k2bmgPdfpfY3c9vPD0fSMuZPS41EoRS0cQhO5GTZnKdjxm6tEUL3GnTjB8ynSCIbCJUsMtAX
4FRHNa52gudx5B5fagR+lXgFhE7e++rWTJELr7SYB+r5Es8qZLTpCH8TrQxEkV0rY/+e4sAjNE2D
gHw8GD7VcUtc15B8y1BbVmh29qc8Nd3V2i/miA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UkCD6I/Vye4qNoNoa3hIexBXG3xyKUJPAHAjIo7UcNVCDXpMQiYEtPDqExZMfiPlJn2nswCYIfIJ
FYWqMCloKSQyyI/7yZ2EtbyWEklb/P5IyZyvGi6hhFUo/JFTb12b4bK0gZPr+bCDdlVQKTx5GVHz
wptdUJO2omSj8axVMPbLRRtVzlJIZ29dTJ2ATXVXAcBxPnFfHRAMnYYKLeeLExX61vQvpqrkLQHm
XG7hpVzJi56gYKAzxa2BLq072OCVpVS70bfWlhlSTVcSlCrUf+EcarEk4FD8+Ih2NCvrqremG6yn
TtcBn8Xr8M/6zhOYvLi6AD6eArDMKA8n+Ccv8A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
A5y5QVZU8yjPexRVPioSiAGohCHD5DX5FVobuMyhcgQRExLUhPvnnS8HOtxTj/2IapEcz68gFMGG
Hpi+m725u85/om/Vze9pGIW9Mn328Kz2FIg3W5EvGstfGwY+48LiAGAmTR269JS4lJGVYWYOz7Xk
S8cEsFd2m7j8iyKtARJzD90+UdXq/cIIh725jC9i8nbgxB364zddvm1Z/DF3JRw1qFp6GGcuRai1
KNcJ1j8c9wtIgktpsteU3e5+bxHEw8NT3gWXUFYjm00NDq97Jals8Jjktmum2nQxoF7ivPacfEey
gnSF6jRMkTsZObzc30hAhs0CEtc33hZLhPLHSn8pQ0WyvKJLHdd5s2yckgTZtqxC1Sbwe7WEgNXe
ZMX3pIkz+aoXsAL7GBLyVBMVQcyMoF0w8QGAaTe8sqatABwPqXidYRqNROTf62IYcMpV89XYgaTv
EwIn/oni9KOFd2BFVxRZbFGGC4IjvigsTBUijI+Dk6kVnDh240clGcc4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Omtp+lCaqUx7Z4qdFj2zrN8LpCkit2eX4hlMtig+ielGm/x4FSZkpjoFmiqdKFPi2eg0pg09MSai
XyGH68UzAR7Xrj8f1jlIoUmMKp4GcxfdqfTeuu7kWGOJEP6cvgTjSJFj2gawDv7f4yZcltnK2x0L
e4GW/rBTmGvZtKWb2ahjINLxPuh3dDaSaWdb+zVgbtyrI5FrjxBkq+aOxSjyNsqnCx1L0uWbxnkl
88NbXN3dTaECXHNm/fsleayM5hKis7kTv9BFajJMGy+BhQlmIYpE+F5zchnTTFUFJZCz1sX9Fc8e
HcY7irB8mR3ajdzjUZLBQEMktp096Nheq3U75A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hpeBLwN9x2ZFDwroYLlUe5GjjDepHik2l0c2s3/6S7JPCRkzQSyt2V1Ad/JewAs/QNp5SXSbYYB4
rQl0My1LDMF3xw43r0g2IbcyHVpPhGp0W5msuQdF67afnsRv90iJYWLMI3QkYGCTWAzl4HrLxFSg
3z8XZRK670IcxznOrlvgHmIKsvubZrBkuc1EynrVb9Nw16QnIx2rc4WgcEXeFf+4i1RoYLDd3gXK
NFCNMdtaRYUThunFP6Z4ViZ5UnDmKq+IMhd31jTaqIlWOBDxPI1+v5RJYxIyTbn4rxlKR2fNbl5/
z4OUjBTd+1GH3I2OXlqmAOvIhpe2Z2HH7nZu/A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Mt2RhTSUwEIEWeNARbyL+EdfS1UF6nPaL/fKl/7oO2gina93egwCWDLl1fbBtkfaPco0cu4MJ9K3
OraAsyHRlY+MNShmJ1LzAIA1LjZx4y55lu9dlQqSUXR7AW7wVbkg1864mK+hM/1XygU0jvebKNW9
B7xSER+asLO6pxi0mt7uC2PHxLPAYEszFhmnap82TtbDGdQ2qtyekY+ngs+N2fAdsblxVwJruiMl
e6XJ127M8N1mYwhWU2HtRpBOSnnKoHgD9fG51XK/rhk8DxT66QnX9uLPB+H25eDupBJGi1Y5o6x8
hOwZiSUVlBLh7brfzevh7+eRn+7es6wBas0+3w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 40256)
`pragma protect data_block
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
SJcxDCgKIrvkz87eM+8=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
