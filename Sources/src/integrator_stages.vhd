library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity integrator_stages is

	generic(Nbit : integer);
	port (
		clk     : in   std_logic;
		reset   : in   std_logic;
		input   : in   std_logic_vector(Nbit+3-1 downto 0);
		output	: out  std_logic_vector(Nbit+6-1 downto 0)
	);

end integrator_stages;

architecture integrator_stages_arch1 of integrator_stages is

	component integrator_block is
		generic(Nbit : integer; Mbit : integer);
		port (
			clk     : in   std_logic;
			reset   : in   std_logic;
			input   : in   std_logic_vector(Nbit-1 downto 0);
			output	: out  std_logic_vector(Mbit-1 downto 0)
		);
	end component integrator_block;

	signal inside0 : std_logic_vector (Nbit+3-1 downto 0);
	signal inside1 : std_logic_vector (Nbit+4-1 downto 0);
	signal inside2 : std_logic_vector (Nbit+5-1 downto 0);

begin

	integratorBlockComponent0: integrator_block generic map(Nbit => Nbit+3, Mbit => Nbit+3) port map (clk, reset, input, inside0);
	integratorBlockComponent1: integrator_block generic map(Nbit => Nbit+3, Mbit => Nbit+4) port map (clk, reset, inside0, inside1);
	integratorBlockComponent2: integrator_block generic map(Nbit => Nbit+4, Mbit => Nbit+5) port map (clk, reset, inside1, inside2);
	integratorBlockComponent3: integrator_block generic map(Nbit => Nbit+5, Mbit => Nbit+6) port map (clk, reset, inside2, output);

end integrator_stages_arch1;
