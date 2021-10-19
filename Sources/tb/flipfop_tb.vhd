library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity flipflop_tb is


end flipflop_tb;

architecture arch of flipflop_tb is

	constant T_clk        : time      := 100 ns;
  	signal clk_tb         : std_logic := '0';
  	signal reset_tb       : std_logic := '1';
  	constant N_tb         : integer   := 8;
	signal inputData_tb   : std_logic_vector(N_tb-1 downto 0) := "00000000";
	signal outputData_tb  : std_logic_vector(N_tb-1 downto 0);

	component flipflop is
		generic(Nbit : integer := 4);
		port (
			clk         : in  std_logic;
			reset       : in  std_logic;
			inputData   : in  std_logic_vector(N-1 downto 0);
			outputData  : out std_logic_vector(N-1 downto 0)
		);
	end component flipflop;

begin

	clk_tb <= not(clk_tb) after T_clk/2;
	reset_tb <= '0' after 2*T_clk;

	zeroInsertionSamplerComponent: flipflop generic map (Nbit => N_tb) port map (clk => clk_tb, reset => reset_tb, inputData => inputData_tb, outputData => outputData_tb);

	process(clk_tb, inputData_tb) begin
		if (clk_tb'event and clk_tb = '1') then
			inputData_tb <= std_logic_vector( unsigned(inputData_tb) + 1 );
		end if;
	end process;

end arch;
