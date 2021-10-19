library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity zeroInsertionSampler is

	generic(Nbit : integer);
	port (
		enabler     : in  std_logic;
		inputData   : in  std_logic_vector(Nbit-1 downto 0);
		outputData  : out std_logic_vector(Nbit-1 downto 0)
	);

end zeroInsertionSampler;

architecture arch of zeroInsertionSampler is

begin

	outputData <= inputData when enabler = '1' else (others => '0');

end arch;
