library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift8 is
	port(
		input : in std_logic;
		latch : out std_logic;
		outputClk : out std_logic;
		result : out std_logic_vector(7 downto 0);
		data_out : out std_logic;
		resultFinal : out std_logic_vector(7 downto 0)
	);
end shift8;

architecture synth of shift8 is

component HSOSC is
	generic (CLKHF_DIV : String := "0b00");
	port(CLKHFPU : in std_logic := 'X';
	CLKHFEN : in std_logic := 'X';
	CLKHF : out std_logic := 'X');
end component;

signal clk : std_logic;
signal intermediate : std_logic_vector(7 downto 0);
signal intermediate2 : std_logic_vector(7 downto 0);
signal count : unsigned(25 downto 0);
signal slowClk : std_logic;
signal slowCount : unsigned(7 downto 0);

begin

osc : HSOSC generic map (CLKHF_DIV => "0b00")
	port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);

process (clk) begin
	if rising_edge(clk) then
		count <= count + 1;
	end if;
end process;

slowClk <= count(8);
slowCount <= count(16 downto 9);
latch <= '1' when slowCount = 8x"08" else '0';
outputClk <= slowClk when (slowCount < 8x"08") else '0';

process (outputCLK) begin
	if rising_edge(outputClk) then
		intermediate(7 downto 1) <= intermediate(6 downto 0);
		intermediate(0) <= not input;
	end if;
end process;
result <= intermediate;
data_out <= not input;
intermediate2 <= intermediate when latch;
resultFinal <= intermediate2;

end;
