library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sub_cell is
	port(
		x : in std_logic_vector(4 downto 0);
		y : in std_logic_vector(4 downto 0);
		sub_result : out std_logic_vector(4 downto 0);
		result : out std_logic
	);
end sub_cell;

architecture Behavioral of sub_cell is

begin
	cell : process(x, y)
	begin
		if (x > y) OR (x = y) then
			sub_result(4 downto 0) <= x-y;
			result <= '1';
		else
			sub_result(4 downto 0) <= x;
			result <= '0';
		end if;
	end process;
end Behavioral;

