library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Divider is
    Port ( switches : in  STD_LOGIC_VECTOR (7 downto 0);
           LEDs : out  STD_LOGIC_VECTOR (7 downto 0);
			  anodes : out STD_LOGIC_VECTOR (3 downto 0);
			  segments : out STD_LOGIC_VECTOR (6 downto 0);
			  decimal : out STD_LOGIC;
			  clk : in STD_LOGIC);
end Divider;

architecture Behavioral of Divider is
	signal x : std_logic_vector(3 downto 0);
	signal y : std_logic_vector(4 downto 0);
	signal mid_sub_1, mid_sub_2, mid_sub_3, mid_sub_4, mid_sub_5, mid_sub_6, mid_sub_7, mid_sub_8,
		mid_sub_9, mid_sub_10, mid_x_1, mid_x_2, mid_x_3, mid_x_4, mid_x_5, mid_x_6, mid_x_7, mid_x_8, 
		mid_x_9, mid_x_10, mid_x_11, mid_sub_11: std_logic_vector(4 downto 0);
	signal bcd_result : std_logic_vector(5 downto 0);
	signal fp_bcd_result : std_logic_vector(7 downto 0);
	signal counter : std_logic_vector(18 downto 0) := (others => '0');
	signal result : std_logic_vector(11 downto 0);
	signal fp_result : std_logic_vector(7 downto 0);
	signal int_result : std_logic_vector(4 downto 0);
begin
	
	x <= switches(7 downto 4);
	y <= '0' & switches(3 downto 0);
	LEDs <= "00000000";
	
	mid_x_1 <= "0000" & x(3);
	mid_x_2 <= mid_sub_1(3 downto 0) & x(2);
	mid_x_3 <= mid_sub_2(3 downto 0) & x(1);
	mid_x_4 <= mid_sub_3(3 downto 0) & x(0);
	mid_x_5 <= mid_sub_4(3 downto 0) & '0';
	mid_x_6 <= mid_sub_5(3 downto 0) & '0';
	mid_x_7 <= mid_sub_6(3 downto 0) & '0';
	mid_x_8 <= mid_sub_7(3 downto 0) & '0';
	mid_x_9 <= mid_sub_8(3 downto 0) & '0';
	mid_x_10 <= mid_sub_9(3 downto 0) & '0';
	mid_x_11 <= mid_sub_10(3 downto 0) & '0';
	
	int_result <= '0' & result(11 downto 8);
	fp_result <= result(7 downto 0);
	
	iter_1: entity sub_cell port map(
		x => mid_x_1,
		y => y,
		sub_result => mid_sub_1,
		result => result(11)
	);
	
	iter_2: entity sub_cell port map(
		x => mid_x_2,
		y => y,
		sub_result => mid_sub_2,
		result => result(10)
	);
	
	iter_3: entity sub_cell port map(
		x => mid_x_3,
		y => y,
		sub_result => mid_sub_3,
		result => result(9)
	);
	
	iter_4: entity sub_cell port map(
		x => mid_x_4,
		y => y,
		sub_result => mid_sub_4,
		result => result(8)
	);
	
	iter_5: entity sub_cell port map(
		x => mid_x_5,
		y => y,
		sub_result => mid_sub_5,
		result => result(7)
	);
	
	iter_6: entity sub_cell port map(
		x => mid_x_6,
		y => y,
		sub_result => mid_sub_6,
		result => result(6)
	);
	
	iter_7: entity sub_cell port map(
		x => mid_x_7,
		y => y,
		sub_result => mid_sub_7,
		result => result(5)
	);
	
	iter_8: entity sub_cell port map(
		x => mid_x_8,
		y => y,
		sub_result => mid_sub_8,
		result => result(4)
	);
	
	iter_9: entity sub_cell port map(
		x => mid_x_9,
		y => y,
		sub_result => mid_sub_9,
		result => result(3)
	);
	
	iter_10: entity sub_cell port map(
		x => mid_x_10,
		y => y,
		sub_result => mid_sub_10,
		result => result(2)
	);
	
	iter_11: entity sub_cell port map(
		x => mid_x_11,
		y => y,
		sub_result => mid_sub_11,
		result => result(1)
	);
	
	iter_12: process(mid_sub_11, y)
	begin
		if mid_sub_11 > y then
			result(0) <= '1';
		else
			result(0) <= '0';
		end if;
	end process;
	
	
	bcd: entity BinaryToBCD port map(
		result => int_result,
		bcd_result => bcd_result
		);
		
	bcd_fp: entity FpBinaryToBCD port map(
		result => fp_result,
		bcd_result => fp_bcd_result
		);

	clk_proc: process(clk)
		begin
			if rising_edge(clk) then
				counter <= counter + 1;
			end if;
		end process;
		
	display_proc: process(switches, counter, bcd_result, fp_bcd_result)
		begin
			if switches(3 downto 0) /= "0000" then
				if counter(18 downto 17) = "00" then
					decimal <= '0';
					anodes <= "1011";
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
				elsif counter(18 downto 17) = "01" then
					decimal <= '1';
					anodes <= "1101";
					CASE fp_bcd_result(7 downto 4) IS
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
					decimal <= '1';
					anodes <= "1110";
					CASE fp_bcd_result(3 downto 0) IS
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
				else
					anodes <= "0111";
					decimal <= '1';
					CASE bcd_result(5 downto 4) IS
						WHEN "01" =>
						segments <= "1111001";
						WHEN "10" =>
						segments <= "0100100";
						WHEN "11" =>
						segments <= "0110000";
						WHEN others =>
						segments <= "1111111";
					END CASE;
				end if;
			else
				anodes <= "1110";
				decimal <= '1';
				segments <= "0000110";
			end if;
		end process;
			
	
end Behavioral;

