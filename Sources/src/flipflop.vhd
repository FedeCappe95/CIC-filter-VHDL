library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity flipflop is

	generic(Nbit : integer := 4);
	port (
		clk         : in  std_logic;
		enabler     : in  std_logic;
		reset       : in  std_logic;
		inputData   : in  std_logic_vector(Nbit-1 downto 0);
		outputData  : out std_logic_vector(Nbit-1 downto 0)
	);

end flipflop;

architecture arch of flipflop is

begin

	registerProcess: process(clk,reset,inputData) begin
		if (clk'event and clk = '1') then
			if (reset = '1') then
				outputData <= (others => '0');
			else
				if (enabler = '1') then
					outputData <= inputData;
				end if;
			end if;
		end if;
	end process registerProcess;

end arch;
