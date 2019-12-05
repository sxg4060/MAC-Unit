------------------------------------------------
-- File: mac_register.vhd
--
-- Entity: mac_register
-- Architecture: STRUCTURAL
-- Author: Sahil Gogna
-- Created: 11-14-19
-- Modified: 11-14-19
-- VHDL'93
-- Description: The following is the entity and 
--		architectural description of a
--		MAC Register
-----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mac_register is
	generic (X : integer := 16);
	port (
	    signal D : in std_logic_vector (((2*X)-1) downto 0);
	    signal CLK : in std_logic;	
	    signal RST : in std_logic; -- Asynchronous
	    signal Q : out std_logic_vector (((2*X)-1) downto 0)
       );
end entity;

architecture structural of mac_register is

BEGIN
    process(CLK, RST)
    begin
       if (RST = '1') then
          Q <= (others => '0');
	     elsif (rising_edge(CLK) and RST = '0') then
	         Q <= D;
	end if;
    end process;
end architecture;








