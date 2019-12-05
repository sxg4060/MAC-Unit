---------------------------------------
-- Author: Sahil Gogna
-- Date: 11-23-19
-- Description: Carry Lookahead Adder
---------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity CLA_adder is
  generic (X : integer := 16);
  port(
      a    : in std_logic_vector((2*X)-1 downto 0);
      b    : in std_logic_vector((2*X)-1 downto 0);
      Cin  : in std_logic;
      S    : out std_logic_vector((2*X)-1 downto 0);
      Cout : out std_logic
  );
end CLA_adder;

architecture behavioral of CLA_adder is
  
signal tempSum : std_logic_vector((2*X)-1 downto 0);
signal Cgen    : std_logic_vector((2*X)-1 downto 0);
signal Cprop   : std_logic_vector((2*X)-1 downto 0);
signal tempCin : std_logic_vector((2*X)-1 downto 1);

begin
  tempSum <= a xor b;
  Cgen <= a and b;
  Cprop <= a or b;
  process (Cgen, Cprop, tempCin)
  begin
    tempCin(1) <= Cgen(0) or (Cprop(0) and Cin);
    inst: for j in 1 to ((2*X)-2) loop
      tempCin(j+1) <= Cgen(j) or (Cprop(j) and tempCin(j));
      end loop;
  Cout <= Cgen((2*X)-1) or (Cprop((2*X)-1) and tempCin((2*X)-1));
  end process;
  
  S(0) <= tempSum(0) xor Cin;
  S((2*X)-1 downto 1) <= tempSum((2*X)-1 downto 1) xor tempCin((2*X)-1 downto 1);
end behavioral;


