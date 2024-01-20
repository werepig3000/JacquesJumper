library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--ROM for drawing a 48x4 pixel platform on the screen, all physics should be applied to the upper left hand pixel.

entity platform1_ROM is

  port(

  clk : in std_logic;

  x_address: in unsigned(5 downto 0); -- 0-64, will require an “x_diff” input when mapped

  y_address: in unsigned(1 downto 0); -- 0-32 will require a “y_diff” input when mapped

  rgb : out std_logic_vector(5 downto 0)

      );

end platform1_ROM;


architecture synth of platform1_ROM is

signal xy_address : std_logic_vector(7 downto 0); -- combined 8-bit address (2 y bits, 6 x bits)- easiest for program generation.
signal temp : std_logic_vector (0 downto 0);

begin

   process (clk) begin

if rising_edge(clk) then

case xy_address is

	when "00000000" => temp <= "1";
	when "00000001" => temp <= "1";
	when "00000010" => temp <= "1";
	when "00000011" => temp <= "1";
	when "00000100" => temp <= "1";
	when "00000101" => temp <= "1";
	when "00000110" => temp <= "1";
	when "00000111" => temp <= "1";
	when "00001000" => temp <= "1";
	when "00001001" => temp <= "1";
	when "00001010" => temp <= "1";
	when "00001011" => temp <= "1";
	when "00001100" => temp <= "1";
	when "00001101" => temp <= "1";
	when "00001110" => temp <= "1";
	when "00001111" => temp <= "1";
	when "00010000" => temp <= "1";
	when "00010001" => temp <= "1";
	when "00010010" => temp <= "1";
	when "00010011" => temp <= "1";
	when "00010100" => temp <= "1";
	when "00010101" => temp <= "1";
	when "00010110" => temp <= "1";
	when "00010111" => temp <= "1";
	when "00011000" => temp <= "1";
	when "00011001" => temp <= "1";
	when "00011010" => temp <= "1";
	when "00011011" => temp <= "1";
	when "00011100" => temp <= "1";
	when "00011101" => temp <= "1";
	when "00011110" => temp <= "1";
	when "00011111" => temp <= "1";
	when "00100000" => temp <= "1";
	when "00100001" => temp <= "1";
	when "00100010" => temp <= "1";
	when "00100011" => temp <= "1";
	when "00100100" => temp <= "1";
	when "00100101" => temp <= "1";
	when "00100110" => temp <= "1";
	when "00100111" => temp <= "1";
	when "00101000" => temp <= "1";
	when "00101001" => temp <= "1";
	when "00101010" => temp <= "1";
	when "00101011" => temp <= "1";
	when "00101100" => temp <= "1";
	when "00101101" => temp <= "1";
	when "00101110" => temp <= "1";
	when "00101111" => temp <= "1";
	when "00110000" => temp <= "1";
	when "00110001" => temp <= "1";
	when "01000000" => temp <= "1";
	when "01000001" => temp <= "1";
	when "01000110" => temp <= "1";
	when "01000111" => temp <= "1";
	when "01001100" => temp <= "1";
	when "01001101" => temp <= "1";
	when "01010000" => temp <= "1";
	when "01010001" => temp <= "1";
	when "01100000" => temp <= "1";
	when "01100001" => temp <= "1";
	when "01100100" => temp <= "1";
	when "01100101" => temp <= "1";
	when "01101010" => temp <= "1";
	when "01101011" => temp <= "1";
	when "01110000" => temp <= "1";
	when "01110001" => temp <= "1";
	when "10000000" => temp <= "1";
	when "10000111" => temp <= "1";
	when "10001000" => temp <= "1";
	when "10001011" => temp <= "1";
	when "10001100" => temp <= "1";
	when "10010001" => temp <= "1";
	when "10010010" => temp <= "1";
	when "10011111" => temp <= "1";
	when "10100000" => temp <= "1";
	when "10100101" => temp <= "1";
	when "10100110" => temp <= "1";
	when "10101001" => temp <= "1";
	when "10101010" => temp <= "1";
	when "10110001" => temp <= "1";
	when "11000000" => temp <= "1";
	when "11000001" => temp <= "1";
	when "11000010" => temp <= "1";
	when "11000011" => temp <= "1";
	when "11000100" => temp <= "1";
	when "11000101" => temp <= "1";
	when "11000110" => temp <= "1";
	when "11000111" => temp <= "1";
	when "11001000" => temp <= "1";
	when "11001001" => temp <= "1";
	when "11001010" => temp <= "1";
	when "11001011" => temp <= "1";
	when "11001100" => temp <= "1";
	when "11001101" => temp <= "1";
	when "11001110" => temp <= "1";
	when "11001111" => temp <= "1";
	when "11010000" => temp <= "1";
	when "11010001" => temp <= "1";
	when "11010010" => temp <= "1";
	when "11010011" => temp <= "1";
	when "11010100" => temp <= "1";
	when "11010101" => temp <= "1";
	when "11010110" => temp <= "1";
	when "11010111" => temp <= "1";
	when "11011000" => temp <= "1";
	when "11011001" => temp <= "1";
	when "11011010" => temp <= "1";
	when "11011011" => temp <= "1";
	when "11011100" => temp <= "1";
	when "11011101" => temp <= "1";
	when "11011110" => temp <= "1";
	when "11011111" => temp <= "1";
	when "11100000" => temp <= "1";
	when "11100001" => temp <= "1";
	when "11100010" => temp <= "1";
	when "11100011" => temp <= "1";
	when "11100100" => temp <= "1";
	when "11100101" => temp <= "1";
	when "11100110" => temp <= "1";
	when "11100111" => temp <= "1";
	when "11101000" => temp <= "1";
	when "11101001" => temp <= "1";
	when "11101010" => temp <= "1";
	when "11101011" => temp <= "1";
	when "11101100" => temp <= "1";
	when "11101101" => temp <= "1";
	when "11101110" => temp <= "1";
	when "11101111" => temp <= "1";
	when "11110000" => temp <= "1";
	when "11110001" => temp <= "1";
	when others => temp <= "0";

end case;

end if;

   end process;

   xy_address <= std_logic_vector(y_address) & std_logic_vector(x_address);
   rgb <= "111111" when temp = "1" else
		  "110011";

end;