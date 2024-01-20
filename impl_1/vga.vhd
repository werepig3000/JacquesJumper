library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity vga is
	port(
		clk_in : in std_logic;
		hsync : out std_logic;
		vsync : out std_logic;
		valid : out std_logic;
		row : out unsigned (9 downto 0);
		col : out unsigned (9 downto 0);
		sixty_hz : out std_logic
	);
end;
-- DONT TOUCH THIS EVER FOR EVER NEVER

architecture synth of vga is
	signal row_count : unsigned (9 downto 0) := 10d"0";
	signal column_count : unsigned (9 downto 0) := 10d"0";

begin
	process (clk_in) begin
		if rising_edge(clk_in) then
			column_count <= column_count + "1";
			if column_count = 10d"660" then
				hsync <= '0';
			elsif column_count = 10d"756" then
				hsync <= '1';
			elsif column_count = 10d"799" then
				column_count <= 10d"0";
				row_count <= row_count + "1";
				hsync <= '1';
			end if;
		
			if row_count = 10d"491" then
				vsync <= '0';
			elsif row_count = 10d"493" then
				vsync <= '1';
			elsif row_count = 10d"524" then
				row_count <= 10d"0";
			end if;
		end if;
	end process;
	valid <= '1' when (column_count < 10d"640" and row_count < 10d"480") else '0';
	row <= row_count;
	col <= column_count;
	sixty_hz <= vsync;
end;



	
