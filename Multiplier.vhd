library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplier is
    Port ( switches : in  STD_LOGIC_VECTOR (7 downto 0);
           LEDs : out  STD_LOGIC_VECTOR (7 downto 0);
			  anodes : out STD_LOGIC_VECTOR (3 downto 0);
			  segments : out STD_LOGIC_VECTOR (6 downto 0);
			  decimal : out STD_LOGIC;
			  clk : in STD_LOGIC);
end Multiplier;

architecture Behavioral of Multiplier is
	signal op_1, op_2, op_3, op_4, and_1, and_2, and_3, and_4 : std_logic_vector(7 downto 0);
	signal mid_result_1, mid_result_2, result : std_logic_vector(7 downto 0);
	signal bcd_result : std_logic_vector(9 downto 0);
	signal counter : std_logic_vector(18 downto 0);
begin
	LEDs <= result;
	decimal <= '1';
	
	and_1(0) <= switches(0) AND switches(4);
	and_1(1) <= switches(1) AND switches(4);
	and_1(2) <= switches(2) AND switches(4);
	and_1(3) <= switches(3) AND switches(4);
	
	and_2(0) <= switches(0) AND switches(5);
	and_2(1) <= switches(1) AND switches(5);
	and_2(2) <= switches(2) AND switches(5);
	and_2(3) <= switches(3) AND switches(5);
	
	and_3(0) <= switches(0) AND switches(6);
	and_3(1) <= switches(1) AND switches(6);
	and_3(2) <= switches(2) AND switches(6);
	and_3(3) <= switches(3) AND switches(6);
	
	and_4(0) <= switches(0) AND switches(7);
	and_4(1) <= switches(1) AND switches(7);
	and_4(2) <= switches(2) AND switches(7);
	and_4(3) <= switches(3) AND switches(7);

	op_1 <= "0000" & and_1(3 downto 0);
	op_2 <= "000" & and_2(3 downto 0) & '0';
	op_3 <= "00" & and_3(3 downto 0) & "00";
	op_4 <= '0' & and_4(3 downto 0) & "000";
	
	mid_result_1 <= op_1 + op_2;
	mid_result_2 <= op_3 + op_4;
	result <= mid_result_1 + mid_result_2;
	
	bcd : entity BinaryToBCD_mul port map(
		result => result,
		bcd_result => bcd_result
		);
		
	clk_proc: process(clk)
		begin
			if rising_edge(clk) then
				counter <= counter + 1;
			end if;
		end process;
		
	display_proc: process(counter, bcd_result)
		begin
			if counter(18 downto 17) = "00" then
				anodes <= "1110";
				CASE bcd_result(3 downto 0) IS
					WHEN "0000" => 
					segments <= "1000000";
					WHEN "0001" =>
					segments <= "1111001";
					WHEN "0010" =>
					segments <= "0100100";
					WHEN "0011" =>
					segments <= "0110000";
					WHEN "0100" =>
					segments <= "0011001";
					WHEN "0101" =>
					segments <= "0010010";
					WHEN "0110" =>
					segments <= "0000010";
					WHEN "0111" =>
					segments <= "1111000";
					WHEN "1000" =>
					segments <= "0000000";
					WHEN "1001" =>
					segments <= "0010000";
					WHEN others =>
					segments <= "1111111";
				END CASE;
			elsif (counter(18 downto 17) = "01") AND ((bcd_result(9 downto 8) /= "00") OR NOT(bcd_result(7 downto 4) = "0000" AND bcd_result(9 downto 8) = "00")) then
				anodes <= "1101";
				CASE bcd_result(7 downto 4) IS
					WHEN "0000" => 
					segments <= "1000000";
					WHEN "0001" =>
					segments <= "1111001";
					WHEN "0010" =>
					segments <= "0100100";
					WHEN "0011" =>
					segments <= "0110000";
					WHEN "0100" =>
					segments <= "0011001";
					WHEN "0101" =>
					segments <= "0010010";
					WHEN "0110" =>
					segments <= "0000010";
					WHEN "0111" =>
					segments <= "1111000";
					WHEN "1000" =>
					segments <= "0000000";
					WHEN "1001" =>
					segments <= "0010000";
					WHEN others =>
					segments <= "1111111";
				END CASE;
			elsif counter(18 downto 17) = "10" then
				anodes <= "1011";
				CASE bcd_result(9 downto 8) IS
					WHEN "01" =>
					segments <= "1111001";
					WHEN "10" =>
					segments <= "0100100";
					WHEN "11" =>
					segments <= "0110000";
					WHEN others =>
					segments <= "1111111";
				END CASE;
			else
				anodes <= "1111";
				segments <= "1111111";
			end if;
		end process;

	
end Behavioral;

