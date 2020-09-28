----------------------------------------------------------------------------------
-- Company : TSE_TSO CORP
-- Engineer: Aurélien Tseguiancap
-- Create Date: 25.09.2019 01:49:38
-- Design Name: 
-- Module Name: blink_a_led - Behavioral
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
LIBRARY WORK;
USE WORK.blink_a_led_pkg.ALL;

ENTITY blink_a_led_rtl IS
GENERIC (
         MAX : POSITIVE:= 50000000  -- to configure the frequency 
        );                          -- at which our led shoud blink
PORT ( 
      clk_sys : IN  STD_LOGIC;
      rst_n   : IN  STD_LOGIC;
      Led     : OUT STD_LOGIC
     );
END blink_a_led_rtl;

ARCHITECTURE rtl OF blink_a_led_rtl IS

signal clk_1H   :std_logic;
signal led_on  :std_logic;
 
BEGIN

clock_gen_inst0: clock_gen_rtl GENERIC MAP 
                               ( MAX => MAX)
                               PORT MAP
                               (
                               clk_i => clk_sys,  -- 100 MHz clock
                               clk_o => clk_1H    -- 001 Hz  clock
                               );


blink_pro: PROCESS(clk_1H)
begin  
      if (clk_1H'event and clk_1H ='1') then 
         if (rst_n = ACTIVE) then
            led_on <= OFF;
         else
            led_on <= not(led_on);
         end if;
      end if;           
END PROCESS blink_pro;


Led <= led_on; -- final assignent 

END rtl; --EoF--

