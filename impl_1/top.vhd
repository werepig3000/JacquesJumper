library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity toplevel is
	port(
		clk : in std_logic;
		output : out std_logic;
		HSYNC : out std_logic;
		VSYNC : out std_logic;
		rgb : out std_logic_vector (5 downto 0);
		
		inputController : in std_logic;
		inputController_2 : in std_logic;
		ControllerLatch : out std_logic;
		NESCLK : out std_logic;
		--OutputController : out std_logic_vector(7 downto 0);
		random_output_test : out std_logic;
		score_out_test : out std_logic_vector (3 downto 0);
		init_out : out std_logic;
		dead_out: out std_logic;
		game_state_out : out std_logic_vector (1 downto 0)
	);
end;

architecture synth of toplevel is

component LEZZGO is
    port(
        ref_clk_i: in std_logic;
        rst_n_i: in std_logic;
        outcore_o: out std_logic;
        outglobal_o: out std_logic
    );
end component;

component shift8 is
	port(
		input : in std_logic;
		latch : out std_logic;
		outputClk : out std_logic;
		result : out std_logic_vector(7 downto 0);
		data_out : out std_logic;
		resultFinal : out std_logic_vector(7 downto 0)
	);
end component;

--component shift8_2 is
	--port(
		--input : in std_logic;
		--latch : out std_logic;
		--outputClk : out std_logic;
		--result : out std_logic_vector(7 downto 0);
		--data_out : out std_logic;
		--resultFinal : out std_logic_vector(7 downto 0)
	--);
--end component;

component vga is
	port(
		clk_in : in std_logic;
		hsync : out std_logic := '1';
		vsync : out std_logic := '1';
		valid : out std_logic;
		row : out unsigned (9 downto 0);
		col : out unsigned (9 downto 0);
		sixty_hz : out std_logic
	);
end component;

component pgen is 
	port(
		row, column : in unsigned (9 downto 0);
		valid : in std_logic;
		clkIN : in std_logic;
		rgb : out std_logic_vector (5 downto 0);
		conchIn : in std_logic_vector (7 downto 0);
		sixty_hz : in std_logic;
		state : in std_logic_vector (1 downto 0);
		
		jacques_x : in std_logic_vector (9 downto 0);
		jacques_y : in std_logic_vector (9 downto 0);
		
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
		
		mode_select : out std_logic;
		char_select : out std_logic;
		
		pgen_on_plat : in std_logic;
		pgen_jac_x_vel : in signed (9 downto 0);
		
		ones_rgb : in std_logic_vector (5 downto 0);
		tens_rgb : in std_logic_vector (5 downto 0);
		hundreds_rgb : in std_logic_vector (5 downto 0);
		
		jump_size : in signed (3 downto 0)

	);
end component;

component physics is
	generic(
		gravity : signed (2 downto 0) := 3d"1";
		friction : signed (2 downto 0) := 3d"1";
		run_accel : signed (2 downto 0) := 3d"1";
		
		reset_x : std_logic_vector(9 downto 0) := 10d"315";
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
end component;

--component physics_2 is
	--generic(
		--gravity : signed (2 downto 0) := 3d"1";
		--friction : signed (2 downto 0) := 3d"1";
		--run_accel : signed (2 downto 0) := 3d"1";
		
		--reset_x : std_logic_vector(9 downto 0) := 10d"315";
		--reset_y : std_logic_vector (9 downto 0) := 10d"10";
		
		--jac_terminal : signed (9 downto 0) := "1111110000";
		--jacques_width : unsigned (9 downto 0) := 10d"28";
		--jacques_height : unsigned (9 downto 0) := 10d"47";
		
		--platform_offset : signed (9 downto 0) := 10d"60";
		--platform_width : unsigned(9 downto 0) := 10d"50";
		
		--collision_leniency : signed (9 downto 0) := 10d"12"
		--);
		
	--port(
		--conchIn_2 : in std_logic_vector (7 downto 0);
		--physClk : in std_logic;
		
		--jac_x : out std_logic_vector (9 downto 0);
		--jac_y : out std_logic_vector (9 downto 0);
		
		--plat_x : in std_logic_vector (9 downto 0);
		--plat_x1 : in std_logic_vector (9 downto 0);
		--plat_x2 : in std_logic_vector (9 downto 0);
		--plat_x3 : in std_logic_vector (9 downto 0);
		--plat_x4 : in std_logic_vector (9 downto 0);
		--plat_x5 : in std_logic_vector (9 downto 0);
		--plat_x6 : in std_logic_vector (9 downto 0);
		--plat_x7 : in std_logic_vector (9 downto 0);
		
		
		--plat_y : out std_logic_vector (9 downto 0);
		--plat_y1 : out std_logic_vector (9 downto 0);
		--plat_y2 : out std_logic_vector (9 downto 0);
		--plat_y3 : out std_logic_vector (9 downto 0);
		--plat_y4 : out std_logic_vector (9 downto 0);
		--plat_y5 : out std_logic_vector (9 downto 0);
		--plat_y6 : out std_logic_vector (9 downto 0);
		--plat_y7 : out std_logic_vector (9 downto 0);

		--on_plat_out : out std_logic;
		--jac_x_vel_out : out signed(9 downto 0);
		--dead_out : out std_logic;
		--lives_out : out std_logic_vector (2 downto 0);
		--init_out : out std_logic;
		
		--state: in std_logic_vector(1 downto 0)
	--);
--end component;

component RNG is
	port(
		clkRNG : in std_logic;
		plat_rand_x : out std_logic_vector(9 downto 0)
	);
end component;


component platform is
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
end component;


-- Game State ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
component game_state is
	port(
		sixtyClk : in std_logic;
		conchIn : in std_logic_vector (7 downto 0);
		
		
		mode_select : in std_logic;
		char_select : in std_logic;
		start2 : in std_logic;
		dead : in std_logic;
		max_time : in std_logic;
		
		
		state : out std_logic_vector (1 downto 0)
	
	);
end component;

-- Score ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
component score is
	port (
		physClk : in std_logic;
		game_start : in std_logic_vector (1 downto 0);

		onesDigit: out std_logic_vector (3 downto 0);
		tensDigit : out std_logic_vector (3 downto 0);
		hundredsDigit : out std_logic_vector (3 downto 0);
		
		scoreCounter_out : out std_logic;

        ultra_win : out std_logic
	);
end component;




signal row : unsigned (9 downto 0);
signal column : unsigned (9 downto 0);
signal valid : std_logic;

signal pll_to_vga : std_logic;
signal sixtyClk : std_logic;

signal conchData : std_logic_vector (7 downto 0);
signal conchData_2 : std_logic_vector (7 downto 0);

signal jac_phys_to_gen_x : std_logic_vector (9 downto 0);
signal jac_phys_to_gen_y : std_logic_vector (9 downto 0);

signal jac_2_phys_to_gen_x : std_logic_vector (9 downto 0);
signal jac_2_phys_to_gen_y : std_logic_vector (9 downto 0);

signal plat_phys_to_gen_y : std_logic_vector (9 downto 0);
signal plat1_phys_to_gen_y : std_logic_vector (9 downto 0);
signal plat2_phys_to_gen_y : std_logic_vector (9 downto 0);
signal plat3_phys_to_gen_y : std_logic_vector (9 downto 0);
signal plat4_phys_to_gen_y : std_logic_vector (9 downto 0);
signal plat5_phys_to_gen_y : std_logic_vector (9 downto 0);
signal plat6_phys_to_gen_y : std_logic_vector (9 downto 0);
signal plat7_phys_to_gen_y : std_logic_vector (9 downto 0);

signal platform_rand_x : std_logic_vector(9 downto 0);

signal plat1_x : std_logic_vector(9 downto 0);
signal plat2_x : std_logic_vector(9 downto 0);
signal plat3_x : std_logic_vector(9 downto 0);
signal plat4_x : std_logic_vector(9 downto 0);
signal plat5_x : std_logic_vector(9 downto 0);
signal plat6_x : std_logic_vector(9 downto 0);
signal plat7_x : std_logic_vector(9 downto 0);

signal jump_size_to_pgen : signed(3 downto 0);

signal pgen_on_plat : std_logic;

signal pgen_on_plat_2 : std_logic;

signal pgen_jac_x_vel : signed(9 downto 0);
signal pgen_jac_2_x_vel : signed(9 downto 0);

-- GAME STATE::::::
signal state : std_logic_vector (1 downto 0);
signal dead: std_logic;
signal lives_out : std_logic_vector (2 downto 0);

-- Temps
signal tempMode : std_logic := '1';
signal tempChar : std_logic := '1';
signal init : std_logic;

--score
signal onesDigit_sig : std_logic_vector (3 downto 0);
signal hundredsDigit : std_logic_vector (3 downto 0);
signal tensDigit : std_logic_vector (3 downto 0);
signal ultra_win_to_state : std_logic;

-- draw score
signal ones_to_pgen : std_logic_vector (5 downto 0);
signal tens_to_pgen : std_logic_vector (5 downto 0);
signal hundreds_to_pgen : std_logic_vector (5 downto 0);




begin
	io_pll : LEZZGO port map (ref_clk_i => clk, rst_n_i => '1', outcore_o => output, outglobal_o => pll_to_vga);
	sync : vga port map (clk_in => pll_to_vga, row => row, col => column, hsync => HSYNC, vsync => VSYNC, valid => valid, sixty_hz => sixtyClk);
	c_map : shift8 port map (input => inputController, resultFinal => conchData, outputClk => NESCLK, latch => ControllerLatch);
	--c_map_2 : shift8 port map (input => inputController_2, resultFinal => conchData_2, outputClk => NESCLK, latch => ControllerLatch);
	
	pgen_map : pgen port map (row => row, column => column, valid => valid, clkIn => pll_to_vga, rgb => rgb, conchIn => conchData,
							  sixty_hz => sixtyClk, state => state, jacques_x => jac_phys_to_gen_x, jacques_y => jac_phys_to_gen_y,
							  plat_y => plat_phys_to_gen_y, plat1_y => plat1_phys_to_gen_y, plat2_y => plat2_phys_to_gen_y,
							  plat3_y => plat3_phys_to_gen_y, plat4_y => plat4_phys_to_gen_y, plat5_y => plat5_phys_to_gen_y,
							  plat6_y => plat6_phys_to_gen_y, plat7_y => plat7_phys_to_gen_y, plat1_x => plat1_x,
							  plat2_x => plat2_x, plat3_x => plat3_x, plat4_x => plat4_x, plat5_x => plat5_x, plat6_x => plat6_x,
							  plat7_x => plat7_x, pgen_on_plat => pgen_on_plat, pgen_jac_x_vel => pgen_jac_x_vel,
							  ones_rgb => ones_to_pgen, tens_rgb => tens_to_pgen, hundreds_rgb => hundreds_to_pgen, jump_size => jump_size_to_pgen);
							  
							  
	phys_map : physics generic map (gravity => 3d"1",
								   friction => 3d"1",
								   run_accel => 3d"1",
		
									reset_x  => 10d"315",
									reset_y => 10d"10",
		
									jac_terminal => "1111110000",
									jacques_width =>  10d"28",
									jacques_height => 10d"47",
		
									platform_offset => 10d"60",
									platform_width => 10d"50",
		
									collision_leniency => 10d"12"
									)
	
				port map (conchIn => conchData, physClk => sixtyClk, jac_x => jac_phys_to_gen_x, 
								 jac_y => jac_phys_to_gen_y, plat_y => plat_phys_to_gen_y, on_plat_out => pgen_on_plat, jac_x_vel_out => pgen_jac_x_vel,
								 plat_y1 => plat1_phys_to_gen_y, plat_y2 => plat2_phys_to_gen_y, plat_y3 => plat3_phys_to_gen_y,
								 plat_y4 => plat4_phys_to_gen_y, plat_y5 => plat5_phys_to_gen_y, plat_y6 => plat6_phys_to_gen_y,
								 plat_y7 => plat7_phys_to_gen_y, plat_x1 => plat1_x, plat_x2 => plat2_x, plat_x3 => plat3_x,
								 plat_x4 => plat4_x, plat_x5 => plat5_x, plat_x6 => plat6_x, plat_x7 => plat7_x,
								 dead_out => dead, lives_out => lives_out, state => state, init_out => init, jumpSize => jump_size_to_pgen);
	
	--phys_map_2 : physics port map (conchIn => conchData_2, physClk => sixtyClk, jac_x => jac_phys_to_gen_x, 
								 --jac_y => jac_phys_to_gen_y, on_plat_out => pgen_on_plat_2, jac_x_vel_out => pgen_jac_2_x_vel
								  --);

	rng_map : RNG port map(plat_rand_x => platform_rand_x, clkRNG => sixtyClk);
	plat_map : platform port map(platform_rand_x => platform_rand_x, clkPlat => sixtyClk, 
								 y_platform_1 => plat1_phys_to_gen_y, y_platform_2 => plat2_phys_to_gen_y,
								 y_platform_3 => plat3_phys_to_gen_y, y_platform_4 => plat4_phys_to_gen_y, 
								 y_platform_5 => plat5_phys_to_gen_y, y_platform_6 => plat6_phys_to_gen_y,
								 y_platform_7 => plat7_phys_to_gen_y, x_platform_1 => plat1_x, x_platform_2 => plat2_x,
								 x_platform_3 => plat3_x,  x_platform_4 => plat4_x, x_platform_5 => plat5_x,
								 x_platform_6 => plat6_x,  x_platform_7 => plat7_x);
	
	game_states : game_state port map(sixtyClk => sixtyClk, conchIn => conchData, mode_select => '1', char_select => '1', start2 => '0', dead => dead, max_time => '0', state => state);
	
	--score_map : score port map(physClk => sixtyClk, game_start => state, onesDigit => onesDigit_sig, tensDigit => tensDigit, hundredsDigit => hundredsDigit, ultra_win => ultra_win_to_state);

	--drawScore_map : draw_score port map (sixtyClk => sixtyClk, row => row, column => column, onesDigit => onesDigit_sig, tensDigit => tensDigit, hundredsDigit => hundredsDigit,
										 --ones_rgb => ones_to_pgen, tens_rgb => tens_to_pgen, hundreds_rgb => hundreds_to_pgen, state => state);
	
	

	--end draw_score;
	
--physClk : in std_logic;
--game_start : in std_logic;

--onesDigit: out std_logic_vector (3 downto 0);
		--tensDigit : out std_logic_vector (3 downto 0);
		--hundredsDigit : out std_logic_vector (3 downto 0);

        --ultra_win : out std_logic
	
	
	-- inputs : input => signal
	--outputs : output => signal
	random_output_test <= dead;
	score_out_test <= onesDigit_sig;
	init_out <= init;
	game_state_out <= state;
	dead_out <= dead;
	--Outputcontroller <= platform_rand_x(7 downto 0);
	
end;
