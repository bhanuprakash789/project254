library ieee;
use ieee.std_logic_1164.all;

entity Mux_vector is
	port(I0, I1, I2, I3: in std_logic_vector(16 downto 0);
			S: out std_logic_vector(16 downto 0);
			sel0, sel1: in  std_logic);
end entity Mux_vector;

architecture struct of Mux_vector is
	component Mux_4 is
		port(I0, I1, I2, I3: in std_logic;
			S: out std_logic;
			sel0, sel1: in  std_logic);
	end component Mux_4;
begin
	m1: Mux_4
		port map (
			I0 => I0(0), I1 => I1(0), I2 => I2(0), I3 => I3(0),
			sel0 => sel0, sel1 => sel1, S => S(0)
		);
	m2: Mux_4
		port map (
			I0 => I0(1), I1 => I1(1), I2 => I2(1), I3 => I3(1),
			sel0 => sel0, sel1 => sel1, S => S(1)
		);
	m3: Mux_4
		port map (
			I0 => I0(2), I1 => I1(2), I2 => I2(2), I3 => I3(2),
			sel0 => sel0, sel1 => sel1, S => S(2)
		);
	m4: Mux_4
		port map (
			I0 => I0(3), I1 => I1(3), I2 => I2(3), I3 => I3(3),
			sel0 => sel0, sel1 => sel1, S => S(3)
		);
	m5: Mux_4
		port map (
			I0 => I0(4), I1 => I1(4), I2 => I2(4), I3 => I3(4),
			sel0 => sel0, sel1 => sel1, S => S(4)
		);
	m6: Mux_4
		port map (
			I0 => I0(5), I1 => I1(5), I2 => I2(5), I3 => I3(5),
			sel0 => sel0, sel1 => sel1, S => S(5)
		);
	m7: Mux_4
		port map (
			I0 => I0(6), I1 => I1(6), I2 => I2(6), I3 => I3(6),
			sel0 => sel0, sel1 => sel1, S => S(6)
		);
	m8: Mux_4
		port map (
			I0 => I0(7), I1 => I1(7), I2 => I2(7), I3 => I3(7),
			sel0 => sel0, sel1 => sel1, S => S(7)
		);
	m9: Mux_4
		port map (
			I0 => I0(8), I1 => I1(8), I2 => I2(8), I3 => I3(8),
			sel0 => sel0, sel1 => sel1, S => S(8)
		);
	m10: Mux_4
		port map (
			I0 => I0(9), I1 => I1(9), I2 => I2(9), I3 => I3(9),
			sel0 => sel0, sel1 => sel1, S => S(9)
		);
	m11: Mux_4
		port map (
			I0 => I0(10), I1 => I1(10), I2 => I2(10), I3 => I3(10),
			sel0 => sel0, sel1 => sel1, S => S(10)
		);
	m12: Mux_4
		port map (
			I0 => I0(11), I1 => I1(11), I2 => I2(11), I3 => I3(11),
			sel0 => sel0, sel1 => sel1, S => S(11)
		);
	m13: Mux_4
		port map (
			I0 => I0(12), I1 => I1(12), I2 => I2(12), I3 => I3(12),
			sel0 => sel0, sel1 => sel1, S => S(12)
		);
	m14: Mux_4
		port map (
			I0 => I0(13), I1 => I1(13), I2 => I2(13), I3 => I3(13),
			sel0 => sel0, sel1 => sel1, S => S(13)
		);
	m15: Mux_4
		port map (
			I0 => I0(14), I1 => I1(14), I2 => I2(14), I3 => I3(14),
			sel0 => sel0, sel1 => sel1, S => S(14)
		);
	m16: Mux_4
		port map (
			I0 => I0(15), I1 => I1(15), I2 => I2(15), I3 => I3(15),
			sel0 => sel0, sel1 => sel1, S => S(15)
		);
	m17: Mux_4
		port map (
			I0 => I0(16), I1 => I1(16), I2 => I2(16), I3 => I3(16),
			sel0 => sel0, sel1 => sel1, S => S(16)
		);

end architecture struct;