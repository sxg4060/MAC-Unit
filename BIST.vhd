
----------------------------------------------------------------------------------
-- Author: Sahil Gogna
-- Date: 11-23-19
-- Description: BIST
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BIST is
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
end BIST;

architecture behavioral of BIST is
signal bp1    : std_logic_vector(X-1 downto 0)      := (others => '0');
signal bp2    : std_logic_vector(X-1 downto 0)      := (others => '0');
signal lfsr_B : std_logic_vector(X-1 downto 0)      := (others => '0');
signal lfsr_C : std_logic_vector(X-1 downto 0)      := (others => '0');
signal result : std_logic_vector((2*X)-1 downto 0)  := (others => '0');
signal sig    : std_logic_vector ((2*X)-1 downto 0) := (others => '0');
begin

bp1 <= lfsr_b when test_mode = '1' else
       B when test_mode = '0' else
       (others => '0');
bp2 <= lfsr_c when test_mode = '1' else
       C when test_mode = '0' else
       (others => '0');

signature <= sig when test_mode = '1' else
             (others => '0');
             
    clk_proc : process(CLK, RST) is
    begin
        if (RST = '1') then
            mac_output <= (others => '0');
        else
            mac_output <= result;  
        end if;
    end process clk_proc;
   
    -- LFSR
    test_input : entity work.lfsr
        generic map(X=>16)
        port map(RST=>RST,CLK=>CLK,EN=>test_mode,BP1=>lfsr_b,BP2=>lfsr_c);
    
    -- MAC
    mac_unit : entity work.mac_wrapper
        generic map(X=>16)
        port map(B=>bp1,C=>bp2,Cin=>Cin,CLK=>CLK,RST=>RST,NewA=>result);
    
    -- MISR
    test_output : entity work.MISR
        generic map(X=>16)
        port map(CLK=>CLK,RST=>RST,enable=>test_mode,mac_out=>result,signature=>sig);

end behavioral;

