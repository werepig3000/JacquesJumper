library IEEE;
use IEEE.std_logic_1164.all;

entity RNG is
  port(
	clkRNG : in std_logic;
	plat_rand_x : out std_logic_vector(9 downto 0)
  );
end RNG;

architecture synth of RNG is
signal r : std_logic_vector (3 downto 0);
signal big_boi : std_logic_vector (19 downto 0);

begin
	
	plat_rand_x <= 10d"5" when r = "0001"
	else 10d"47" when r = "0010"
	else 10d"89" when r = "0011"
	else 10d"131" when r = "0100"
	else 10d"173" when r = "0101"
	else 10d"215" when r = "0110"
	else 10d"257" when r = "0111"
	else 10d"299" when r = "1000"
	else 10d"341" when r = "1001"
	else 10d"383" when r = "1010"
	else 10d"425" when r = "1011"
	else 10d"467" when r = "1100"
	else 10d"509" when r = "1101"
	else 10d"551" when r = "1110"
	else 10d"593" when r = "1111"
	else 10d"640";
	
	
  process (clkRNG) begin
        if rising_edge(clkRNG) then
            --r(0) <= r(1) or (not (r(0) or r(1) or r(2) or r(3)));
            --r(2) <= r(0) xor r(3);
            --r(1) <= r(2);
            --r(3) <= r(0);
			big_boi(0) <= big_boi(1) or (not ((big_boi(0) or big_boi(1) or big_boi(2)) or big_boi(3) or big_boi(4) or big_boi(5) or big_boi(6) or big_boi(7) or big_boi(8) or big_boi(9) or big_boi(10) or big_boi(11) or big_boi(12) or big_boi(13) or big_boi(14) or big_boi(15) or big_boi(16) or big_boi(17) or big_boi(18)));
			big_boi(1) <= big_boi(2);
			big_boi(2) <= big_boi(19) xor big_boi(16);
			big_boi(3) <= big_boi(4);
			big_boi(4) <= big_boi(5);
			big_boi(5) <= big_boi(6);
			big_boi(6) <= big_boi(7);
			big_boi(7) <= big_boi(8);
			big_boi(8) <= big_boi(9);
			big_boi(9) <= big_boi(10);
			big_boi(10) <= big_boi(11);
			big_boi(11) <= big_boi(12);
			big_boi(12) <= big_boi(13);
			big_boi(13) <= big_boi(14);
			big_boi(14) <= big_boi(15);
			big_boi(15) <= big_boi(16);
			big_boi(16) <= big_boi(17);
			big_boi(17) <= big_boi(18);
			big_boi(18) <= big_boi(19);
			big_boi(19) <= big_Boi(0);
			
			
		end if;
  end process;
	r <= big_boi(4) & big_boi(0) & big_boi(6) & big_boi(3); -- oUR BIRTHDAYS <3
end;
		
	