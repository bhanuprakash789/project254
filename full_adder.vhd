library ieee;
use ieee.std_logic_1164.all;

entity full_adder  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end entity full_adder;

architecture struct of full_adder is

	begin
		S <= (A xor B) xor Cin;
		Cout <= (A and B) or (Cin and (A xor B));
		
end architecture struct;