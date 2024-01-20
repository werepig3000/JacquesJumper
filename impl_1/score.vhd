library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity score is
	port (
		physClk : in std_logic;
		game_start : in std_logic_vector (1 downto 0);

		onesDigit: out std_logic_vector (3 downto 0);
		tensDigit : out std_logic_vector (3 downto 0);
		hundredsDigit : out std_logic_vector (3 downto 0);
		
		scoreCounter_out : out std_logic;

        ultra_win : out std_logic
	);
end score;

architecture synth of score is

signal scoreCounter : unsigned (6 downto 0);


begin

	process (physClk) begin
		if (rising_edge(physClk) and (game_start = "01")) then
            scoreCounter <= scoreCounter + 7d"1";

            if (scoreCounter(6) and scoreCounter(5) and scoreCounter(4) and scoreCounter(3) and scoreCounter(2)) then 
                scoreCounter <= 7d"0";
                onesDigit <= std_logic_vector(unsigned(onesDigit) +  4d"1");
            end if;

            if (unsigned(onesDigit) = 4d"10") then
                tensDigit <= std_logic_vector(unsigned(tensDigit) + 4d"1");
                onesDigit <= 4d"0";
            end if;

            if (unsigned(tensDigit) = 4d"10") then
                hundredsDigit <= std_logic_vector(unsigned(hundredsDigit) + 4d"1");
                onesDigit <= 4d"0";
            end if;

            if (unsigned(hundredsDigit) = 4d"10") then
                ultra_win <= '1';
            end if; 
        end if;
    end process;
	scoreCounter_out <= scoreCounter(6) and scoreCounter(5) and scoreCounter(4) and scoreCounter(3) and scoreCounter(2);
end;

--55 is 01
--aa is 10
--00 is 00