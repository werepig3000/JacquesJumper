library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity crouch3ROM is

  port(

  clk : in std_logic;
  x_address: in unsigned(4 downto 0); 
  y_address: in unsigned(5 downto 0);
  rgb : out std_logic_vector(5 downto 0)

      );

end crouch3ROM;


architecture synth of crouch3ROM is

signal xy_address : std_logic_vector(10 downto 0); 


begin

   process (clk) begin

if rising_edge(clk) then

case xy_address is


when "00111101011" => rgb <= "101110";
when "00111101100" => rgb <= "101110";
when "00111101101" => rgb <= "101110";
when "00111101110" => rgb <= "101110";
when "00111101111" => rgb <= "111010";
when "01000001010" => rgb <= "011001";
when "01000001011" => rgb <= "011001";
when "01000001100" => rgb <= "101110";
when "01000001101" => rgb <= "101110";
when "01000001110" => rgb <= "101001";
when "01000001111" => rgb <= "100101";
when "01000101010" => rgb <= "010101";
when "01000101011" => rgb <= "011001";
when "01000101100" => rgb <= "101110";
when "01000101101" => rgb <= "101101";
when "01000101110" => rgb <= "011001";
when "01000101111" => rgb <= "010100";
when "01001001010" => rgb <= "011001";
when "01001001011" => rgb <= "011001";
when "01001001100" => rgb <= "101001";
when "01001001101" => rgb <= "101101";
when "01001001110" => rgb <= "011001";
when "01001001111" => rgb <= "011001";
when "01001101010" => rgb <= "011001";
when "01001101011" => rgb <= "011001";
when "01001101100" => rgb <= "011001";
when "01001101101" => rgb <= "011001";
when "01001101110" => rgb <= "011001";
when "01001101111" => rgb <= "011001";
when "01010001010" => rgb <= "101001";
when "01010001011" => rgb <= "101001";
when "01010001100" => rgb <= "101001";
when "01010001101" => rgb <= "010101";
when "01010001110" => rgb <= "010101";
when "01010001111" => rgb <= "010101";
when "01010101011" => rgb <= "101001";
when "01010101100" => rgb <= "011001";
when "01010101101" => rgb <= "010101";
when "01010101110" => rgb <= "010101";
when "01011001011" => rgb <= "101001";
when "01011001100" => rgb <= "011001";
when "01011001101" => rgb <= "010101";
when "01011001110" => rgb <= "010101";
when "01011001111" => rgb <= "101001";
when "01011101010" => rgb <= "101001";
when "01011101011" => rgb <= "101001";
when "01011101100" => rgb <= "011001";
when "01011101101" => rgb <= "010101";
when "01011101110" => rgb <= "010101";
when "01011101111" => rgb <= "101001";
when "01011110000" => rgb <= "101001";
when "01100001001" => rgb <= "011001";
when "01100001010" => rgb <= "010101";
when "01100001011" => rgb <= "011001";
when "01100001100" => rgb <= "101001";
when "01100001101" => rgb <= "010101";
when "01100001110" => rgb <= "010101";
when "01100001111" => rgb <= "011001";
when "01100010000" => rgb <= "011001";
when "01100010001" => rgb <= "011001";
when "01100010010" => rgb <= "011001";
when "01100010011" => rgb <= "010101";
when "01100100110" => rgb <= "100110";
when "01100100111" => rgb <= "010101";
when "01100101000" => rgb <= "011001";
when "01100101001" => rgb <= "011001";
when "01100101010" => rgb <= "011001";
when "01100101011" => rgb <= "011001";
when "01100101100" => rgb <= "011001";
when "01100101101" => rgb <= "011001";
when "01100101110" => rgb <= "011001";
when "01100101111" => rgb <= "011001";
when "01100110000" => rgb <= "011001";
when "01100110001" => rgb <= "011001";
when "01100110010" => rgb <= "011001";
when "01100110011" => rgb <= "010101";
when "01100110100" => rgb <= "010101";
when "01100110101" => rgb <= "100110";
when "01101000110" => rgb <= "010101";
when "01101000111" => rgb <= "010101";
when "01101001000" => rgb <= "010101";
when "01101001001" => rgb <= "011001";
when "01101001010" => rgb <= "011001";
when "01101001011" => rgb <= "011001";
when "01101001100" => rgb <= "011001";
when "01101001101" => rgb <= "011001";
when "01101001110" => rgb <= "011001";
when "01101001111" => rgb <= "011001";
when "01101010000" => rgb <= "011001";
when "01101010001" => rgb <= "011001";
when "01101010010" => rgb <= "011001";
when "01101010011" => rgb <= "010101";
when "01101010100" => rgb <= "010101";
when "01101010101" => rgb <= "010101";
when "01101010110" => rgb <= "100110";
when "01101100110" => rgb <= "010101";
when "01101100111" => rgb <= "010101";
when "01101101000" => rgb <= "010101";
when "01101101001" => rgb <= "011001";
when "01101101010" => rgb <= "011001";
when "01101101011" => rgb <= "011001";
when "01101101100" => rgb <= "011001";
when "01101101101" => rgb <= "011001";
when "01101101110" => rgb <= "011001";
when "01101101111" => rgb <= "011001";
when "01101110000" => rgb <= "011001";
when "01101110001" => rgb <= "011001";
when "01101110010" => rgb <= "011001";
when "01101110011" => rgb <= "010101";
when "01101110100" => rgb <= "010100";
when "01101110101" => rgb <= "010100";
when "01101110110" => rgb <= "010101";
when "01110000110" => rgb <= "010101";
when "01110000111" => rgb <= "010101";
when "01110001000" => rgb <= "010100";
when "01110001001" => rgb <= "011001";
when "01110001010" => rgb <= "011001";
when "01110001011" => rgb <= "011001";
when "01110001100" => rgb <= "011001";
when "01110001101" => rgb <= "010101";
when "01110001110" => rgb <= "011001";
when "01110001111" => rgb <= "011001";
when "01110010000" => rgb <= "011001";
when "01110010001" => rgb <= "011001";
when "01110010010" => rgb <= "010101";
when "01110010011" => rgb <= "010101";
when "01110010100" => rgb <= "010100";
when "01110010101" => rgb <= "010100";
when "01110010110" => rgb <= "010101";
when "01110100110" => rgb <= "010101";
when "01110100111" => rgb <= "010101";
when "01110101000" => rgb <= "010100";
when "01110101001" => rgb <= "010101";
when "01110101010" => rgb <= "010101";
when "01110101011" => rgb <= "010101";
when "01110101100" => rgb <= "010101";
when "01110101101" => rgb <= "010101";
when "01110101110" => rgb <= "010101";
when "01110101111" => rgb <= "010101";
when "01110110000" => rgb <= "010101";
when "01110110001" => rgb <= "010101";
when "01110110010" => rgb <= "010101";
when "01110110011" => rgb <= "010101";
when "01110110100" => rgb <= "010100";
when "01110110101" => rgb <= "010100";
when "01110110110" => rgb <= "010101";
when "01111000110" => rgb <= "010101";
when "01111000111" => rgb <= "000000";
when "01111001000" => rgb <= "000000";
when "01111001001" => rgb <= "010100";
when "01111001010" => rgb <= "010100";
when "01111001011" => rgb <= "011001";
when "01111001100" => rgb <= "011001";
when "01111001101" => rgb <= "011001";
when "01111001110" => rgb <= "011001";
when "01111001111" => rgb <= "011001";
when "01111010000" => rgb <= "010100";
when "01111010001" => rgb <= "010100";
when "01111010010" => rgb <= "010101";
when "01111010011" => rgb <= "010100";
when "01111010100" => rgb <= "010100";
when "01111010101" => rgb <= "010101";
when "01111010110" => rgb <= "010101";
when "01111100110" => rgb <= "010101";
when "01111100111" => rgb <= "000100";
when "01111101000" => rgb <= "000000";
when "01111101001" => rgb <= "010100";
when "01111101010" => rgb <= "010100";
when "01111101011" => rgb <= "011001";
when "01111101100" => rgb <= "011001";
when "01111101101" => rgb <= "011001";
when "01111101110" => rgb <= "011001";
when "01111101111" => rgb <= "011001";
when "01111110000" => rgb <= "011001";
when "01111110001" => rgb <= "010101";
when "01111110010" => rgb <= "010100";
when "01111110011" => rgb <= "010100";
when "01111110100" => rgb <= "000100";
when "01111110101" => rgb <= "010101";
when "01111110110" => rgb <= "010101";
when "10000000110" => rgb <= "010101";
when "10000000111" => rgb <= "010101";
when "10000001000" => rgb <= "010101";
when "10000001001" => rgb <= "000000";
when "10000001010" => rgb <= "000000";
when "10000001011" => rgb <= "000000";
when "10000001100" => rgb <= "010101";
when "10000001101" => rgb <= "011001";
when "10000001110" => rgb <= "011001";
when "10000001111" => rgb <= "010101";
when "10000010000" => rgb <= "000100";
when "10000010001" => rgb <= "000000";
when "10000010010" => rgb <= "000000";
when "10000010011" => rgb <= "010100";
when "10000010100" => rgb <= "000100";
when "10000010101" => rgb <= "010101";
when "10000010110" => rgb <= "100101";
when "10000100110" => rgb <= "100110";
when "10000100111" => rgb <= "010101";
when "10000101000" => rgb <= "010101";
when "10000101001" => rgb <= "000100";
when "10000101010" => rgb <= "000000";
when "10000101011" => rgb <= "000000";
when "10000101100" => rgb <= "000000";
when "10000101101" => rgb <= "000000";
when "10000101110" => rgb <= "000000";
when "10000101111" => rgb <= "000000";
when "10000110000" => rgb <= "000000";
when "10000110001" => rgb <= "000000";
when "10000110010" => rgb <= "000000";
when "10000110011" => rgb <= "010100";
when "10000110100" => rgb <= "010101";
when "10000110101" => rgb <= "010101";
when "10001000111" => rgb <= "010101";
when "10001001000" => rgb <= "010101";
when "10001001001" => rgb <= "000100";
when "10001001010" => rgb <= "000000";
when "10001001011" => rgb <= "000000";
when "10001001100" => rgb <= "000000";
when "10001001101" => rgb <= "000000";
when "10001001110" => rgb <= "000000";
when "10001001111" => rgb <= "000000";
when "10001010000" => rgb <= "000000";
when "10001010001" => rgb <= "000000";
when "10001010010" => rgb <= "000000";
when "10001010011" => rgb <= "010100";
when "10001010100" => rgb <= "010101";
when "10001010101" => rgb <= "010101";
when "10001101000" => rgb <= "010101";
when "10001101001" => rgb <= "010100";
when "10001101010" => rgb <= "010100";
when "10001101011" => rgb <= "010100";
when "10001101100" => rgb <= "010101";
when "10001101101" => rgb <= "000000";
when "10001101110" => rgb <= "000000";
when "10001101111" => rgb <= "000000";
when "10001110000" => rgb <= "000000";
when "10001110001" => rgb <= "000000";
when "10001110010" => rgb <= "010100";
when "10001110011" => rgb <= "010101";
when "10001110100" => rgb <= "010101";
when "10010001000" => rgb <= "100110";
when "10010001001" => rgb <= "010101";
when "10010001010" => rgb <= "101001";
when "10010001011" => rgb <= "010101";
when "10010010001" => rgb <= "011001";
when "10010010010" => rgb <= "011001";
when "10010010011" => rgb <= "010101";
when "10010010100" => rgb <= "100110";
when "10010101001" => rgb <= "101001";
when "10010101010" => rgb <= "010101";
when "10010110000" => rgb <= "101001";
when "10010110001" => rgb <= "101110";
when "10010110010" => rgb <= "011001";
when "10010110011" => rgb <= "010101";
when "10010110100" => rgb <= "100110";
when "10011001001" => rgb <= "101001";
when "10011001010" => rgb <= "101001";
when "10011010001" => rgb <= "101001";
when "10011010010" => rgb <= "010101";
when "10011010011" => rgb <= "010101";
when "10011101010" => rgb <= "100101";
when "10011101011" => rgb <= "010101";
when "10011110001" => rgb <= "010100";
when "10011110010" => rgb <= "010101";
when "10100001011" => rgb <= "100110";
when "10100001100" => rgb <= "010101";
when "10100010001" => rgb <= "010101";
when "10100101100" => rgb <= "010101";
when "10100110000" => rgb <= "010101";
when "10100110001" => rgb <= "100110";
when "10101001100" => rgb <= "011001";
when "10101001101" => rgb <= "010110";
when "10101010000" => rgb <= "010101";
when "10101101011" => rgb <= "011001";
when "10101101100" => rgb <= "011001";
when "10101110000" => rgb <= "011001";
when "10110001011" => rgb <= "011001";
when "10110001100" => rgb <= "011001";
when "10110001111" => rgb <= "011001";
when "10110010000" => rgb <= "011001";
when "10110101100" => rgb <= "011001";
when "10110101111" => rgb <= "011001";
when "10110110000" => rgb <= "011001";
when "10111001111" => rgb <= "011001";
when "10111010000" => rgb <= "011001";
when others => rgb <= "110011";



end case;

end if;

   end process;

   xy_address <= std_logic_vector(y_address) & std_logic_vector(x_address);
   
end;