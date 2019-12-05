library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity BIST_tb is
end;

architecture bench of BIST_tb is
constant X : integer := 16;
  component BIST
      generic (X: integer := 16);
      Port ( 
  			     signal B          : in std_logic_vector(X-1 downto 0);
  			     signal C          : in std_logic_vector(X-1 downto 0);
  			     signal Cin        : in std_logic:= '0';
  			     signal CLK        : in std_logic;
  			     signal RST        : in std_logic;
  			     signal test_mode  : in std_logic;
  			     signal signature  : out std_logic_vector ((2*X)-1 downto 0);
  			     signal mac_output : out std_logic_vector ((2*X)-1 downto 0) 
            );
  end component;

  signal B: std_logic_vector(X-1 downto 0);
  signal C: std_logic_vector(X-1 downto 0);
  signal Cin: std_logic:= '0';
  signal CLK: std_logic:= '0';
  signal RST: std_logic:= '0';
  signal test_mode: std_logic;
  signal signature: std_logic_vector ((2*X)-1 downto 0);
  signal mac_output: std_logic_vector ((2*X)-1 downto 0) ;

  constant clock_period: time := 50 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: BIST generic map ( X          =>  16)
               port map ( 
                          B          => B,
                          C          => C,
                          Cin        => Cin,
                          CLK        => CLK,
                          RST        => RST,
                          test_mode  => test_mode,
                          signature  => signature,
                          mac_output => mac_output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    B <= X"0000";
    C <= X"0000";
    test_mode <= '0';
    RST <= '1';
    wait for clock_period;
    RST <= '0';
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





