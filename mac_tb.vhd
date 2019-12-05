library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mac_wrapper_tb is
end;

architecture bench of mac_wrapper_tb is
constant X : integer := 16;
  component mac_wrapper
  generic (X : integer := 16);
  	port (
  			signal B : in std_logic_vector(X-1 downto 0);
  			signal C : in std_logic_vector(X-1 downto 0);
  			signal Cin : in std_logic := '0';
  			signal CLK : in std_logic;
  			signal RST : in std_logic;
  			signal NewA : out std_logic_vector ((2*X)-1 downto 0)
  		  );
  end component;
  
  constant clk_period : time := 50 ns;
  signal B: std_logic_vector(X-1 downto 0);
  signal C: std_logic_vector(X-1 downto 0);
  signal Cin: std_logic := '0';
  signal RST: std_logic := '0';
  signal CLK: std_logic := '0';
  signal NewA: std_logic_vector ((2*X)-1 downto 0) ;
  signal stop_the_clock: boolean;
begin

  -- Insert values for generic parameters !!
  uut: mac_wrapper generic map ( X      =>  16)
                      port map (                
                                 B      => B,
                                 
                                 C      => C,
                                 
                                 Cin    => Cin,
                                 
                                 CLK    => CLK,
                                
                                 RST    => RST,
                                 
                                 NewA   => NewA );

  stimulus: process
  begin
    -- Put initialisation code here
    
    B <= X"0002";
    C <= X"0002";
    RST <= '1';
    wait for clk_period/2;
    RST <= '0';
    wait for 6*(clk_period)/2;
    B <= X"0004";
    C <= X"0004";
    -- Put test bench stimulus code here

    wait;
  end process;

clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clk_period / 2;
      wait for clk_period;
    end loop;
    wait;
end process;
end;

