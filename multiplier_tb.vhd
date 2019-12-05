library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity multiplier_tb is
end;

architecture bench of multiplier_tb is
constant X : integer := 16;
  component multiplier
  	generic (X : integer := 16);
  	port (
  			signal A : in std_logic_vector(X-1 downto 0);
  			signal B : in std_logic_vector(X-1 downto 0);
  			signal P : out std_logic_vector(((2*X)-1) downto 0)
  		  );
  end component;

  signal A: std_logic_vector(X-1 downto 0);
  signal B: std_logic_vector(X-1 downto 0);
  signal P: std_logic_vector(((2*X)-1) downto 0) ;

begin

  -- Insert values for generic parameters !!
  uut: multiplier generic map ( X      =>  16)
                     port map ( A      => A,
                                B      => B,
                                P      => P );

  stimulus: process
  begin
  
    -- Put initialisation code here
    A <= X"0001";
    B <= X"0002";

    -- Put test bench stimulus code here

    wait;
  end process;


end;

