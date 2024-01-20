--library IEEE;
--use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;




--entity kingJacROM is

  --port(

  --clk : in std_logic;
  --x_address: in unsigned(4 downto 0); -- 0-8, will require an “x_diff” input when mapped
  --y_address: in unsigned(5 downto 0); -- 0-32 will require a “y_diff” input when mapped
  --rgb : out std_logic_vector(5 downto 0)

      --);

--end kingJacROM;


--architecture synth of kingJacROM is

--signal xy_address : std_logic_vector(11 downto 0); -- combined 8-bit address (5 y bits, 3 x bits)- easiest for program generation.
--signal temp : std_logic_vector(1 downto 0); -- to reduce file/bit size (optimization trial)

--begin

   --process (clk) begin

--if rising_edge(clk) then

--case xy_address is






--end case;

--end if;

   --end process;

   --xy_address <= std_logic_vector(y_address) & std_logic_vector(x_address);
   
--end;