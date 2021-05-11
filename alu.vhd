library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(A, B: in std_logic_vector(15 downto 0);
		 control: in std_logic;
		 carry, z: out std_logic;
		 out_alu: out std_logic_vector(15 downto 0));
end entity alu;

architecture struct of ALU is

	component sixteen_bit_adder is
		port(A, B: in std_logic_vector(15 downto 0);
		 S: out std_logic_vector(15 downto 0); 
		 Cout: out std_logic);
	end component sixteen_bit_adder;

	component sixteen_bit_nand is
		port(A, B: in std_logic_vector(15 downto 0);
		 S: out std_logic_vector(15 downto 0); 
		 Cout: out std_logic);
	end component sixteen_bit_nand;

	component Mux_vector is
		port(I0, I1, I2, I3: in std_logic_vector(16 downto 0);
			S: out std_logic_vector(16 downto 0);
			sel0, sel1: in  std_logic);
	end component Mux_vector;

	component zero_check is
		port(A: in std_logic_vector(15 downto 0);
			S: out std_logic);
	end component zero_check;


	signal s1, s2, s3, s4 : std_logic_vector(16 downto 0);
	signal s5 : std_logic_vector(15 downto 0);
begin
	add_instance: sixteen_bit_adder
		port map (
		 	A => A, B => B, S => s1(15 downto 0), Cout => s1(16)
		 ); 
	nand_instance: sixteen_bit_nand
		port map (
			A => A, B => B, S => s2(15 downto 0), Cout => s2(16)
		);

	Mux: Mux_vector
		port map (
			I0 => s1, I1 => s2, I2 => "00000000000000000", I3 => "00000000000000000", sel0 => control, 
			sel1 => '0', S => s4
		);

	s5 <= s4(15 downto 0);
	carry <= s4(16);
	out_alu <= s5;

	zero: zero_check
		port map (
			A => s5, S => z
		);


end architecture struct;