// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat Jun 27 14:25:08 2026
// Host        : OmenLaptop16 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/herna/verilog_projects/Ray_Tracer/Ray_Tracer.gen/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    enb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [3:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [3:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [15:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [3:0]addra;
  wire [3:0]addrb;
  wire clka;
  wire clkb;
  wire [15:0]dina;
  wire [15:0]dinb;
  wire [15:0]douta;
  wire [15:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire [0:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [3:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "4" *) 
  (* C_ADDRB_WIDTH = "4" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.0361 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "16" *) 
  (* C_READ_DEPTH_B = "16" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "16" *) 
  (* C_WRITE_DEPTH_B = "16" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_12 U0
       (.addra(addra),
        .addrb(addrb),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[3:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[3:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19936)
`pragma protect data_block
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
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
