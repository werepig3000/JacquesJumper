library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity address_ctrl is
	port(
		clk : in std_logic;
		count : out unsigned (25 downto 0)
	);
end address_ctrl;

architecture synth of address_ctrl is
	signal temp : unsigned (25 downto 0) := 26d"0";
begin

	process (clk) begin
		if rising_edge(clk) then
			count <= count + 26d"1";
		end if;
	end process;
end;