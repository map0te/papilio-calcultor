library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Calculator is
	port( switches : in std_logic_vector(7 downto 0);
			LEDs : out std_logic_vector(7 downto 0);
			anodes : out std_logic_vector(3 downto 0);
			segments : out std_logic_vector(6 downto 0);
			stick : in std_logic_vector(3 downto 0);
			decimal : out std_logic;
			clk : in std_logic
		);
end Calculator;

architecture Behavioral of Calculator is
	signal add_LEDs, sub_LEDs, mul_LEDs, div_LEDs : std_logic_vector(7 downto 0);
	signal add_anodes, sub_anodes, mul_anodes, div_anodes : std_logic_vector(3 downto 0);
	signal add_segments, sub_segments, mul_segments, div_segments : std_logic_vector(6 downto 0);
	signal add_decimal, sub_decimal, mul_decimal, div_decimal : std_logic;
begin
	add : entity Adder port map(
		switches => switches,
		LEDs => add_LEDs,
		anodes => add_anodes,
		segments => add_segments,
		decimal => add_decimal,
		clk => clk
	);
	
	sub : entity Subtractor port map(
		switches => switches,
		LEDs => sub_LEDs,
		anodes => sub_anodes,
		segments => sub_segments,
		decimal => sub_decimal,
		clk => clk
	);
	
	mul : entity Multiplier port map(
		switches => switches,
		LEDs => mul_LEDs,
		anodes => mul_anodes,
		segments => mul_segments,
		decimal => mul_decimal,
		clk => clk
	);
	
	div : entity Divider port map(
		switches => switches,
		LEDs => div_LEDs,
		anodes => div_anodes,
		segments => div_segments,
		decimal => div_decimal,
		clk => clk
	);

	stick_select: process(stick, add_LEDs, add_anodes, add_segments, add_decimal, sub_LEDs, 
		sub_anodes, sub_segments, sub_decimal, mul_LEDs, mul_anodes, mul_segments, mul_decimal,
		div_LEDs, div_anodes, div_segments, div_decimal)
		begin
			if (stick(3) = '0') and ((stick(1) and stick(2) and stick(0)) = '1') then
				LEDs <= add_LEDs;
				anodes <= add_anodes;
				segments <= add_segments;
				decimal <= add_decimal;
			elsif (stick(0) = '0') and ((stick(1) and stick(2) and stick(3)) = '1') then
				LEDs <= sub_LEDs;
				anodes <= sub_anodes;
				segments <= sub_segments;
				decimal <= sub_decimal;
			elsif (stick(2) = '0') and ((stick(1) and stick(3) and stick(0)) = '1') then
				LEDs <= mul_LEDs;
				anodes <= mul_anodes;
				segments <= mul_segments;
				decimal <= mul_decimal;
			elsif (stick(1) = '0') and ((stick(2) and stick(3) and stick(0)) = '1') then
				LEDs <= div_LEDs;
				anodes <= div_anodes;
				segments <= div_segments;
				decimal <= div_decimal;
			else
				anodes <= "1111";
				LEDs <= "00000000";
				segments <= "1111111";
				decimal <= '1';
			end if;
		end process;

end Behavioral;

