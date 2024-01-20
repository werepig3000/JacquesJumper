library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

	entity pgen is
		generic(
		jacques_width : unsigned (9 downto 0) := 10d"28";
		jacques_height : unsigned (9 downto 0) := 10d"47";
		platform_width : unsigned (9 downto 0) := 10d"50"; -- var created 11/30 MAKE GENERIC
		platform_height : unsigned (9 downto 0) := 10d"4" -- var created 11/30
		);
		port(
			row, column : in unsigned (9 downto 0);
			valid : in std_logic;
			clkIn : in std_logic;
			rgb : out std_logic_vector (5 downto 0);
			conchIn : in std_logic_vector (7 downto 0);
			sixty_hz : in std_logic;
			state : in std_logic_vector (1 downto 0);
			
			jacques_x : in std_logic_vector (9 downto 0);
			jacques_y : in std_logic_vector (9 downto 0);
			
			-- platforms
			
			--plat_x : in std_logic_vector (9 downto 0);
			plat_y : in std_logic_vector (9 downto 0);
			
			plat1_x : in std_logic_vector (9 downto 0);
			plat1_y : in std_logic_vector (9 downto 0);
			
			plat2_x : in std_logic_vector (9 downto 0);
			plat2_y : in std_logic_vector (9 downto 0);
			
			plat3_x : in std_logic_vector (9 downto 0);
			plat3_y : in std_logic_vector (9 downto 0);
			
			plat4_x : in std_logic_vector (9 downto 0);
			plat4_y : in std_logic_vector (9 downto 0);
			
			plat5_x : in std_logic_vector (9 downto 0);
			plat5_y : in std_logic_vector (9 downto 0);
			
			plat6_x : in std_logic_vector (9 downto 0);
			plat6_y : in std_logic_vector (9 downto 0);
			
			plat7_x : in std_logic_vector (9 downto 0);
			plat7_y : in std_logic_vector (9 downto 0);
			
			-- game state outs controlled in pgen
			
			mode_select : out std_logic;
			char_select : out std_logic;
			
			-- from physics special vars (not platforms) 
			pgen_on_plat : in std_logic;
			pgen_jac_x_vel : in signed (9 downto 0);
			
			--draw score inputs
			ones_rgb : in std_logic_vector (5 downto 0);
			tens_rgb : in std_logic_vector (5 downto 0);
			hundreds_rgb : in std_logic_vector (5 downto 0);
			
			jump_size : in signed (3 downto 0)

			);
	end pgen;
	
architecture synth of pgen is
	
		-- signals -----------------------------------------------------------------------------------------------------------------------------------------------------------
		signal left_bound : std_logic_vector (9 downto 0);
		signal right_bound : std_logic_vector (9 downto 0);
		signal row_left : unsigned (9 downto 0) := 10d"230";
		signal column_left : unsigned (9 downto 0) := 10d"230";
		signal row_right : unsigned (9 downto 0);
		signal column_right : unsigned (9 downto 0);
		
		-- platform TEST shi (PRIME)
	
		signal platform_x : unsigned (9 downto 0); -- IF THESE ARE MAPPED IN REPLACE THIS
		signal platform_y : unsigned (9 downto 0);-- TEMP
		signal platform_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform_rgb : std_logic_vector(5 downto 0);
		
		-- PLATFORM 1 
		
		signal platform1_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform1_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform1_rgb : std_logic_vector(5 downto 0);
		
		-- PLATFORM 2
		
		signal platform2_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform2_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform2_rgb : std_logic_vector(5 downto 0);
		
		-- PLATFORM 3
		
		signal platform3_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform3_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform3_rgb : std_logic_vector(5 downto 0);
		
		-- PLATFORM 4
		
		signal platform4_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform4_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform4_rgb : std_logic_vector(5 downto 0);
		
		-- PLATFORM 5
		
		signal platform5_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform5_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform5_rgb : std_logic_vector(5 downto 0);
		
		-- PLATFORM 6
		
		signal platform6_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform6_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform6_rgb : std_logic_vector(5 downto 0);
		
		-- PLATFORM 7
		
		signal platform7_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal platform7_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal platform7_rgb : std_logic_vector(5 downto 0);
		
		-- frog signals :::::::::::::::::::::::::::::::::
		
		signal jacques_diff_x : unsigned (9 downto 0); -- var created 11/30
		signal jacques_diff_y : unsigned (9 downto 0); --var created 11/30 (need pform x and y signals)
		signal jacques_forward_rgb : std_logic_vector(5 downto 0);
		signal jacques_forward_armsUp_rgb : std_logic_vector(5 downto 0);
		signal jacques_left_armsUp_rgb : std_logic_vector(5 downto 0);
		signal jacques_left_armsDown_rgb : std_logic_vector(5 downto 0);
		signal jacques_right_armsUp_rgb : std_logic_vector(5 downto 0);
		signal jacques_right_armsDown_rgb : std_logic_vector(5 downto 0);
		signal right_diff_x : unsigned (9 downto 0); -- to flip our left character and save rom space
		
		--SCREENS ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		-- Brick background
		signal brick_diff_x : unsigned (9 downto 0);
		signal brick_diff_y : unsigned (9 downto 0);
		signal start_background_rgb : std_logic_vector (5 downto 0);
		
		-- in game background
		signal inGameBackgroundRGB : std_logic_vector (5 downto 0);
		
		-- gradients
		signal grad_diff_x : unsigned (9 downto 0);
		
		signal g1_diff_y : unsigned (9 downto 0);
		signal g1_rgb : std_logic_vector (5 downto 0);
		
		
		signal g2_diff_y : unsigned (9 downto 0);
		signal g2_rgb : std_logic_vector (5 downto 0);
		
		
		signal g3_diff_y : unsigned (9 downto 0);
		signal g3_rgb : std_logic_vector (5 downto 0);
		
		-- game state logic CHANGE CHANGE CHAGNE CAHNE TO 0 WHEN WE REALLY DO THIS SHI
		
		--signal mode_selected : std_logic := '1';
		--signal char_selected : std_logic := '1';

		-- components' declerations (IGNORE: comments next to adress bits, simple copy paste errors)----------------------------------------------------------------------------------------------------------------------------------------
		
		
			-- platform1_rom ::::::::::::::::::::::::::::::::::::::::::::::
		component platform1_ROM is
			port(
				clk : in std_logic;
				x_address: in unsigned(5 downto 0); -- 0-64, will require an “x_diff” input when mapped
				y_address: in unsigned(1 downto 0); -- 0-3 will require a “y_diff” input when mapped
				rgb : out std_logic_vector(5 downto 0)
			);
		end component;
		
		-- JACQUES DECLERATIONS ::::::::::::::::::::::
		component frogForwardROM is --reg forward
			port(
				clk : in std_logic;
				x_address: in unsigned(4 downto 0); -- 0-32, will require an “x_diff” input when mapped
				y_address: in unsigned(5 downto 0); -- 0-64 will require a “y_diff” input when mapped;
				rgb : out std_logic_vector(5 downto 0)
			);
		end component;
		
		component armsUp is -- reg forward arms up
		  port(
			  clk : in std_logic;
			  x_address: in unsigned(4 downto 0); -- 0-16, will require an “x_diff” input when mapped
			  y_address: in unsigned(5 downto 0); -- 0-16 will require a “y_diff” input when mapped
			  rgb : out std_logic_vector(5 downto 0)
			);
		end component;
		
		component armsUpLeft is
		  port(
			  clk : in std_logic;
			  x_address: in unsigned(4 downto 0); -- 0-16, will require an “x_diff” input when mapped
			  y_address: in unsigned(5 downto 0); -- 0-16 will require a “y_diff” input when mapped
			  rgb : out std_logic_vector(5 downto 0)
			);
		end component;
		
		component armsDownLeft is
		  port(
			  clk : in std_logic;
			  x_address: in unsigned(4 downto 0); -- 0-16, will require an “x_diff” input when mapped
			  y_address: in unsigned(5 downto 0); -- 0-16 will require a “y_diff” input when mapped
			  rgb : out std_logic_vector(5 downto 0)
			);
		end component;
		
		
		
		-- brick bakcground :::::::::::::::::::::::::
		component BricksROM is
		  port(
			clk : in std_logic;
			x_address: in unsigned(3 downto 0); -- 0-16, will require an “x_diff” input when mapped
			y_address: in unsigned(3 downto 0); -- 0-16 will require a “y_diff” input when mapped
			rgb : out std_logic_vector(5 downto 0)
			  );
		end component;

		-- in game bakcground
		
		component inGameBackgroundROM is
		  port(
		  row : in unsigned(9 downto 0); 
		  rgb : out std_logic_vector(5 downto 0)
			  );
			  
		end component;
		
		component gradientROM is
			port(
			  clk : in std_logic;
			  x_address: in unsigned(2 downto 0); -- 0-8, will require an “x_diff” input when mapped
			  y_address: in unsigned(4 downto 0); -- 0-32 will require a “y_diff” input when mapped
			  layer : in std_logic_vector(1 downto 0);
			  rgb : out std_logic_vector(5 downto 0)
				  );
		end component;
		
		
		
		-- CROUCH ANIMATION
		
		component crouch1ROM is

		  port(

		  clk : in std_logic;
		  x_address: in unsigned(4 downto 0); 
		  y_address: in unsigned(5 downto 0);
		  rgb : out std_logic_vector(5 downto 0)

			  );
		end component;
		
		component crouch2ROM is

		  port(

		  clk : in std_logic;
		  x_address: in unsigned(4 downto 0); 
		  y_address: in unsigned(5 downto 0);
		  rgb : out std_logic_vector(5 downto 0)
			  );
		end component;
		
		component crouch3ROM is
		  port(
		  clk : in std_logic;
		  x_address: in unsigned(4 downto 0); 
		  y_address: in unsigned(5 downto 0);
		  rgb : out std_logic_vector(5 downto 0)
			  );
		end component;
		
		component crouchFinalROM is
		  port(
		  clk : in std_logic;
		  x_address: in unsigned(4 downto 0); 
		  y_address: in unsigned(5 downto 0);
		  rgb : out std_logic_vector(5 downto 0)

			  );
		end component;
		
		signal crouch1_rgb : std_logic_vector(5 downto 0);
		signal crouch2_rgb : std_logic_vector(5 downto 0);
		signal crouch3_rgb : std_logic_vector(5 downto 0);
		signal crouchFinal_rgb : std_logic_vector(5 downto 0);
		
		signal crouch_diffy : unsigned (9 downto 0);
		signal crouch1_diffx : unsigned (9 downto 0);
		signal crouch2_diffx : unsigned (9 downto 0);
		signal crouch3_diffx : unsigned (9 downto 0);
		signal crouchFinal_diffx : unsigned (9 downto 0);
		signal start_jacques_rgb : std_logic_vector (5 downto 0);
		signal start_jacques_diffx : unsigned (9 downto 0);
		
		
		
		
		signal crouch1_rgb_ani : std_logic_vector(5 downto 0);
		signal crouch2_rgb_ani : std_logic_vector(5 downto 0);
		signal crouch3_rgb_ani : std_logic_vector(5 downto 0);
		signal crouchFinal_rgb_ani : std_logic_vector(5 downto 0);
		
		
		
		


	begin -- =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
	
		
	
	
		-- find platform test1 RGB
		platform_x <= 10d"295";
		platform_y <= unsigned(plat_y);
		platform_diff_x <= column - platform_x + 1;
		platform_diff_y <= row - platform_y;
		--instantiate platform test
		Draw_platform : platform1_ROM port map(clk => clkIn, 
											   x_address => platform_diff_x(5 downto 0), 
											   y_address => platform_diff_y(1 downto 0), 
											   rgb => platform_rgb
											   );
		
		
		-- find platform 1 diffs
		platform1_diff_x <= column - unsigned(plat1_x) + 1;
		platform1_diff_y <= row - unsigned(plat1_y);
		--instantiate platform 1
		Draw_platform1 : platform1_ROM port map(clk => clkIn, 
											   x_address => platform1_diff_x(5 downto 0), 
											   y_address => platform1_diff_y(1 downto 0), 
											   rgb => platform1_rgb
											   );
		
		-- find platform 2 diff 
		platform2_diff_x <= column - unsigned(plat2_x) + 1;
		platform2_diff_y <= row - unsigned(plat2_y);
		--instantiate platform 2
		Draw_platform2 : platform1_ROM port map(clk => clkIn, 
											   x_address => platform2_diff_x(5 downto 0), 
											   y_address => platform2_diff_y(1 downto 0), 
											   rgb => platform2_rgb
											   );
		-- find platform 3 diff 
		platform3_diff_x <= column - unsigned(plat3_x) + 1;
		platform3_diff_y <= row - unsigned(plat3_y);
		--instantiate platform 3
		Draw_platform3 : platform1_ROM port map(clk => clkIn, 
											   x_address => platform3_diff_x(5 downto 0), 
											   y_address => platform3_diff_y(1 downto 0), 
											   rgb => platform3_rgb
											   );
		-- find platform 4 diff 
		platform4_diff_x <= column - unsigned(plat4_x) + 1;
		platform4_diff_y <= row - unsigned(plat4_y);
		--instantiate platform 4
		Draw_platform4 : platform1_ROM port map(clk => clkIn, 
											   x_address => platform4_diff_x(5 downto 0), 
											   y_address => platform4_diff_y(1 downto 0), 
											   rgb => platform4_rgb
											   );
		-- find platform 5 diff 
		platform5_diff_x <= column - unsigned(plat5_x) + 1;
		platform5_diff_y <= row - unsigned(plat5_y);
		--instantiate platform 5
		Draw_platform5 : platform1_ROM port map(clk => clkIn, 
											   x_address => platform5_diff_x(5 downto 0), 
											   y_address => platform5_diff_y(1 downto 0), 
											   rgb => platform5_rgb
											   );
		-- find platform 6 diff 
		platform6_diff_x <= column - unsigned(plat6_x) + 1;
		platform6_diff_y <= row - unsigned(plat6_y);
		--instantiate platform 6
		Draw_platform6 : platform1_ROM port map(clk => clkIn, 
											   x_address => platform6_diff_x(5 downto 0), 
											   y_address => platform6_diff_y(1 downto 0), 
											   rgb => platform6_rgb
											   );
		-- find platform 7 diff 
		platform7_diff_x <= column - unsigned(plat7_x) + 1;
		platform7_diff_y <= row - unsigned(plat7_y);
		--instantiate platform 7
		Draw_platform7 : platform1_ROM port map(clk => clkIn, 
											   x_address => platform7_diff_x(5 downto 0), 
											   y_address => platform7_diff_y(1 downto 0),											   
											   rgb => platform7_rgb
											   );
		
		-- DRAW JACQUES/Player sprites :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		-- find jacques RGB
		
		jacques_diff_x <= column - unsigned(jacques_x);
		jacques_diff_y <= row - unsigned(jacques_y);
		right_diff_x <= unsigned(0 - signed(jacques_diff_x) + 10d"27");
		
		-- instantiate jacques RGB
		
		Draw_Jacques_forward : frogForwardROM port map(clk => clkIn, 
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => jacques_forward_rgb
											   );
		
		Draw_Jacques_armsUp : armsUp port map(clk => clkIn, 
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => jacques_forward_armsUp_rgb
											   );
											   
		Draw_Jacques_L_armsDown : armsDownLeft port map(clk => clkIn, 
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => jacques_left_armsDown_rgb
											   );
											   
		Draw_Jacques_L_armsUp : armsUpLeft port map(clk => clkIn, 
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => jacques_left_armsUp_rgb
											   );
							
		Draw_Jacques_R_armsDown : armsDownLeft port map(clk => clkIn, --right
											   x_address => right_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => jacques_right_armsDown_rgb
											   );
											   
		Draw_Jacques_R_armsUp : armsUpLeft port map(clk => clkIn, --right 
											   x_address => right_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => jacques_right_armsUp_rgb
											   );
											   
		--Draw_crouch1 : crouch1ROM port map(clk => clkIn,
											   --x_address => crouch1_diffx(4 downto 0), 
											   --y_address => crouch_diffy(5 downto 0), 
											   --rgb => crouch1_rgb
											   --);
											   
		--Draw_crouch2 : crouch2ROM port map(clk => clkIn,
											   --x_address => crouch2_diffx(4 downto 0), 
											   --y_address => crouch_diffy(5 downto 0), 
											   --rgb => crouch2_rgb
											   --);
		--Draw_crouch3 : crouch3ROM port map(clk => clkIn,
											   --x_address => crouch3_diffx(4 downto 0), 
											   --y_address => crouch_diffy(5 downto 0), 
											   --rgb => crouch3_rgb
											   --);
		Draw_crouchFinal : crouchFinalROM port map(clk => clkIn,
											   x_address => crouchFinal_diffx(4 downto 0), 
											   y_address => crouch_diffy(5 downto 0), 
											   rgb => crouchFinal_rgb
											   );
											   
		crouch_diffy <= row - 221;
		start_jacques_diffx <= column - 415;
		crouch1_diffx <= column - 361;
		crouch2_diffx <= column - 307;
		crouch3_diffx <= column - 253;
		crouchFinal_diffx <= column - 199;
		
		Draw_StartJac : frogForwardROM port map(clk => clkIn,
											   x_address => start_jacques_diffx(4 downto 0), 
											   y_address => crouch_diffy(5 downto 0), 
											   rgb => start_jacques_rgb
											   );
											   
											   
		crouch1Ani : crouch1ROM port map(clk => clkIn,
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => crouch1_rgb_ani
											   );
		crouch2Ani : crouch2ROM port map(clk => clkIn,
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => crouch2_rgb_ani
											   );
		crouch3Ani : crouch3ROM port map(clk => clkIn,
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => crouch3_rgb_ani
											   );
		crouchFINALAni : crouchFinalROM port map(clk => clkIn,
											   x_address => jacques_diff_x(4 downto 0), 
											   y_address => jacques_diff_y(5 downto 0), 
											   rgb => crouchFinal_rgb_ani
											   );
		
											   
											 
		
		
		
		-- Draw Backgrounds
		
		brick_diff_x <= (column mod 10d"16");
		brick_diff_y <= (row mod 10d"16");
		
		Draw_bricks : BricksROM port map(clk => clkIn, 
											   x_address => brick_diff_x(3 downto 0), 
											   y_address => brick_diff_y(3 downto 0), 
											   rgb => start_background_rgb
											   );
											   
		Draw_inGame_Background : inGameBackgroundROM port map( row => row,
															   rgb => inGameBackgroundRGB
															  );	
															  
															  
		Draw_inGame_gradient1 : gradientROM port map(clk => clkIn, 
											   x_address => grad_diff_x(2 downto 0), 
											   y_address => g1_diff_y(4 downto 0),
											   layer => "00",
											   rgb => g1_rgb
											   );
		grad_diff_x <= (column mod 10d"8");
		
		g1_diff_y <= row - 10d"342";
		
		
		g2_diff_y <= row - 10d"222";
		
		
		g3_diff_y <= row - 10d"102";
											   
		Draw_inGame_gradient2 : gradientROM port map(clk => clkIn, 
											   x_address => grad_diff_x(2 downto 0), 
											   y_address => g2_diff_y(4 downto 0),
											   layer => "01",
											   rgb => g2_rgb
											   );
											   
											   
		Draw_inGame_gradient3 : gradientROM port map(clk => clkIn, 
											   x_address => grad_diff_x(2 downto 0), 
											   y_address => g3_diff_y(4 downto 0),
											   layer => "10",
											   rgb => g3_rgb
											   );
		
		-- NUMBERS ---
			
		
		
	
		
		
	
	
		-- update positions ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	process (clkIn) begin
		if rising_edge(clkIn) then
		--draw box
			if (valid = '1' and state = "01") then
				 --draw pixel WITHIN pixel area
					 --draw platform WITHIN platform are
				--if(column >= 10d"591" and column < 10d"607" and row >= 0 and row < 16 and hundreds_rgb /= "110011") then
					--rgb <= hundreds_rgb;
				--elsif(column >= 10d"607" and column < 10d"623" and row >= 0 and row < 16 and tens_rgb /= "110011") then
					--rgb <= tens_rgb;
				--elsif(column >= 10d"623" and column < 10d"639" and row >= 0 and row < 16 and ones_rgb /= "110011") then
					--rgb <= ones_rgb;
				if (platform_diff_x >= 0 and platform_diff_x <= platform_width and platform_diff_y >= 0 and platform_diff_y <= platform_height and platform_rgb /= "110011") then
					rgb <=  platform_rgb; -- TEST1 (PRIME)
				elsif (platform1_diff_x >= 0 and platform1_diff_x <= platform_width and platform1_diff_y >= 0 and platform1_diff_y <= platform_height and platform1_rgb /= "110011") then
					rgb <=  platform1_rgb; -- PLAT 1
				elsif (platform2_diff_x >= 0 and platform2_diff_x <= platform_width and platform2_diff_y >= 0 and platform2_diff_y <= platform_height and platform2_rgb /= "110011") then
					rgb <=  platform2_rgb; -- PLAT 2
				elsif (platform3_diff_x >= 0 and platform3_diff_x <= platform_width and platform3_diff_y >= 0 and platform3_diff_y <= platform_height and platform3_rgb /= "110011") then
					rgb <=  platform3_rgb; -- PLAT 3
				elsif (platform4_diff_x >= 0 and platform4_diff_x <= platform_width and platform4_diff_y >= 0 and platform4_diff_y <= platform_height and platform4_rgb /= "110011") then
					rgb <=  platform4_rgb; -- PLAT 4
				elsif (platform5_diff_x >= 0 and platform5_diff_x <= platform_width and platform5_diff_y >= 0 and platform5_diff_y <= platform_height and platform5_rgb /= "110011") then
					rgb <=  platform5_rgb; -- PLAT 5
				elsif (platform6_diff_x >= 0 and platform6_diff_x <= platform_width and platform6_diff_y >= 0 and platform6_diff_y <= platform_height and platform6_rgb /= "110011") then
					rgb <=  platform6_rgb; -- PLAT 6
				elsif (platform7_diff_x >= 0 and platform7_diff_x <= platform_width and platform7_diff_y >= 0 and platform7_diff_y <= platform_height and platform7_rgb /= "110011") then
					rgb <=  platform7_rgb; -- PLAT 7
				elsif (jacques_diff_x >= 0 and jacques_diff_x < jacques_width and jacques_diff_y >= 0 and jacques_diff_y < jacques_height) then -- drawing jacques
					if(pgen_jac_x_vel < 0 and pgen_on_plat = '0' and jump_size = 4d"0" and jacques_left_armsUp_rgb /= "110011") then -- left up
							rgb <= jacques_left_armsUp_rgb;
					elsif(pgen_jac_x_vel < 0 and pgen_on_plat = '1' and unsigned(jump_size) = 4d"0" and jacques_left_armsDown_rgb /= "110011") then -- left down logic
							rgb <= jacques_left_armsDown_rgb;
					elsif(pgen_jac_x_vel = 0 and pgen_on_plat = '1' and unsigned(jump_size) = 4d"0" and jacques_forward_rgb /= "110011") then -- reg plat (and right TEMP)
							rgb <= jacques_forward_rgb;
					elsif(pgen_jac_x_vel = 0 and pgen_on_plat = '0' and unsigned(jump_size) = 4d"0" and jacques_forward_armsUp_rgb /= "110011") then -- air jump no rl (AND RIGHT TEMP)
							rgb <= jacques_forward_armsUp_rgb;
					elsif(pgen_jac_x_vel > 0 and pgen_on_plat = '1' and unsigned(jump_size) = 4d"0" and jacques_right_armsDown_rgb /= "110011") then -- reg plat (and right TEMP)
							rgb <= jacques_right_armsDown_rgb;
					elsif(pgen_jac_x_vel > 0 and pgen_on_plat = '0' and unsigned(jump_size) = 4d"0" and jacques_right_armsUp_rgb /= "110011") then -- air jump no rl (AND RIGHT TEMP)
							rgb <= jacques_right_armsUp_rgb;
					elsif(unsigned(jump_size) > 4d"0" and unsigned(jump_size) < 4d"6" and crouch1_rgb_ani /= "110011") then
							rgb <= crouch1_rgb_ani;
					elsif(unsigned(jump_size) > 4d"5" and unsigned(jump_size) < 4d"10" and crouch2_rgb_ani /= "110011") then
							rgb <= crouch2_rgb_ani;
					elsif(unsigned(jump_size) > 4d"9" and unsigned(jump_size) < 4d"13" and crouch3_rgb_ani /= "110011") then
							rgb <= crouch3_rgb_ani;
					elsif(unsigned(jump_size) > 4d"12" and crouchFinal_rgb_ani /= "110011") then
							rgb <= crouchFinal_rgb_ani;
					elsif(grad_diff_x >= 0 and grad_diff_x < 10d"8" and g1_diff_y >= 0 and g1_diff_y < 10d"18" and g1_rgb /= "110011") then
							rgb <= g1_rgb;
					elsif(grad_diff_x >= 0 and grad_diff_x < 10d"8" and g2_diff_y >= 0 and g2_diff_y < 10d"18" and g2_rgb /= "110011") then
							rgb <= g2_rgb;
					elsif(grad_diff_x >= 0 and grad_diff_x < 10d"8" and g3_diff_y >= 0 and g3_diff_y < 10d"18" and g3_rgb /= "110011") then
							rgb <= g3_rgb; 
					else
							rgb <= inGameBackgroundRGB;
					end if;
				elsif(grad_diff_x >= 0 and grad_diff_x < 10d"8" and g1_diff_y >= 0 and g1_diff_y < 10d"18" and g1_rgb /= "110011") then
						rgb <= g1_rgb;
				elsif(grad_diff_x >= 0 and grad_diff_x < 10d"8" and g2_diff_y >= 0 and g2_diff_y < 10d"18" and g2_rgb /= "110011") then
						rgb <= g2_rgb;
				elsif(grad_diff_x >= 0 and grad_diff_x < 10d"8" and g3_diff_y >= 0 and g3_diff_y < 10d"18" and g3_rgb /= "110011") then
						rgb <= g3_rgb;
				else
					rgb <= inGameBackgroundRGB;
				end if;
			elsif (valid = '1' and state = "00") then 
				if(row > 220 and row < 267 and column > 414 and column < 441 and start_jacques_rgb /= "110011") then
					rgb <= start_jacques_rgb;
				--elsif(row > 220 and row < 267 and column > 360 and column < 387 and crouch1_rgb /= "110011") then
					--rgb <= crouch1_rgb;
				--elsif(row > 220 and row < 267 and column > 306 and column < 333 and crouch2_rgb /= "110011") then
					--rgb <= crouch2_rgb;
				--elsif(row > 220 and row < 267 and column > 252 and column < 279 and crouch3_rgb /= "110011") then
					--rgb <= crouch3_rgb;
				elsif(row > 220 and row < 267 and column > 198 and column < 225 and crouchFinal_rgb /= "110011") then
					rgb <= crouchFinal_rgb;
				else
					rgb <= start_background_rgb;
				end if;
			else
				rgb <= "000000";
			end if;
		end if;
	end process;
		--row_right <= unsigned(jacques_y) - 10d"5";
		--column_right <= unsigned(jacques_x) + 10d"5";
end;
			
			-- constants: a combined row and column for our offscreen read processes, and callibrations for the right side of our dot
			