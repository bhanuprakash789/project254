library ieee;
use ieee.std_logic_1164.all;

entity Mux_4 is
	port(I0, I1, I2, I3: in std_logic;
			S: out std_logic;
			sel0, sel1: in  std_logic);
end entity Mux_4;

architecture struct of Mux_4 is
	component Mux_2 is
		port (I0, I1: in std_logic; S: out std_logic;
				sel: in  std_logic);
	end component Mux_2;
	signal  s1, s2 : std_logic;
begin
	m1: Mux_2
		port map (
			I0 => I0, I1 => I1, sel => sel0, S => s1
		);
	m2: Mux_2
		port map (
			I0 => I2, I1 => I3, sel => sel0, S => s2
		);
	m3: Mux_2
		port map (
			I0 => s1, I1 => s2, sel => sel1, S => S
		);
	
end architecture struct;