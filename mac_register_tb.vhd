library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mac_register_tb is
end;

architecture bench of mac_register_tb is
constant X : integer := 16;
  component mac_register
  	generic (X : integer := 16);
  	port (
  	    signal D : in std_logic_vector (((2*X)-1) downto 0);
  	    signal CLK : in std_logic;	
  	    signal RST : in std_logic;
  	    signal Q : out std_logic_vector (((2*X)-1) downto 0)
         );
  end component;

  signal D: std_logic_vector (((2*X)-1) downto 0);
  signal CLK: std_logic;
  signal RST: std_logic;
  signal Q: std_logic_vector (((2*X)-1) downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: mac_register generic map ( X      =>  16)
                       port map ( D      => D,
                                  CLK    => CLK,
                                  RST    => RST,
                                  Q      => Q );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST <= '1';
    wait for clock_period;
    RST <= '0';
    wait for clock_period/2;
    

    -- Put test bench stimulus code here

    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

