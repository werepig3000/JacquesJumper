library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity physics is
	generic(
		gravity : signed (2 downto 0) := 3d"1";
		friction : signed (2 downto 0) := 3d"1";
		run_accel : signed (2 downto 0) := 3d"1";
		
		reset_x : std_logic_vector (9 downto 0) := 10d"315";
		reset_y : std_logic_vector (9 downto 0) := 10d"10";
		
		jac_terminal : signed (9 downto 0) := "1111110000";
		jacques_width : unsigned (9 downto 0) := 10d"28";
		jacques_height : unsigned (9 downto 0) := 10d"47";
		
		platform_offset : signed (9 downto 0) := 10d"60";
		platform_width : unsigned(9 downto 0) := 10d"50";
		
		collision_leniency : signed (9 downto 0) := 10d"12"
		);
		
	port(
		conchIn : in std_logic_vector (7 downto 0);
		physClk : in std_logic;
		
		jac_x : out std_logic_vector (9 downto 0);
		jac_y : out std_logic_vector (9 downto 0);
		
		--plat_x : in std_logic_vector (9 downto 0);
		plat_x1 : in std_logic_vector (9 downto 0);
		plat_x2 : in std_logic_vector (9 downto 0);
		plat_x3 : in std_logic_vector (9 downto 0);
		plat_x4 : in std_logic_vector (9 downto 0);
		plat_x5 : in std_logic_vector (9 downto 0);
		plat_x6 : in std_logic_vector (9 downto 0);
		plat_x7 : in std_logic_vector (9 downto 0);
		
		
		plat_y : out std_logic_vector (9 downto 0);
		plat_y1 : out std_logic_vector (9 downto 0);
		plat_y2 : out std_logic_vector (9 downto 0);
		plat_y3 : out std_logic_vector (9 downto 0);
		plat_y4 : out std_logic_vector (9 downto 0);
		plat_y5 : out std_logic_vector (9 downto 0);
		plat_y6 : out std_logic_vector (9 downto 0);
		plat_y7 : out std_logic_vector (9 downto 0);

		on_plat_out : out std_logic;
		jac_x_vel_out : out signed(9 downto 0);
		dead_out : out std_logic;
		lives_out : out std_logic_vector (2 downto 0);
		init_out : out std_logic;
		
		jumpSize : out signed (3 downto 0);
		
		
		state: in std_logic_vector(1 downto 0)
	);
end physics; 

architecture synth of physics is
		signal jac_x_vel : signed (9 downto 0) := 10d"0";
		signal jac_y_vel : signed (9 downto 0) := 10d"0";
		--signal jac_y_vel_init :  signed (9 downto 0) := 10d"0";
		signal jac_x_terminal : std_logic;
		signal jac_y_terminal : std_logic;
		signal physClk_slow : unsigned (1 downto 0);
		signal jumpCounter : signed (1 downto 0);
		signal on_ground : std_logic;
		signal on_plat : std_logic;
		signal plat_y_vel : signed (9 downto 0) := "1111111101";
		signal falling : std_logic;
		signal dead : std_logic;
		signal begin_plat : std_logic;
		signal previous_position : std_logic_vector (9 downto 0);
		
		signal lives : unsigned (2 downto 0):= 3d"1";
		
		signal init : std_logic := '0';
		
		signal previous_button : std_logic;
		
	begin
		
		jac_x_terminal <= '1' when ((jac_x_vel = 10d"9") or (jac_x_vel = "1111110111")) else '0';
		--jac_y_terminal <= '1' when ((jac_y_vel = 10d"12") or (jac_y_vel = "1111110100")) else '0';
		jac_y_terminal <= '1' when (jac_y_vel = "1111110000") else '0';
		on_ground <= '1' when ((unsigned(jac_y) = 10d"400")) else '0';
		on_plat <= '1' when (((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > 10d"295") and (unsigned(jac_x) + 10d"1" < 10d"342")) or
		(((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y1)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y1) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > (unsigned(plat_x1))) and (unsigned(jac_x) + 10d"1" < (unsigned(plat_x1)) + platform_width)) or
		(((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y2)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y2) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > (unsigned(plat_x2))) and (unsigned(jac_x) + 10d"1" < (unsigned(plat_x2)) + platform_width)) or
		(((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y3)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y3) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > (unsigned(plat_x3))) and (unsigned(jac_x) + 10d"1" < (unsigned(plat_x3)) + platform_width)) or
		(((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y4)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y4) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > (unsigned(plat_x4))) and (unsigned(jac_x) + 10d"1" < (unsigned(plat_x4)) + platform_width)) or
		(((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y5)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y5) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > (unsigned(plat_x5))) and (unsigned(jac_x) + 10d"1" < (unsigned(plat_x5)) + platform_width)) or
		(((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y6)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y6) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > (unsigned(plat_x6))) and (unsigned(jac_x) + 10d"1" < (unsigned(plat_x6)) + platform_width)) or
		(((signed(jac_y) + signed(jacques_height) - jac_y_vel) >= signed(plat_y7)) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y7) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > (unsigned(plat_x7))) and (unsigned(jac_x) + 10d"1" < (unsigned(plat_x7)) + platform_width)) else '0'; --Add in plat_width. Should be a constant that is probably 10d"50" -- Change 10d"3" for collision leniency
		
		

		
		--begin_plat <= '1' when ((jac_y <= 10d"50") and (jac_y >= 10d"20") and (jac_x < 10d"5")) else '0';
		
		
		
		
		--and ((unsigned(jac_y) + jacques_height) < (unsigned(plat_y) + 10d"3"))
		
		falling <= '1' when (jac_y_vel < 10d"0") else '0';
		
		
		
process (physClk) begin										-- horizontal movement WORK
	if (rising_edge(physClk)) then
	if ((unsigned(previous_position) - 10d"400") < unsigned(jac_y) and (state = "01")) then
			dead <= '1';
			init <= '0';
		else
			dead <= '0';
		end if;
		if (state = "01") then		
			if (init = '0') then
				jac_y <= reset_y;
				jac_x <= reset_x;
				plat_y <= std_logic_vector(unsigned(reset_y) + 10d"75");
				init <= '1';
			else
				previous_position <= jac_y;
				if (conchIn(0)) then
					if jac_x_terminal then
						jac_x_vel <= jac_x_vel;
					else
						jac_x_vel <= jac_x_vel + run_accel;
					end if;
				elsif (conchIn(1)) then
					if jac_x_terminal then
						jac_x_vel <= jac_x_vel;
					else
						jac_x_vel <= jac_x_vel - run_accel; 
					end if;
				else 												--horizontal decelleration WORKING
					if(jac_x_vel = 9d"0") then
						jac_x_vel <= jac_x_vel;
					elsif (jac_x_vel > 9d"0") then
						jac_x_vel <= jac_x_vel - friction;
					elsif (jac_x_vel < 9d"0") then
						jac_x_vel <= jac_x_vel + friction;
					end if;							
				end if;
				
				if (on_plat) then									--on plat
					jac_y_vel <= plat_y_vel;
					jac_y <= std_logic_vector(signed(plat_y) - signed(jacques_height));
					if (ConchIn(6)) then
						--jac_y_vel <= 10d"16";
						jac_y_vel <= 10d"14";
						--+ ('0' & '0' & '0' & '0' & '0' & '0' & jumpSize);
						--jumpCounter <= 2d"0";
						--jumpSize <= 4d"0";
					end if;
					if (ConchIn(7)) then
						jumpCounter <= jumpCounter + 2d"1";
						jumpSize <= jumpSize + 4d"1" when (jumpCounter(1) and (not jumpCounter(0)) and 
						(not (jumpSize(0) and jumpSize(1) and jumpSize(2) and jumpSize(3)))) else jumpSize;
						previous_button <= '1';
					else
						previous_button <= '0';
					end if;
					
					if ((previous_button = '1') and (ConchIn(7) = '0')) then
						jac_y_vel <= 10d"10" + ('0' & '0' & '0' & '0' & '0' & '0' & jumpSize);
						jumpCounter <= 2d"0";
						jumpSize <= 4d"0";
					end if;
					
				end if;
				
				if(not on_plat) then -- downward aerial acceleration (fall speed) WORKING
					previous_button <= '0';
					jumpSize <= 4d"0";
					jumpCounter <= 2d"0";
					if(jac_y_terminal) then
						jac_y_vel <= jac_terminal;
					else
						jac_y_vel <= jac_y_vel - gravity;
					end if;
				end if;	
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > 10d"295") and (unsigned(jac_x) + 10d"1" < 10d"342")) then --default plat
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y1) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y1) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > unsigned(plat_x1)) and (unsigned(jac_x) + 10d"1" < unsigned(plat_x1) + platform_width)) then --plat 1 collisions
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y2) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y2) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > unsigned(plat_x2)) and (unsigned(jac_x) + 10d"1" < unsigned(plat_x2) + platform_width)) then --plat 2 collisions
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y3) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y3) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > unsigned(plat_x3)) and (unsigned(jac_x) + 10d"1" < unsigned(plat_x3) + platform_width)) then --plat 3 collisions
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y4) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y4) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > unsigned(plat_x4)) and (unsigned(jac_x) + 10d"1" < unsigned(plat_x4) + platform_width)) then --plat 4 collisions
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y5) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y5) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > unsigned(plat_x5)) and (unsigned(jac_x) + 10d"1" < unsigned(plat_x5) + platform_width)) then --plat 5 collisions
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y6) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y6) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > unsigned(plat_x6)) and (unsigned(jac_x) + 10d"1" < unsigned(plat_x6) + platform_width)) then --plat 4 collisions
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((falling = '1') and (signed(jac_y) + signed(jacques_height) - jac_y_vel >= signed(plat_y7) - plat_y_vel) and ((signed(jac_y) + jac_y_vel + signed(jacques_height)) < (signed(plat_y7) + collision_leniency)) and (unsigned(jac_x) + 10d"27" > unsigned(plat_x7)) and (unsigned(jac_x) + 10d"1" < unsigned(plat_x7) + platform_width)) then --plat 4 collisions
					--jac_y <= std_logic_vector(signed(plat_y) + plat_y_vel + signed(jacques_height) + 10d"1");
					jac_y_vel <= plat_y_vel + 10d"1";
				end if;
				
				if ((unsigned(jac_y) + unsigned(jacques_height) - unsigned(jac_y_vel)) <= 10d"1") then
					jac_y_vel <= 10d"0";
				end if;
				

				if ((jac_x > 10d"639") and (jac_x_vel > 10d"0")) then
					jac_x <= 10d"0";
				elsif ((jac_x > 10d"639") and (jac_x_vel < 10d"0")) then
					jac_x <= 10d"639";
				else
					jac_x <= std_logic_vector((signed(jac_x) + (jac_x_vel)));
				end if;
				

				jac_y <= std_logic_vector((signed(jac_y) - (jac_y_vel)) mod 479);


				plat_y <= (std_logic_vector((signed(plat_y) - plat_y_vel) mod 479));
				plat_y1 <= (std_logic_vector((signed(plat_y) - plat_y_vel - platform_offset) mod 479));
				plat_y2 <= (std_logic_vector((signed(plat_y1) - plat_y_vel - platform_offset) mod 479));
				plat_y3 <= (std_logic_vector((signed(plat_y2) - plat_y_vel - platform_offset) mod 479));
				plat_y4 <= (std_logic_vector((signed(plat_y3) - plat_y_vel - platform_offset) mod 479));
				plat_y5 <= (std_logic_vector((signed(plat_y4) - plat_y_vel - platform_offset) mod 479));
				plat_y6 <= (std_logic_vector((signed(plat_y5) - plat_y_vel - platform_offset) mod 479));
				plat_y7 <= (std_logic_vector((signed(plat_y6) - plat_y_vel - platform_offset) mod 479));
					
			end if; 
			--if (begin_plat) then
				--jac_y_vel <= 10d"0";
			--end if;

		end if;
	end if;
end process;
		on_plat_out <= on_plat;
		jac_x_vel_out <= jac_x_vel;
		dead_out <= dead;
		lives_out <= lives_out;
		init_out <= init;
	end;

-- TODO: Left and right decelleration DONE, 

		
-- 0 Right
-- 1 Left
-- 2 Down
-- 3 Up
-- 4 Start
-- 5 Select
-- 6 B
-- 7 A