library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BinaryToBCD_mul is
    Port ( result : in  STD_LOGIC_VECTOR (7 downto 0);
           bcd_result : out STD_LOGIC_VECTOR(9 downto 0));
end BinaryToBCD_mul;

architecture Behavioral of BinaryToBCD_mul is
	signal mid_result_1, mid_result_2, mid_result_3, mid_result_4, mid_result_5, mid_result_6, mid_result_7 : STD_LOGIC_VECTOR (3 downto 0);
begin

	bcd_proc: process(result, mid_result_1, mid_result_2, mid_result_3, mid_result_4, mid_result_5, mid_result_6, mid_result_7)
	begin
		if ("0" & result(7 downto 5) > 4) then
			mid_result_1(3 downto 0) <= ("0" & result(7 downto 5)) + "11";
		else
			mid_result_1(3 downto 0) <= "0" & result(7 downto 5);
		end if;
		
		if (mid_result_1(2 downto 0) & result(4) > 4) then
			mid_result_2(3 downto 0) <= (mid_result_1(2 downto 0) & result(4)) + "11";
		else
			mid_result_2(3 downto 0) <= mid_result_1(2 downto 0) & result(4);
		end if;
		
		if (mid_result_2(2 downto 0) & result(3) > 4) then
			mid_result_3(3 downto 0) <= (mid_result_2(2 downto 0) & result(3)) + "11";
		else
			mid_result_3(3 downto 0) <= mid_result_2(2 downto 0) & result(3);
		end if;
		
		if (mid_result_3(2 downto 0) & result(2) > 4) then
			mid_result_4(3 downto 0) <= (mid_result_3(2 downto 0) & result(2)) + "11";
		else
			mid_result_4(3 downto 0) <= mid_result_3(2 downto 0) & result(2);
		end if;
		
		if ("0" & mid_result_1(3) & mid_result_2(3) & mid_result_3(3) > 4) then
			mid_result_5(3 downto 0) <= ("0" & mid_result_1(3) & mid_result_2(3) & mid_result_3(3)) + "11";
		else
			mid_result_5(3 downto 0) <= "0" & mid_result_1(3) & mid_result_2(3) & mid_result_3(3);
		end if;
		
		if (mid_result_4(2 downto 0) & result(1) > 4) then
			mid_result_6(3 downto 0) <= (mid_result_4(2 downto 0) & result(1)) + "11";
		else
			mid_result_6(3 downto 0) <= mid_result_4(2 downto 0) & result(1);
		end if;
		
		if (mid_result_5(2 downto 0) & mid_result_4(3) > 4) then
			mid_result_7(3 downto 0) <= (mid_result_5(2 downto 0) & mid_result_4(3)) + "11";
		else
			mid_result_7(3 downto 0) <= mid_result_5(2 downto 0) & mid_result_4(3);
		end if;
		
		bcd_result <= mid_result_5(3) & mid_result_7 & mid_result_6 & result(0);
		
	end process;

end Behavioral;


