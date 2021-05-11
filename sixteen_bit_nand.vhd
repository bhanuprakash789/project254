library ieee;
use ieee.std_logic_1164.all;

entity sixteen_bit_nand is
	port(A, B: in std_logic_vector(15 downto 0);
		 S: out std_logic_vector(15 downto 0); 
		 Cout: out std_logic);
end entity sixteen_bit_nand;

architecture struct of sixteen_bit_nand is

	begin
		Cout <= '0';
		S <= A nand B;

end architecture struct;