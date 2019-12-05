--------------------------------------------
-- File: mac_adder.vhd
--
-- Entity: MAC Adder Wrapper
-- Architecture: STRUCTURAL
-- Author: Sahil Gogna
-- Created: 11-14-19
-- Modified: 11-14-19
-- VHDL'93
-- Description: The following is the entity and 
--		architectural description of a
--		Full MAC Adder Wrapper
--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mac_adder_wrapper is
	generic (N : integer := 16);
	port (
	    A,B : in std_logic_vector (((2*N)-1) downto 0);
	    CLK : in std_logic;
	    CLR : in std_logic;
	    Cin : in std_logic;
 	    Sum : out std_logic_vector (((2*N)-1) downto 0);
 	    Cout: out std_logic_vector (((2*N)-1) downto 0)
	     );
end mac_adder_wrapper;

architecture Behavioral of mac_adder_wrapper is
signal tempCout : std_logic_vector(((2*N)-1) downto 0);
signal tempSum : std_logic_vector(((2*N)-1) downto 0);
signal tempA : std_logic_vector(((2*N)-1) downto 0);
begin

	-- First Full Adder
	FA0 : entity work.FullAdder
		port map (A=>tempA(0),B=>B(0),Cin=>Cin,Cout=>tempCout(0),Sum=>tempSum(0));

	-- Rest of the full adders
	for_proc2 : for i in 1 to ((2*N)-1) generate 
		FA : entity work.FullAdder
			port map (A=>tempA(i),B=>B(i),Cin=>tempCout(i-1),Cout=>tempCout(i),Sum=>tempSum(i));

	end generate for_proc2;	

	-- Write New Sum back to register
	for_proc3 : for j in 0 to (2*(N-1)) generate
		MR : entity work.mac_register
			port map (D=>tempSum(j),CLK=>CLK,CLR=>CLR,Q=>tempA(j));	
	end generate for_proc3;

	Cout <= "0000000000000000"; -- Carry-out can be omitted
end Behavioral;


