library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--ROM for drawing a 48x4 pixel platform on the screen, all physics should be applied to the upper left hand pixel.

entity gradientROM is

  port(

  clk : in std_logic;
  x_address: in unsigned(2 downto 0); -- 0-8, will require an “x_diff” input when mapped
  y_address: in unsigned(4 downto 0); -- 0-32 will require a “y_diff” input when mapped
  layer : in std_logic_vector(1 downto 0);
  rgb : out std_logic_vector(5 downto 0)

      );

end gradientROM;


architecture synth of gradientROM is

signal xy_address : std_logic_vector(7 downto 0); -- combined 8-bit address (5 y bits, 3 x bits)- easiest for program generation.
signal temp : std_logic_vector(0 downto 0); -- to reduce file/bit size (optimization trial)

begin

   process (clk) begin

if rising_edge(clk) then

case xy_address is

		when "00000000" => temp <= "1";
		when "00000001" => temp <= "1";
		when "00000100" => temp <= "1";
		when "00000101" => temp <= "1";
		when "00001000" => temp <= "1";
		when "00001001" => temp <= "1";
		when "00001100" => temp <= "1";
		when "00001101" => temp <= "1";
		when "00100000" => temp <= "1";
		when "00100001" => temp <= "1";
		when "00100100" => temp <= "1";
		when "00100101" => temp <= "1";
		when "00101000" => temp <= "1";
		when "00101001" => temp <= "1";
		when "00101100" => temp <= "1";
		when "00101101" => temp <= "1";
		when "00110010" => temp <= "1";
		when "00110011" => temp <= "1";
		when "00111010" => temp <= "1";
		when "00111011" => temp <= "1";
		when "01000000" => temp <= "1";
		when "01000001" => temp <= "1";
		when "01000100" => temp <= "1";
		when "01000101" => temp <= "1";
		when "01001000" => temp <= "1";
		when "01001001" => temp <= "1";
		when "01001100" => temp <= "1";
		when "01001101" => temp <= "1";
		when "01010110" => temp <= "1";
		when "01010111" => temp <= "1";
		when "01011110" => temp <= "1";
		when "01011111" => temp <= "1";
		when "01100000" => temp <= "1";
		when "01100001" => temp <= "1";
		when "01100100" => temp <= "1";
		when "01100101" => temp <= "1";
		when "01101000" => temp <= "1";
		when "01101001" => temp <= "1";
		when "01101100" => temp <= "1";
		when "01101101" => temp <= "1";
		when "01110000" => temp <= "1";
		when "01110001" => temp <= "1";
		when "01110010" => temp <= "1";
		when "01110011" => temp <= "1";
		when "01110100" => temp <= "1";
		when "01110101" => temp <= "1";
		when "01110110" => temp <= "1";
		when "01110111" => temp <= "1";
		when "01111000" => temp <= "1";
		when "01111001" => temp <= "1";
		when "01111010" => temp <= "1";
		when "01111011" => temp <= "1";
		when "01111100" => temp <= "1";
		when "01111101" => temp <= "1";
		when "01111110" => temp <= "1";
		when "01111111" => temp <= "1";
		when "10000000" => temp <= "1";
		when "10000001" => temp <= "1";
		when "10000100" => temp <= "1";
		when "10000101" => temp <= "1";
		when "10001000" => temp <= "1";
		when "10001001" => temp <= "1";
		when "10001100" => temp <= "1";
		when "10001101" => temp <= "1";
		when others => temp <= "0";
end case;

end if;

   end process;

   xy_address <= std_logic_vector(y_address) & std_logic_vector(x_address);
   
   rgb <= "000111" when (layer = "00" and temp = "1") else
		  "000011" when (layer = "01" and temp = "1") else
		  "000010" when (layer = "10" and temp = "1") else
		  "110011";

end;