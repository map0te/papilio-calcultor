library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FpBinaryToBCD is
	Port ( result : in  STD_LOGIC_VECTOR (7 downto 0);
          bcd_result : out STD_LOGIC_VECTOR(7 downto 0));
end FpBinaryToBCD;

architecture Behavioral of FpBinaryToBCD is
	signal mid_result_1, mid_result_2, mid_result_3, mid_result_4, 
		mid_result_5, mid_result_6, mid_result_7, mid_result_8,
		mid_result_9, mid_result_10, mid_result_11, mid_result_12, 
		mid_result_13, mid_result_14, mid_result_15: STD_LOGIC_VECTOR (3 downto 0);
	signal input_1, input_2, input_3, input_4, input_5, input_6, 
		input_7, input_8, input_9, input_10, input_11, input_12,
		input_13, input_14, input_15: STD_LOGIC_VECTOR (3 downto 0);
begin
	input_1 <= result(0) & "000";
	input_2 <= result(1) & mid_result_1(3 downto 1);
	input_3 <= mid_result_1(0) & "000";
	input_4 <= result(2) & mid_result_2(3 downto 1);
	input_5 <= mid_result_2(0) & mid_result_3(3 downto 1);
	input_6 <= result(3) & mid_result_4(3 downto 1);
	input_7 <= mid_result_4(0) & mid_result_5(3 downto 1);
	input_8 <= result(4) & mid_result_6(3 downto 1);
	input_9 <= mid_result_6(0) & mid_result_7(3 downto 1);
	input_10 <= result(5) & mid_result_8(3 downto 1);
	input_11 <= mid_result_8(0) & mid_result_9(3 downto 1);
	input_12 <= result(6) & mid_result_10(3 downto 1);
	input_13 <= mid_result_10(0) & mid_result_11(3 downto 1);
	input_14 <= result(7) & mid_result_12(3 downto 1);
	input_15 <= mid_result_12(0) & mid_result_13(3 downto 1);
	
	cell_1: entity FpBinaryToBCD_cell port map(
		input => input_1,
		result => mid_result_1
	);
	
	cell_2: entity FpBinaryToBCD_cell port map(
		input => input_2,
		result => mid_result_2
	);
	
	cell_3: entity FpBinaryToBCD_cell port map(
		input => input_3,
		result => mid_result_3
	);
	
	cell_4: entity FpBinaryToBCD_cell port map(
		input => input_4,
		result => mid_result_4
	);
	
	cell_5: entity FpBinaryToBCD_cell port map(
		input => input_5,
		result => mid_result_5
	);

	cell_6: entity FpBinaryToBCD_cell port map(
		input => input_6,
		result => mid_result_6
	);
	
	cell_7: entity FpBinaryToBCD_cell port map(
		input => input_7,
		result => mid_result_7
	);
	
	cell_8: entity FpBinaryToBCD_cell port map(
		input => input_8,
		result => mid_result_8
	);
	
	cell_9: entity FpBinaryToBCD_cell port map(
		input => input_9,
		result => mid_result_9
	);
	
	cell_10: entity FpBinaryToBCD_cell port map(
		input => input_10,
		result => mid_result_10
	);
	
	cell_11: entity FpBinaryToBCD_cell port map(
		input => input_11,
		result => mid_result_11
	);
	
	cell_12: entity FpBinaryToBCD_cell port map(
		input => input_12,
		result => mid_result_12
	);
	
	cell_13: entity FpBinaryToBCD_cell port map(
		input => input_13,
		result => mid_result_13
	);
	
	cell_14: entity FpBinaryToBCD_cell port map(
		input => input_14,
		result => mid_result_14
	);
	
	cell_15: entity FpBinaryToBCD_cell port map(
		input => input_15,
		result => mid_result_15
	);
	
	bcd_result <= mid_result_14 & mid_result_15;
	
end Behavioral;

