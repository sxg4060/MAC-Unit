library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CLA_adder_TB is
end;

architecture bench of CLA_adder_TB is
constant X : integer := 16;
  component CLA_adder
    generic (X : integer := 16);
    port(
        a    : in std_logic_vector((2*X)-1 downto 0);
        b    : in std_logic_vector((2*X)-1 downto 0);
        Cin  : in std_logic;
        S    : out std_logic_vector((2*X)-1 downto 0);
        Cout : out std_logic
    );
  end component;

  signal a: std_logic_vector((2*X)-1 downto 0);
  signal b: std_logic_vector((2*X)-1 downto 0);
  signal Cin: std_logic;
  signal S: std_logic_vector((2*X)-1 downto 0);
  signal Cout: std_logic ;

begin

  -- Insert values for generic parameters !!
  uut: CLA_adder generic map ( X    =>  16)
                    port map ( a    => a,
                               b    => b,
                               Cin  => Cin,
                               S    => S,
                               Cout => Cout );

  stimulus: process
  begin
  
    -- Put initialisation code here
    a <= X"00000003";
    b <= X"00000001";
    Cin <= '0';
    -- Put test bench stimulus code here

    wait;
  end process;


end;

