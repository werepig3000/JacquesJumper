library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity inGameBackgroundROM is
  port(
  row : in unsigned(9 downto 0); 
  rgb : out std_logic_vector(5 downto 0)
      );
	  
end inGameBackgroundROM;


architecture synth of inGameBackgroundROM is
begin

rgb <= "000001" when (row >= 0 and row < 10d"120") else
	   "000010" when (row >= 120 and row < 10d"240") else
	   "000011" when (row >= 240 and row < 10d"360") else
	   "000111";

end;