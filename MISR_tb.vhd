library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MISR_tb is
end;

architecture bench of MISR_tb is
constant X : integer := 16;
  component MISR
      generic (X: integer := 16);
      Port ( clk       : in  STD_LOGIC;
             rst       : in  STD_LOGIC;
             enable    : in  STD_LOGIC;
             mac_out   : in  STD_LOGIC_VECTOR ((2*X)-1 downto 0);
             signature : out  STD_LOGIC_VECTOR ((2*X)-1 downto 0)
            );
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal enable: STD_LOGIC;
  signal mac_out: STD_LOGIC_VECTOR ((2*X)-1 downto 0);
  signal signature: STD_LOGIC_VECTOR ((2*X)-1 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: MISR generic map ( X         =>  16)
               port map ( clk       => clk,
                          rst       => rst,
                          enable    => enable,
                          mac_out   => mac_out,
                          signature => signature );

  stimulus: process
  begin
  
    -- Put initialisation code here
    enable <= '1';
    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    
    wait for 5 ns;
    mac_out <= X"00000001";
    wait for clock_period;
    mac_out <= X"00000002";
    wait for clock_period;
    mac_out <= X"00000002";
    wait for clock_period;
    mac_out <= X"00000003";
    -- Put test bench stimulus code here

    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

