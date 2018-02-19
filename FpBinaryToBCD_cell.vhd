library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FpBinaryToBCD_cell is
	Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
          result : out STD_LOGIC_VECTOR(3 downto 0));
end FpBinaryToBCD_cell;

architecture Behavioral of FpBinaryToBCD_cell is

begin
	cell: process(input)
	begin
		if input > 7 then
			result <= input - "0011";
		else
			result <= input;
		end if;
	end process;
end Behavioral;

