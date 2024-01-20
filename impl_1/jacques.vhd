library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity jacques is
	port(
		xpos : out std_logic_vector (9 downto 0);
		ypos : out std_logic_vector (9 downto 0)
	);
end jacques;

architecture synth of jacques is

component physics is
	port(
		jac_x : out std_logic_vector(9 downto 0);
		jac_y : out std_logic_vector(9 downto 0)
		);
end component;



begin

phy_11 : physics port map(jac_x => xpos, jac_y => ypos);

end;

