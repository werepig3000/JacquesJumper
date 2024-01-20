--library IEEE;
--use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;
--use std.textio.all;

	--entity draw_score is
		--port(
			
			--sixtyclk : in std_logic;
			--row, column : in unsigned (9 downto 0);
		--	onesDigit: in std_logic_vector (3 downto 0);
			--tensDigit : in std_logic_vector (3 downto 0);
			--hundredsDigit : in std_logic_vector (3 downto 0);
			
			--state : in std_logic_vector (1 downto 0);
			
			--ones_rgb : out std_logic_vector (5 downto 0);
			--tens_rgb : out std_logic_vector (5 downto 0);
			--hundreds_rgb : out std_logic_vector (5 downto 0);
			--onesDigit : in std_logic_vector (3 downto 0);
			--tensDigit : in std_logic_vector (3 downto 0);
			--hundredsDigit : in std_logic_vector (3 downto 0) 
		
		--);
	
	--end draw_score;
	
	
--architecture synth of draw_score is

 --instantiate number ROMS

--component ZeroROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

--component OneROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

--component TwoROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

--component ThreeROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

--component FourROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

--component FiveROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;


--component SixROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0) 

      --);
--end component;

--component SevenROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

--component EightROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

--component NineROM is

	--port(

		  --clk : in std_logic;
		  --x_address: in unsigned(3 downto 0); 
		  --y_address: in unsigned(3 downto 0); 
		  --rgb : out std_logic_vector(5 downto 0)

      --);
--end component;

 --SIGNALS

--signal draw_test_diff_x : unsigned (9 downto 0);
--signal draw_test_diff_y : unsigned (9 downto 0);

--signal zeroRGB : std_logic_vector (5 downto 0);
--signal oneRGB : std_logic_vector (5 downto 0);
--signal twoRGB : std_logic_vector (5 downto 0);
--signal threeRGB : std_logic_vector (5 downto 0);
--signal fourRGB : std_logic_vector (5 downto 0);
--signal fiveRGB : std_logic_vector (5 downto 0);
--signal sixRGB : std_logic_vector (5 downto 0);
--signal sevenRGB : std_logic_vector (5 downto 0);
--signal eightRGB : std_logic_vector (5 downto 0);
--signal nineRGB : std_logic_vector (5 downto 0);




--signal scoreCounter : std_logic_vector (6 downto 0);
	
--begin


--draw_test_diff_x <= column - 0;
--draw_test_diff_y <= row - 0;

--Draw_zero : zeroROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => zeroRGB);
--Draw_one : oneROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => oneRGB);
--Draw_two : twoROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => twoRGB);
--Draw_three : threeROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => threeRGB);
--Draw_four : fourROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => fourRGB);
--Draw_five : fiveROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => fiveRGB);
--Draw_six : sixROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => sixRGB);
--Draw_seven : sevenROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => sevenRGB);
--Draw_eight : eightROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => eightRGB);
--Draw_nine : nineROM port map(clk => sixtyclk, x_address => draw_test_diff_x(3 downto 0), y_address => draw_test_diff_y(3 downto 0), rgb => nineRGB);


--process(sixtyclk) begin
	--if (rising_edge(sixtyclk) and state = "01") then--            scoreCounter <= std_logic_vector(unsigned(scoreCounter) + 7d"1");

            --if (scoreCounter(6) and scoreCounter(5) and scoreCounter(4) and scoreCounter(3) and scoreCounter(2)) then
                --scoreCounter <= 7d"0";
                --onesDigit <= std_logic_vector(unsigned(onesDigit) +  4d"1");
            --end if;

            --if (unsigned(onesDigit) = 4d"10") then
                --tensDigit <= std_logic_vector(unsigned(tensDigit) + 4d"1");
                --onesDigit <= 4d"0";
            --end if;

            --if (unsigned(tensDigit) = 4d"10") then
                --hundredsDigit <= std_logic_vector(unsigned(hundredsDigit) + 4d"1");
                --onesDigit <= 4d"0";
            --end if;

--end if;
--end process;

	--ones_rgb <= zeroRGB when unsigned(onesDigit) = 4d"0" else
				--oneRGB when unsigned(onesDigit) = 4d"1" else
				--twoRGB when unsigned(onesDigit) = 4d"2" else
				--threeRGB when unsigned(onesDigit) = 4d"3" else
				--fourRGB when unsigned(onesDigit) = 4d"4" else
				--fiveRGB when unsigned(onesDigit) = 4d"5" else
				--sixRGB when unsigned(onesDigit) = 4d"6" else
				--sevenRGB when unsigned(onesDigit) = 4d"7" else
				--eightRGB when unsigned(onesDigit) = 4d"8" else
				--nineRGB when unsigned(onesDigit) = 4d"9" else
				--"110011";
	--tens_rgb <= zeroRGB when unsigned(tensDigit) = 4d"0" else
				--oneRGB when unsigned(tensDigit) = 4d"1" else
				--twoRGB when unsigned(tensDigit) = 4d"2" else
				--threeRGB when unsigned(tensDigit) = 4d"3" else
				--fourRGB when unsigned(tensDigit) = 4d"4" else
				--fiveRGB when unsigned(tensDigit) = 4d"5" else
				--sixRGB when unsigned(tensDigit) = 4d"6" else
				--sevenRGB when unsigned(tensDigit) = 4d"7" else
				--eightRGB when unsigned(tensDigit) = 4d"8" else
				--nineRGB when unsigned(tensDigit) = 4d"9" else
				--"110011";
	--hundreds_rgb <= zeroRGB when unsigned(hundredsDigit) = 4d"0" else
				--oneRGB when unsigned(hundredsDigit) = 4d"1" else
				--twoRGB when unsigned(hundredsDigit) = 4d"2" else
				--threeRGB when unsigned(hundredsDigit) = 4d"3" else
				--fourRGB when unsigned(hundredsDigit) = 4d"4" else
				--fiveRGB when unsigned(hundredsDigit) = 4d"5" else
				--sixRGB when unsigned(hundredsDigit) = 4d"6" else
				--sevenRGB when unsigned(hundredsDigit) = 4d"7" else
				--eightRGB when unsigned(hundredsDigit) = 4d"8" else
				--nineRGB when unsigned(hundredsDigit) = 4d"9" else
				--"110011";
--end;
	
	