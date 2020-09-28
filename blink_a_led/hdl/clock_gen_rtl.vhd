----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Create Date: 08.05.2019 01:50:29
-- Design Name: 
-- Module Name:  clock_gen_rtl
-- Project Name: blink_a_led_rtl 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Dependencies: 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY clock_gen_rtl is
GENERIC
    (
      MAX : POSITIVE := 50000000 -- frequency divider
    );
PORT 
    (   
      clk_i : IN  STD_LOGIC;   -- system clock (i)
      clk_o : OUT STD_LOGIC    -- output clock (o)
    );
END clock_gen_rtl;

ARCHITECTURE rtl OF clock_gen_rtl IS
signal tmp_clk : std_logic:='0';
signal i       : positive RANGE 1 TO MAX:=1;

BEGIN 
 
-- check if Max is a non permitted value
ASSERT (MAX>0) REPORT "clock_gen::Generic MAX must be greater than zero value"SEVERITY FAILURE;
    
freq_division_pro:PROCESS(clk_i)
begin
    if ( clk_i'event and clk_i='1') then 
        if (i= MAX) then
            tmp_clk <= not (tmp_clk);
            i<= 1;
        else
            i <= i+1;
        end if;
    end if;
END PROCESS freq_division_pro;   

clk_o <= tmp_clk;
END rtl;
