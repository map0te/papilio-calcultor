library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BinaryToBCD is
    Port ( result : in  STD_LOGIC_VECTOR (4 downto 0);
           bcd_result : out STD_LOGIC_VECTOR(5 downto 0));
end BinaryToBCD;

architecture Behavioral of BinaryToBCD is
signal mid_result  : STD_LOGIC_VECTOR (3 downto 0);
begin
bcd_proc: process(result,mid_result)
begin
	if ("0" & result(4 downto 2) > 4) then
		mid_result(3 downto 0) <= ("0" & result(4 downto 2)) + "11";
	else
		mid_result(3 downto 0) <= "0" & result(4 downto 2);
	end if;
	
	if (mid_result(2 downto 0) & result(1) > 4) then
		bcd_result(5 downto 0) <= (mid_result & result(1) + "11") & result(0);
	else
		bcd_result(5 downto 0) <= mid_result & result(1 downto 0);
	end if;
end process;

end Behavioral;
