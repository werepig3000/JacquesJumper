library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity game_state is
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
end game_state;


architecture synth of game_state is

signal s : std_logic_vector(1 downto 0) := "00";
signal start1 : std_logic := '0'; ----- first start signal

begin

state <= "00" when dead else "01" when conchIn(4);


--process (sixtyClk) is
--begin
--if rising_edge(sixtyClk) then

  --s(1) <= ((not s(1)) and s(0) and (not dead) and max_time) or ((not s(1)) and s(0) and dead and (not max_time)) or ((not s(1)) and s(0) and dead and max_time) or (s(1) and (not s(0)) and (not start2)) or (s(1) and s(0) and (not start2));
  --s(0) <= ((not s(1)) and (not s(0)) and (mode_select) and (char_select) and (start1)) or ((not s(1)) and s(0) and (not dead) and (not max_time)) or ((not s(1)) and s(0) and (not dead) and max_time) or ((not s(1)) and s(0) and dead and max_time) or (s(1) and s(0) and (not start2)); 
--end if;

--state <= s;
--start1 <= '1' when char_select = '1' and conchIn(4) = '1' else '0';


--end process;

end;
	