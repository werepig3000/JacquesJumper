--library IEEE;
--use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;


--ROM for drawing a 48x4 pixel platform on the screen, all physics should be applied to the upper left hand pixel.

--entity NineROM is

  --port(

  --clk : in std_logic;
  --x_address: in unsigned(3 downto 0); -- 0-8, will require an “x_diff” input when mapped
  --y_address: in unsigned(3 downto 0); -- 0-32 will require a “y_diff” input when mapped
  --rgb : out std_logic_vector(5 downto 0)

      --);

--end NineROM;


--architecture synth of NineROM is

--signal xy_address : std_logic_vector(7 downto 0); -- combined 8-bit address (5 y bits, 3 x bits)- easiest for program generation.
--signal temp : std_logic_vector(1 downto 0); -- to reduce file/bit size (optimization trial)

--begin

   --process (clk) begin

--if rising_edge(clk) then

--case xy_address is

			--when "00000110" => temp <= "00";

--when "00000111" => temp <= "00";

--when "00001000" => temp <= "00";

--when "00001001" => temp <= "00";

--when "00001010" => temp <= "00";

--when "00010101" => temp <= "00";

--when "00010110" => temp <= "00";

--when "00010111" => temp <= "01";

--when "00011000" => temp <= "01";

--when "00011001" => temp <= "01";

--when "00011010" => temp <= "00";

--when "00011011" => temp <= "00";

--when "00011100" => temp <= "00";

--when "00100011" => temp <= "00";

--when "00100100" => temp <= "00";

--when "00100101" => temp <= "01";

--when "00100110" => temp <= "01";

--when "00100111" => temp <= "01";

--when "00101000" => temp <= "01";

--when "00101001" => temp <= "01";

--when "00101010" => temp <= "01";

--when "00101011" => temp <= "01";

--when "00101100" => temp <= "00";

--when "00101101" => temp <= "00";

--when "00110010" => temp <= "00";

--when "00110011" => temp <= "00";

--when "00110100" => temp <= "01";

--when "00110101" => temp <= "01";

--when "00110110" => temp <= "00";

--when "00110111" => temp <= "00";

--when "00111000" => temp <= "00";

--when "00111001" => temp <= "00";

--when "00111010" => temp <= "01";

--when "00111011" => temp <= "01";

--when "00111100" => temp <= "01";

--when "00111101" => temp <= "00";

--when "01000001" => temp <= "00";

--when "01000010" => temp <= "00";

--when "01000011" => temp <= "01";

--when "01000100" => temp <= "01";

--when "01000101" => temp <= "00";

--when "01000110" => temp <= "00";

--when "01001001" => temp <= "00";

--when "01001010" => temp <= "00";

--when "01001011" => temp <= "01";

--when "01001100" => temp <= "01";

--when "01001101" => temp <= "01";

--when "01001110" => temp <= "00";

--when "01010001" => temp <= "00";

--when "01010010" => temp <= "01";

--when "01010011" => temp <= "01";

--when "01010100" => temp <= "01";

--when "01010101" => temp <= "00";

--when "01011010" => temp <= "00";

--when "01011011" => temp <= "01";

--when "01011100" => temp <= "01";

--when "01011101" => temp <= "01";

--when "01011110" => temp <= "00";

--when "01100001" => temp <= "00";

--when "01100010" => temp <= "01";

--when "01100011" => temp <= "01";

--when "01100100" => temp <= "01";

--when "01100101" => temp <= "00";

--when "01101010" => temp <= "00";

--when "01101011" => temp <= "01";

--when "01101100" => temp <= "01";

--when "01101101" => temp <= "01";

--when "01101110" => temp <= "00";

--when "01110001" => temp <= "00";

--when "01110010" => temp <= "00";

--when "01110011" => temp <= "01";

--when "01110100" => temp <= "01";

--when "01110101" => temp <= "00";

--when "01110110" => temp <= "00";

--when "01110111" => temp <= "00";

--when "01111000" => temp <= "00";

--when "01111001" => temp <= "00";

--when "01111010" => temp <= "00";

--when "01111011" => temp <= "01";

--when "01111100" => temp <= "01";

--when "01111101" => temp <= "01";

--when "01111110" => temp <= "00";

--when "10000010" => temp <= "00";

--when "10000011" => temp <= "00";

--when "10000100" => temp <= "01";

--when "10000101" => temp <= "01";

--when "10000110" => temp <= "01";

--when "10000111" => temp <= "01";

--when "10001000" => temp <= "01";

--when "10001001" => temp <= "01";

--when "10001010" => temp <= "01";

--when "10001011" => temp <= "01";

--when "10001100" => temp <= "01";

--when "10001101" => temp <= "01";

--when "10001110" => temp <= "00";

--when "10010011" => temp <= "00";

--when "10010100" => temp <= "00";

--when "10010101" => temp <= "00";

--when "10010110" => temp <= "00";

--when "10010111" => temp <= "00";

--when "10011000" => temp <= "00";

--when "10011001" => temp <= "00";

--when "10011010" => temp <= "00";

--when "10011011" => temp <= "01";

--when "10011100" => temp <= "01";

--when "10011101" => temp <= "01";

--when "10011110" => temp <= "00";

--when "10101010" => temp <= "00";

--when "10101011" => temp <= "01";

--when "10101100" => temp <= "01";

--when "10101101" => temp <= "01";

--when "10101110" => temp <= "00";

--when "10111010" => temp <= "00";

--when "10111011" => temp <= "01";

--when "10111100" => temp <= "01";

--when "10111101" => temp <= "01";

--when "10111110" => temp <= "00";

--when "11001010" => temp <= "00";

--when "11001011" => temp <= "01";

--when "11001100" => temp <= "01";

--when "11001101" => temp <= "01";

--when "11001110" => temp <= "00";

--when "11011010" => temp <= "00";

--when "11011011" => temp <= "01";

--when "11011100" => temp <= "01";

--when "11011101" => temp <= "00";

--when "11011110" => temp <= "00";

--when "11101010" => temp <= "00";

--when "11101011" => temp <= "01";

--when "11101100" => temp <= "01";

--when "11101101" => temp <= "00";

--when "11111010" => temp <= "00";

--when "11111011" => temp <= "00";

--when "11111100" => temp <= "00";

--when "11111101" => temp <= "00";

--when others => temp <= "11";
		
--end case;

--end if;

   --end process;

   --xy_address <= std_logic_vector(y_address) & std_logic_vector(x_address);
   
   --rgb <= "000000" when temp = "00" else
		  --"111111" when temp = "01" else
		  --"110011";
--end;