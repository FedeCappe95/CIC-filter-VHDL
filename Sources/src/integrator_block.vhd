library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity integrator_block is

	generic(Nbit : integer; Mbit : integer);
	port (
		clk     : in   std_logic;
		reset   : in   std_logic;
		input   : in   std_logic_vector(Nbit-1 downto 0);
		output	: out  std_logic_vector(Mbit-1 downto 0)
	);

end integrator_block;


architecture integrator_arch1 of integrator_block is

	component flipflop
		generic(Nbit : integer := 4);
		port (
			clk         : in  std_logic;
			enabler     : in  std_logic;
			reset       : in  std_logic;
			inputData   : in  std_logic_vector(Nbit-1 downto 0);
			outputData  : out std_logic_vector(Nbit-1 downto 0)
		);
	end component flipflop;

	signal savedData : std_logic_vector(Mbit-1 downto 0);
	signal outputRW  : std_logic_vector(Mbit-1 downto 0);

begin

	-- outputRW <= std_logic_vector(   to_signed(to_integer(signed(input))+to_integer(signed(savedData)),     outputRW'length) );
	outputRW <= std_logic_vector( resize(signed(input),Mbit) + resize(signed(savedData),Mbit) );
	output <= outputRW;
	flipflopComponent: flipflop generic map (Nbit => Mbit) port map (clk => clk, enabler => '1', reset => reset, inputData => outputRW, outputData => savedData);

end integrator_arch1;
