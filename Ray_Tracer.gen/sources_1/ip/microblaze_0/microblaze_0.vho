-- (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.
-- IP VLNV: xilinx.com:ip:microblaze:11.0
-- IP Revision: 16

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT microblaze_0
  PORT (
    Clk : IN STD_LOGIC;
    Reset : IN STD_LOGIC;
    Interrupt : IN STD_LOGIC;
    Interrupt_Address : IN STD_LOGIC_VECTOR(0 TO 31);
    Interrupt_Ack : OUT STD_LOGIC_VECTOR(0 TO 1);
    Ext_BRK : IN STD_LOGIC;
    Ext_NM_BRK : IN STD_LOGIC;
    Wakeup : IN STD_LOGIC_VECTOR(0 TO 1);
    Sleep : OUT STD_LOGIC;
    Hibernate : OUT STD_LOGIC;
    Suspend : OUT STD_LOGIC;
    Reset_Mode : IN STD_LOGIC_VECTOR(0 TO 1);
    Pause : IN STD_LOGIC;
    Pause_Ack : OUT STD_LOGIC;
    Non_Secure : IN STD_LOGIC_VECTOR(0 TO 3);
    Instr_Addr : OUT STD_LOGIC_VECTOR(0 TO 31);
    Instr : IN STD_LOGIC_VECTOR(0 TO 31);
    IFetch : OUT STD_LOGIC;
    I_AS : OUT STD_LOGIC;
    IReady : IN STD_LOGIC;
    IWAIT : IN STD_LOGIC;
    ICE : IN STD_LOGIC;
    IUE : IN STD_LOGIC;
    Data_Addr : OUT STD_LOGIC_VECTOR(0 TO 31);
    Data_Read : IN STD_LOGIC_VECTOR(0 TO 31);
    Data_Write : OUT STD_LOGIC_VECTOR(0 TO 31);
    D_AS : OUT STD_LOGIC;
    Read_Strobe : OUT STD_LOGIC;
    Write_Strobe : OUT STD_LOGIC;
    DReady : IN STD_LOGIC;
    DWait : IN STD_LOGIC;
    DCE : IN STD_LOGIC;
    DUE : IN STD_LOGIC;
    Byte_Enable : OUT STD_LOGIC_VECTOR(0 TO 3);
    M0_AXIS_TLAST : OUT STD_LOGIC;
    M0_AXIS_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M0_AXIS_TVALID : OUT STD_LOGIC;
    M0_AXIS_TREADY : IN STD_LOGIC;
    M1_AXIS_TLAST : OUT STD_LOGIC;
    M1_AXIS_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M1_AXIS_TVALID : OUT STD_LOGIC;
    M1_AXIS_TREADY : IN STD_LOGIC;
    M2_AXIS_TLAST : OUT STD_LOGIC;
    M2_AXIS_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M2_AXIS_TVALID : OUT STD_LOGIC;
    M2_AXIS_TREADY : IN STD_LOGIC;
    M3_AXIS_TLAST : OUT STD_LOGIC;
    M3_AXIS_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M3_AXIS_TVALID : OUT STD_LOGIC;
    M3_AXIS_TREADY : IN STD_LOGIC;
    S0_AXIS_TLAST : IN STD_LOGIC;
    S0_AXIS_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S0_AXIS_TVALID : IN STD_LOGIC;
    S0_AXIS_TREADY : OUT STD_LOGIC;
    S1_AXIS_TLAST : IN STD_LOGIC;
    S1_AXIS_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S1_AXIS_TVALID : IN STD_LOGIC;
    S1_AXIS_TREADY : OUT STD_LOGIC;
    S2_AXIS_TLAST : IN STD_LOGIC;
    S2_AXIS_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S2_AXIS_TVALID : IN STD_LOGIC;
    S2_AXIS_TREADY : OUT STD_LOGIC;
    S3_AXIS_TLAST : IN STD_LOGIC;
    S3_AXIS_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S3_AXIS_TVALID : IN STD_LOGIC;
    S3_AXIS_TREADY : OUT STD_LOGIC 
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : microblaze_0
  PORT MAP (
    Clk => Clk,
    Reset => Reset,
    Interrupt => Interrupt,
    Interrupt_Address => Interrupt_Address,
    Interrupt_Ack => Interrupt_Ack,
    Ext_BRK => Ext_BRK,
    Ext_NM_BRK => Ext_NM_BRK,
    Wakeup => Wakeup,
    Sleep => Sleep,
    Hibernate => Hibernate,
    Suspend => Suspend,
    Reset_Mode => Reset_Mode,
    Pause => Pause,
    Pause_Ack => Pause_Ack,
    Non_Secure => Non_Secure,
    Instr_Addr => Instr_Addr,
    Instr => Instr,
    IFetch => IFetch,
    I_AS => I_AS,
    IReady => IReady,
    IWAIT => IWAIT,
    ICE => ICE,
    IUE => IUE,
    Data_Addr => Data_Addr,
    Data_Read => Data_Read,
    Data_Write => Data_Write,
    D_AS => D_AS,
    Read_Strobe => Read_Strobe,
    Write_Strobe => Write_Strobe,
    DReady => DReady,
    DWait => DWait,
    DCE => DCE,
    DUE => DUE,
    Byte_Enable => Byte_Enable,
    M0_AXIS_TLAST => M0_AXIS_TLAST,
    M0_AXIS_TDATA => M0_AXIS_TDATA,
    M0_AXIS_TVALID => M0_AXIS_TVALID,
    M0_AXIS_TREADY => M0_AXIS_TREADY,
    M1_AXIS_TLAST => M1_AXIS_TLAST,
    M1_AXIS_TDATA => M1_AXIS_TDATA,
    M1_AXIS_TVALID => M1_AXIS_TVALID,
    M1_AXIS_TREADY => M1_AXIS_TREADY,
    M2_AXIS_TLAST => M2_AXIS_TLAST,
    M2_AXIS_TDATA => M2_AXIS_TDATA,
    M2_AXIS_TVALID => M2_AXIS_TVALID,
    M2_AXIS_TREADY => M2_AXIS_TREADY,
    M3_AXIS_TLAST => M3_AXIS_TLAST,
    M3_AXIS_TDATA => M3_AXIS_TDATA,
    M3_AXIS_TVALID => M3_AXIS_TVALID,
    M3_AXIS_TREADY => M3_AXIS_TREADY,
    S0_AXIS_TLAST => S0_AXIS_TLAST,
    S0_AXIS_TDATA => S0_AXIS_TDATA,
    S0_AXIS_TVALID => S0_AXIS_TVALID,
    S0_AXIS_TREADY => S0_AXIS_TREADY,
    S1_AXIS_TLAST => S1_AXIS_TLAST,
    S1_AXIS_TDATA => S1_AXIS_TDATA,
    S1_AXIS_TVALID => S1_AXIS_TVALID,
    S1_AXIS_TREADY => S1_AXIS_TREADY,
    S2_AXIS_TLAST => S2_AXIS_TLAST,
    S2_AXIS_TDATA => S2_AXIS_TDATA,
    S2_AXIS_TVALID => S2_AXIS_TVALID,
    S2_AXIS_TREADY => S2_AXIS_TREADY,
    S3_AXIS_TLAST => S3_AXIS_TLAST,
    S3_AXIS_TDATA => S3_AXIS_TDATA,
    S3_AXIS_TVALID => S3_AXIS_TVALID,
    S3_AXIS_TREADY => S3_AXIS_TREADY
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file microblaze_0.vhd when simulating
-- the core, microblaze_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.



