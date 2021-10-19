library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity cic_filter_tb is
end cic_filter_tb;

architecture arch of cic_filter_tb is

	constant T_clk        : time      := 25 ns;
  	signal clk_tb         : std_logic := '0';
  	signal reset_tb       : std_logic := '1';
  	constant N_tb         : integer   := 16;
	signal inputData_tb   : std_logic_vector(N_tb-1 downto 0) := "0000000000000000";
	signal outputData_tb  : std_logic_vector(N_tb-1 downto 0);

	component cic_filter is
		generic(
			Nbit : integer
		);
		port (
			clk     : in   std_logic;
			reset   : in   std_logic;
			input   : in   std_logic_vector(Nbit-1 downto 0);
			output  : out  std_logic_vector(Nbit-1 downto 0)
		);
	end component cic_filter;

	type lut_t is array(natural range <>) of integer;
	constant lut : lut_t(0 to 94) := (
		0, 398, 734, 954, 1023, 931, 691, 343, -60, -454, -775, -975, -1021, -905, -647, -287, 119, 505, 812, 991, 1013, 875, 598, 228, -179, -558, -848, -1005, -1003, -843, -550, -170, 237, 606, 879, 1014, 988, 807, 498, 110, -295, -654, -909, -1021, -972, -770, -445, -51, 351, 698, 934, 1023, 951, 728, 390, -10, -408, -741, -958, -1024, -928, -685, -335, 68, 461, 780, 977, 1019, 900, 639, 277, -129, -514, -819, -994, -1012, -871, -592, -220, 187, 564, 852, 1006, 1000, 837, 541, 160, -246, -614, -885, -1016, -987, -802, -491, -102
	);

	signal index   : integer := 0;
	signal counter : integer := 0;

begin

	clk_tb <= not(clk_tb) after T_clk/2;
	reset_tb <= '0' after 4*T_clk;

	cicFilterComponent: cic_filter generic map (Nbit => N_tb) port map (clk => clk_tb, reset => reset_tb, input => inputData_tb, output => outputData_tb);

	process(clk_tb, inputData_tb) begin
		if (clk_tb'event and clk_tb = '1') then
			if (reset_tb = '1') then
				index <= 0;
				counter <= 0;
				inputData_tb <= (others => '0');
			else
				if(counter = 4) then
					inputData_tb <= std_logic_vector( to_signed(lut(index),inputData_tb'length) );
					if(index < 94) then
						index <= index + 1;
					else
						index <= 0;
					end if;
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;

end arch;
