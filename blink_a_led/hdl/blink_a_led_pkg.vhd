----------------------------------------------------------------------------------
-- Company : TSE_TSO CORP
-- Engineer: Aurélien Tseguiancap
-- Create Date: 25.09.2019 01:49:38
-- Design Name: 
-- Module Name: blink_a_led_pkg 
-- Project Name: 
-- Target Devices: ARTIX-7 ::
-- Tool Versions: 
-- Description: 
-- Dependencies: 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE blink_a_led_pkg IS       
      CONSTANT OFF    : STD_LOGIC:='0';
      CONSTANT ACTIVE : STD_LOGIC:='0';
 
      COMPONENT clock_gen_rtl IS
      GENERIC
            (
             MAX : POSITIVE := 50000000 -- frequency divider
            );
      PORT  (
             clk_i : IN  STD_LOGIC;  -- (i)
             clk_o : OUT STD_LOGIC   -- (o)
            );         
      END COMPONENT clock_gen_rtl;

END PACKAGE blink_a_led_pkg;
