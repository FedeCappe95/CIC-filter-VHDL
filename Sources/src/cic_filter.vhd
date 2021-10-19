library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cic_filter is

	generic(
		Nbit : integer := 16
	);
	port (
		clk     : in   std_logic;
		reset   : in   std_logic;
		input   : in   std_logic_vector(Nbit-1 downto 0);
		output  : out  std_logic_vector(Nbit-1 downto 0)
	);

end cic_filter;

architecture cic_filter_arch1 of cic_filter is

component comb_stages is
	generic(Nbit : integer);
	port (
		clk          : in   std_logic;
		comb_enabler : in   std_logic;
		reset        : in   std_logic;
		input        : in   std_logic_vector(Nbit-1 downto 0);
		output       : out  std_logic_vector(Nbit+4-2 downto 0)
	);
end component comb_stages;


component integrator_stages is
	generic(Nbit : integer);
	port (
		clk     : in   std_logic;
		reset   : in   std_logic;
		input   : in   std_logic_vector(Nbit+3-1 downto 0);
		output	: out  std_logic_vector(Nbit+6-1 downto 0)
	);
end component integrator_stages;


component zeroInsertionSampler is
	generic(Nbit : integer);
	port (
		enabler     : in  std_logic;
		inputData   : in  std_logic_vector(Nbit-1 downto 0);
		outputData  : out std_logic_vector(Nbit-1 downto 0)
	);
end component zeroInsertionSampler;

signal out_comb   : std_logic_vector (Nbit+2 downto 0);
signal out_z_i    : std_logic_vector (Nbit+2 downto 0);
signal out_integr : std_logic_vector (Nbit+5 downto 0);

signal comb_enabler : std_logic;
signal counter      : integer;


begin

	cicFilterProcess: process(clk, reset, counter, comb_enabler)
	begin

		if (clk'event and clk = '1') then
			if (reset = '1') then
				counter <= 0;
				comb_enabler <= '0';
			else
				if (counter = 3) then
					comb_enabler <= '1';
					counter <= 0;
				else
					comb_enabler <= '0';
					counter <= counter + 1;
				end if;
			end if;
		end if;

	end process cicFilterProcess;

	c_s: comb_stages generic map(Nbit => Nbit) port map (clk, comb_enabler, reset, input, out_comb);
	z_i: zeroInsertionSampler generic map(Nbit => Nbit+3) port map (comb_enabler, out_comb, out_z_i);
	i_s: integrator_stages generic map(Nbit => Nbit) port map (clk, reset, out_z_i, out_integr);

	output <= out_integr(Nbit+5 downto 6);

end cic_filter_arch1;
