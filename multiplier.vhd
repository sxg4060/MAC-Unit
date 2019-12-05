------------------------------------------------
-- File: Multiplier.vhd
--
-- Entity: Multiplier Wrapper
-- Architecture: STRUCTURAL
-- Author: Sahil Gogna
-- Created: 2-23-18
-- Modified: 11-14-19
-- VHDL'93
-- Description: The following is the entity and 
--		architectural description of a
--		Multiplier
-----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplier is
	generic (X : integer := 16);
	port (
			signal A : in std_logic_vector(X-1 downto 0);
			signal B : in std_logic_vector(X-1 downto 0);
			signal P : out std_logic_vector(((2*X)-1) downto 0)
		  );
end entity;

architecture structural of multiplier is
type row is array (X-1 downto 0) of std_logic_vector (((2*X)-2) downto 0); -- ROW is used for each Partial Product
type acc is array (X downto 0) of std_logic_vector(((2*X)-2) downto 0); -- ACC is used for each accumulator

signal PP : row := (others=> (others=>'0')); -- Each Partial Product
signal ACCUM : acc := (others=>(others=>'0')); -- Accumulator
signal CARRY : std_logic_vector((X-1) downto 0) := (others=>'0'); -- Carry

begin
	-- Create each combination for each product
	rows : for J in 0 to X-1 generate 
		cols : for K in 0 to X-1 generate 
			PP (J)(K+J) <= A(J) AND B(K);
		end generate cols;
	end generate rows;
-- Add the partial products via a generic Full Adder
ADD :  for partial in 0 to X-1 generate
		ADDER : entity work.FullAdderWrapper
		generic map (N=>(2*X)-1)
		port map(A => PP(partial),B => ACCUM(partial),Cin => '0',Sum => ACCUM(partial+1),Cout => CARRY(partial));
end generate ADD;

getProduct : for index in 0 to ((2*X)-2) generate
	P(index) <= ACCUM(X)(index);
end generate;
	P((2*X)-1) <= CARRY(X-1);
end architecture;








