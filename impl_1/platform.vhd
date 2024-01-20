library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity platform is
	port (
	    --inputs
		clkPlat : in std_logic;
		platform_rand_x : in std_logic_vector (9 downto 0);
		
		-- 6 possible platforms at all times
		x_platform_1 : out std_logic_vector (9 downto 0);
		y_platform_1 : in std_logic_vector (9 downto 0); -- CHANGE TO WHATEVER VALUE THE TOP OF THE SCREEN Y-PIXEL IS
		
		x_platform_2 : out std_logic_vector (9 downto 0);
		y_platform_2 : in std_logic_vector (9 downto 0);
		
		x_platform_3 : out std_logic_vector (9 downto 0);
		y_platform_3 : in std_logic_vector (9 downto 0);
		
		x_platform_4 : out std_logic_vector (9 downto 0);
		y_platform_4 : in std_logic_vector (9 downto 0);
		
		x_platform_5 : out std_logic_vector (9 downto 0);
		y_platform_5 : in std_logic_vector (9 downto 0);
		
		x_platform_6 : out std_logic_vector (9 downto 0);
		y_platform_6 : in std_logic_vector (9 downto 0);
		
		x_platform_7 : out std_logic_vector (9 downto 0);
		y_platform_7 : in std_logic_vector (9 downto 0)
	);
end platform;


architecture synth of platform is
begin



process (clkPlat) begin
	if rising_edge(clkPlat) then
	
		if (signed(y_platform_1) mod 479 <= 10d"2") then
			x_platform_1 <= platform_rand_x; -- Once the platform goes off screen, reset its y value to 0 and randomize its x value.
		end if;
	
		if (signed(y_platform_2) mod 479 <= 10d"2") then
			x_platform_2 <= platform_rand_x; -- Once the platform goes off screen, reset its y value to 0 and randomize its x value.
		end if;
	
		if (signed(y_platform_3) mod 479 <= 10d"2") then
			x_platform_3 <= platform_rand_x; -- Once the platform goes off screen, reset its y value to 0 and randomize its x value.
		end if;
		
		if (signed(y_platform_4) mod 479 <= 10d"2") then
			x_platform_4 <= platform_rand_x; -- Once the platform goes off screen, reset its y value to 0 and randomize its x value.
		end if;
		
		if (signed(y_platform_5) mod 479 <= 10d"2") then
			x_platform_5 <= platform_rand_x; -- Once the platform goes off screen, reset its y value to 0 and randomize its x value.
		end if;
		
		if (signed(y_platform_6) mod 479 <= 10d"2") then
			x_platform_6 <= platform_rand_x; -- Once the platform goes off screen, reset its y value to 0 and randomize its x value.
		end if;
		
		if (signed(y_platform_7) mod 479 <= 10d"2") then
			x_platform_7 <= platform_rand_x; -- Once the platform goes off screen, reset its y value to 0 and randomize its x value.
		end if;

		
	end if;
end process;
end;



