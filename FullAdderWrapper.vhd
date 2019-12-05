--------------------------------------------
-- File: FullAdderWrapper.vhd
--
-- Entity: Full Adder Wrapper
-- Architecture: STRUCTURAL
-- Author: Sahil Gogna
-- Created: 2-22-18
-- Modified: 2-22-18
-- VHDL'93
-- Description: The following is the entity and 
--		architectural description of a
--		Full Adder Wrapper
--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdderWrapper is
	generic (N : integer := 16);
	port (A,B : in std_logic_vector (N-1 downto 0);
			Cin : in std_logic;
			Sum : out std_logic_vector (N-1 downto 0);
			Cout : out std_logic
			);
end FullAdderWrapper;

architecture Behavioral of FullAdderWrapper is
signal tempCout : std_logic_vector(N-1 downto 0);
begin

	FA0 : entity work.FullAdder
		port map (A=>A(0),B=>B(0),Cin=>Cin,Cout=>tempCout(0),Sum=>Sum(0));
	-- Rest of the full adders
	for_proc2 : for i in 1 to N-1 generate 
		FA : entity work.FullAdder
			port map (A=>A(i),B=>B(i),Cin=>tempCout(i-1),Cout=>tempCout(i),Sum=>Sum(i));
	end generate for_proc2;
	Cout <= tempCout(N-1);
end Behavioral;




