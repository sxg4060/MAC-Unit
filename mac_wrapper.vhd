----------------------------------------------------------------------------------
-- Author: Sahil Gogna
-- Date Created: 11-16-19
-- Description: MAC Wrapper
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mac_wrapper is
generic (X : integer := 16);
	port (
			signal B : in std_logic_vector(X-1 downto 0);
			signal C : in std_logic_vector(X-1 downto 0);
			signal Cin : in std_logic:= '0';
			signal CLK : in std_logic;
			signal RST : in std_logic;
			signal NewA : out std_logic_vector ((2*X)-1 downto 0)
		  );
end entity;

architecture behavioral of mac_wrapper is
signal tempCout : std_logic := '0';
signal Product : std_logic_vector(((2*X)-1) downto 0);
signal tempP: std_logic_vector(((2*X)-1) downto 0);
signal tempQ : std_logic_vector(((2*X)-1) downto 0);
signal tempA : std_logic_vector(((2*X)-1) downto 0);
signal bool: boolean := true;
begin	 
  
  rst_proc : process(CLK, RST) is
  begin
      if RST = '1' then
          NewA <= (others => '0');
      else
          NewA <= tempA;
      end if;
  end process rst_proc;
  
  -- MAC Register
		MR : entity work.mac_register
		  generic map (X => 16)
			port map (D=>tempA,CLK=>CLK, RST=>RST, Q=>tempP);
			  
	-- MAC Multiplier
	  mult_proc : entity work.multiplier
	     generic map (X => 16)
	     port map (A=>B,B=>C,P=>Product);
	 
	-- Kogge Stone Adder
	   kogge : entity work.CLA_adder
	     generic map (X => 16)
	     port map (a=>tempP,b=>Product,Cin=>Cin,Cout=>tempCout,S=>tempA);

end behavioral;

