----------------------------------------------------------------------------------
-- Author: Sahil Gogna
-- Date: 11-23-19
-- Description: MISR
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MISR is
    generic (X: integer := 16);
    Port ( clk       : in  STD_LOGIC;
           rst       : in  STD_LOGIC;
           enable    : in  STD_LOGIC;
           mac_out   : in  STD_LOGIC_VECTOR ((2*X)-1 downto 0);
           signature : out  STD_LOGIC_VECTOR ((2*X)-1 downto 0)
          );
end MISR;

architecture Behavioral of MISR is
signal misr_signal : std_logic_vector ((2*X)-1 downto 0);

begin
process(clk, rst) is begin
      if rst = '1' then
        misr_signal <= (others => '0');
      elsif (rising_edge(clk)) then         
        if (enable = '1' and RST = '0') then
            misr_signal(0) <= misr_signal((2*X)-1) xor misr_signal((2*X)-3) xor misr_signal((2*X)-4) xor mac_out((2*X)-1);
            misr_loop: for i in 0 to ((2*X)-2) loop
                misr_signal(i+1) <= misr_signal(i) xor mac_out(((2*X)-1)-(i+1));				
				    end loop;  
        else
            hold_loop: for k in 0 to ((2*X)-1) loop
					     misr_signal(k) <= misr_signal(k);
				    end loop; 
        end if;
    end if;
end process;

enable_proc : process(clk) is begin
    if (rising_edge(clk)) then
        signature <= misr_signal(0) & misr_signal(1) & misr_signal(2) & misr_signal(3) & misr_signal(4) & misr_signal(5) & misr_signal(6) & misr_signal(7) &
                     misr_signal(8) & misr_signal(9) & misr_signal(10) & misr_signal(11) & misr_signal(12) & misr_signal(13) & misr_signal(14) & misr_signal(15) &
                     misr_signal(16) & misr_signal(17) & misr_signal(18) & misr_signal(19) & misr_signal(20) & misr_signal(21) & misr_signal(22) & misr_signal(23) & 
                     misr_signal(24) & misr_signal(25) & misr_signal(26) & misr_signal(27) & misr_signal(28) & misr_signal(29) & misr_signal(30) & misr_signal(31); 
    end if;
end process enable_proc;

end Behavioral;

