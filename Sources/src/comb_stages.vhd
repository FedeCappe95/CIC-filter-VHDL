library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comb_stages is

	generic(Nbit : integer);
	port (
		clk          : in   std_logic;
		comb_enabler : in   std_logic;
		reset        : in   std_logic;
		input        : in   std_logic_vector(Nbit-1 downto 0);
		output       : out  std_logic_vector(Nbit + 4 -2 downto 0)
	);

end comb_stages;

architecture comb_stages_arch1 of comb_stages is

	component comb_block is
		generic(Nbit : integer);
		port (
			clk          : in   std_logic;
			comb_enabler : in   std_logic;
			reset        : in   std_logic;
			input        : in   std_logic_vector(Nbit-1 downto 0);
			output       : out  std_logic_vector(Nbit downto 0)
		);
	end component comb_block;

	signal inside0 : std_logic_vector (Nbit downto 0);
	signal inside1 : std_logic_vector (Nbit+1 downto 0);
	signal inside2 : std_logic_vector (Nbit+2 downto 0);
	signal inside3 : std_logic_vector (Nbit+3 downto 0);

begin

	c_b0: comb_block generic map(Nbit => Nbit)   port map (clk, comb_enabler, reset, input, inside0);
	c_b1: comb_block generic map(Nbit => Nbit+1) port map (clk, comb_enabler, reset, inside0, inside1);
	c_b2: comb_block generic map(Nbit => Nbit+2) port map (clk, comb_enabler, reset, inside1, inside2);
	c_b3: comb_block generic map(Nbit => Nbit+3) port map (clk, comb_enabler, reset, inside2, inside3);
	output <= inside3(Nbit+2 downto 0);

end comb_stages_arch1;
