library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--ROM for drawing a 48x4 pixel platform on the screen, all physics should be applied to the upper left hand pixel.

entity BricksROM is

  port(

  clk : in std_logic;

  x_address: in unsigned(3 downto 0); -- 0-16, will require an “x_diff” input when mapped

  y_address: in unsigned(3 downto 0); -- 0-16 will require a “y_diff” input when mapped

  rgb : out std_logic_vector(5 downto 0)

      );

end BricksROM;


architecture synth of BricksROM is

signal xy_address : std_logic_vector(7 downto 0); -- combined 8-bit address (2 y bits, 6 x bits)- easiest for program generation.
signal indicator : std_logic_vector(1 downto 0); -- to reduce file/bit size (optimization trial)

begin

   process (clk) begin

if rising_edge(clk) then

case xy_address is

	when "00000000" => indicator <= "01";
	when "00000001" => indicator <= "10";
	when "00000010" => indicator <= "10";
	when "00000011" => indicator <= "10";
	when "00000100" => indicator <= "10";
	when "00000101" => indicator <= "10";
	when "00001111" => indicator <= "00";
	when "00010000" => indicator <= "10";
	when "00011111" => indicator <= "00";
	when "00100000" => indicator <= "10";
	when "00101111" => indicator <= "00";
	when "00111111" => indicator <= "00";
	when "01001111" => indicator <= "00";
	when "01011111" => indicator <= "00";
	when "01101111" => indicator <= "00";
	when "01110000" => indicator <= "00";
	when "01110001" => indicator <= "00";
	when "01110010" => indicator <= "00";
	when "01110011" => indicator <= "00";
	when "01110100" => indicator <= "00";
	when "01110101" => indicator <= "00";
	when "01110110" => indicator <= "00";
	when "01110111" => indicator <= "00";
	when "01111000" => indicator <= "00";
	when "01111001" => indicator <= "00";
	when "01111010" => indicator <= "00";
	when "01111011" => indicator <= "00";
	when "01111100" => indicator <= "00";
	when "01111101" => indicator <= "00";
	when "01111110" => indicator <= "00";
	when "01111111" => indicator <= "00";
	when "10001000" => indicator <= "00";
	when "10001001" => indicator <= "01";
	when "10001010" => indicator <= "10";
	when "10001011" => indicator <= "10";
	when "10001100" => indicator <= "10";
	when "10001101" => indicator <= "10";
	when "10001110" => indicator <= "10";
	when "10011000" => indicator <= "00";
	when "10011001" => indicator <= "10";
	when "10101000" => indicator <= "00";
	when "10101001" => indicator <= "10";
	when "10111000" => indicator <= "00";
	when "11001000" => indicator <= "00";
	when "11011000" => indicator <= "00";
	when "11101000" => indicator <= "00";
	when "11110000" => indicator <= "00";
	when "11110001" => indicator <= "00";
	when "11110010" => indicator <= "00";
	when "11110011" => indicator <= "00";
	when "11110100" => indicator <= "00";
	when "11110101" => indicator <= "00";
	when "11110110" => indicator <= "00";
	when "11110111" => indicator <= "00";
	when "11111000" => indicator <= "00";
	when "11111001" => indicator <= "00";
	when "11111010" => indicator <= "00";
	when "11111011" => indicator <= "00";
	when "11111100" => indicator <= "00";
	when "11111101" => indicator <= "00";
	when "11111110" => indicator <= "00";
	when "11111111" => indicator <= "00";
	when others => indicator <= "11";
end case;

end if;

   end process;

   xy_address <= std_logic_vector(y_address) & std_logic_vector(x_address);
   
   rgb <= "000000" when indicator = "00" else
		  "111111" when indicator = "01" else
		  "101010" when indicator = "10" else
		  "010101";

end;