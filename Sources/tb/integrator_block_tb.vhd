library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity integrator_block_tb is


end integrator_block_tb;

architecture arch of integrator_block_tb is

	constant T_clk        : time      := 100 ns;
  	signal clk_tb         : std_logic := '0';
  	signal reset_tb       : std_logic := '1';
  	constant N_tb         : integer   := 8;
	signal inputData_tb   : std_logic_vector(N_tb-1 downto 0) := "00000000";
	signal outputData_tb  : std_logic_vector(N_tb downto 0);

	component integrator_block is
		generic(Nbit : integer; Mbit : integer);
		port (
			clk     : in   std_logic;
			reset   : in   std_logic;
			input   : in   std_logic_vector(Nbit-1 downto 0);
			output	: out  std_logic_vector(Mbit-1 downto 0)
		);
	end component integrator_block;

begin

	clk_tb <= not(clk_tb) after T_clk/2;
	reset_tb <= '0' after 2*T_clk;

	integratorBlockComponent: integrator_block generic map (Nbit => N_tb, Mbit => N_tb+1) port map (clk => clk_tb, reset => reset_tb, input => inputData_tb, output => outputData_tb);

	process(clk_tb, inputData_tb) begin
		if (clk_tb'event and clk_tb = '1') then
			inputData_tb <= std_logic_vector( unsigned(inputData_tb) + 1 );
		end if;
	end process;

end arch;
