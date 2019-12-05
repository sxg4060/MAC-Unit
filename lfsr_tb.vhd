library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity lfsr_tb is
end;

architecture bench of lfsr_tb is
constant X : integer := 16;
  component lfsr
      generic (X: integer := 16);
      Port ( CLK : in  STD_LOGIC;
             RST : in  STD_LOGIC;
             EN  : in  STD_LOGIC;
             BP1 : out STD_LOGIC_VECTOR (X-1 downto 0);
  	         BP2 : out STD_LOGIC_VECTOR (X-1 downto 0)	
  	);
  end component;

  signal CLK: STD_LOGIC;
  signal RST: STD_LOGIC;
  signal EN: STD_LOGIC;
  signal BP1: STD_LOGIC_VECTOR (X-1 downto 0);
  signal BP2: STD_LOGIC_VECTOR (X-1 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: lfsr generic map ( X   =>  16)
               port map ( CLK => CLK,
                          RST => RST,
                          EN  => EN,
                          BP1 => BP1,
                          BP2 => BP2 );

  stimulus: process
  begin
  
    -- Put initialisation code here
    EN <= '0';
    RST <= '1';
    wait for clock_period;
    RST <= '0';
    
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



