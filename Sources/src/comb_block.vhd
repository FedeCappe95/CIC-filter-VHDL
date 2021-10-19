library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comb_block is

	generic(Nbit : integer);
	port (
		clk          : in   std_logic;
		comb_enabler : in   std_logic;
		reset        : in   std_logic;
		input        : in   std_logic_vector(Nbit-1 downto 0);
		output       : out  std_logic_vector(Nbit downto 0)
	);

end comb_block;


architecture comb_block_arch1 of comb_block is

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

	signal storedData  : std_logic_vector(Nbit-1 downto 0);

begin


	-- GEN: generate
	fpfp:  flipflop generic map(Nbit => Nbit) port map (clk, comb_enabler, reset, input, storedData);
	-- end generate GEN

	--output <= std_logic_vector( to_signed(    to_integer(signed(input)) - to_integer(signed(storedData))     , Nbit+1) );
	output <= std_logic_vector( resize(signed(input),Nbit+1) - resize(signed(storedData),Nbit+1) );


end comb_block_arch1;
