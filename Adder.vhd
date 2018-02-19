library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder is
    Port ( switches : in  STD_LOGIC_VECTOR (7 downto 0);
           LEDs : out  STD_LOGIC_VECTOR (7 downto 0);
			  anodes : out STD_LOGIC_VECTOR (3 downto 0);
			  segments : out STD_LOGIC_VECTOR (6 downto 0);
			  decimal : out STD_LOGIC;
			  clk : in STD_LOGIC);
end Adder;

architecture Behavioral of Adder is
	signal bcd_result : STD_LOGIC_VECTOR(5 downto 0);
	signal x : STD_LOGIC_VECTOR(3 downto 0);
	signal y : STD_LOGIC_VECTOR(3 downto 0);
	signal carry : STD_LOGIC_VECTOR(3 downto 0);
	signal result : STD_LOGIC_VECTOR(4 downto 0);
	signal counter : STD_LOGIC_VECTOR(18 downto 0) := (others => '0');
begin
	decimal <= '1';
	LEDs <= "000" & result;
	x <= switches(3 downto 0);
	y <= switches(7 downto 4);
	
	result(0) <= x(0) XOR y(0);
	carry(0) <= x(0) AND y(0);
	
	result(1) <= x(1) XOR y(1) XOR carry(0);
	carry(1) <= (x(1) AND y(1)) OR (carry(0) AND (x(1) OR y(1)));
	
	result(2) <= x(2) XOR y(2) XOR carry(1);
	carry(2) <= (x(2) AND y(2)) OR (carry(1) AND (x(2) OR y(2)));
	
	result(3) <= x(3) XOR y(3) XOR carry(2);
	carry(3) <= (x(3) AND y(3)) OR (carry(2) AND (x(3) OR y(3)));
	
	result(4) <= carry(3);
	
	bcd : entity BinaryToBCD port map(
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
			if counter(18) = '0' then
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
			else
				anodes <= "1101";
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
		end process;
			
end Behavioral;