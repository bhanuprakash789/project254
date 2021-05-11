library ieee, std;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity testbench is
end entity;

architecture arc of testbench is

	component IITB_PROC is 
	port (clk, reset : in std_logic;
--			register0,register1,register2,register3,register4,register5,register6,
			register0 : out std_logic_vector(15 downto 0));
	end component;
	signal clk, reset: std_logic;
	signal register0 : std_logic_vector(15 downto 0);
--	,register1,register2,register3,register4,register5,register6,register7
begin
	dut_instance: IITB_PROC
		port map (clk => clk, reset => reset, register0 => register0);
--	, register1 => register1, register2 => register2, register3 => register3, register4 => register4, register5 => register5, register6 => register6, register7 => register7
	process
	begin
		reset <= '1';
		clk <= '0';
		wait for 5ps;
		clk <= '1';
		reset <= '0';
		wait for 5ps;
--		while true loop
--			clk <= '0';
--			wait for 5ps;
--			clk <= '1';
--			wait for 5ps;
--		end loop;
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
		
		clk <= '0';	wait for 50 ps;
		clk <= '1';	wait for 50 ps;
	wait;
	end process;
end architecture;