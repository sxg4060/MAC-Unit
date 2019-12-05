--------------------------------------------
-- File: FullAdder.vhd
--
-- Entity: Full Adder
-- Architecture: DATAFLOW
-- Author: Sahil Gogna
-- Created: 2-22-18
-- Modified: 2-22-18
-- VHDL'93
-- Description: The following is the entity and 
--				architectural description of a
--				Full Adder
--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
	port (A,B : in std_logic;
			Cin : in std_logic;
			Sum,Cout : out std_logic 
			);
end FullAdder;

architecture Dataflow of FullAdder is
begin
	Sum <= A xor B xor Cin;
	Cout <= (A and B) or (B and Cin) or (A and Cin);
	
end Dataflow;



