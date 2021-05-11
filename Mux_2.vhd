library ieee;
use ieee.std_logic_1164.all;

entity Mux_2 is
    port (I0, I1: in std_logic; S: out std_logic;
			sel: in  std_logic);
end entity Mux_2;

architecture struct of Mux_2 is
	
begin
	S <= (I0 and not(sel)) or (I1 and sel); 
end struct;