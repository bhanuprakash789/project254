library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

-- since The Memory is asynchronous read, there is no read signal, but you can use it based on your preference.
-- this memory gives 16 Bit data in one clock cycle, so edit the file to your requirement.

entity Memory_unit is 
	port (address,Mem_datain: in std_logic_vector(15 downto 0);
	clk,mem_write: in std_logic;
	Mem_dataout: out std_logic_vector(15 downto 0));
end entity;

architecture Form of Memory_unit is 

type regarray is array(31 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
signal Memory: regarray:=(
	0 => x"0078", -- 0000 000 001 111 000 ADD
	1 => x"005b", -- 0000 000 001 011 010 ADC
	2 => x"106f", -- 0001 000 001 101 111 ADI
	3 => x"2068", -- 0010 000 001 101 000 NDU
	4 => x"2070", -- 0010 000 001 110 010 NDC
	7 => x"2050", -- 0010 000 001 010 001 NDZ
	8 => x"2060", -- 0010 000 001 100 000
	9 => x"0a32",
	10 => x"0982",
	11 => x"012a",
	12 => x"0caa",
	13 => x"0044",
	14 => x"0202",
	16 => x"01c0",
	18 => x"0000",
	19 => x"0000",
	20 => x"0014",
	21 => x"0002",
	23 => x"0016",
	24 => x"0fff",
	26 => x"0fff",
	27 => x"0012",
	others => x"0000");
	
-- 1 => x"3000",2 => x"1057",3 => x"4442",4 => x"0458",5 => x"2460",6 => x"2921",7 => x"1111",8 => x"2921",9 => x"58c0",10 => x"7292",11 => x"6e60",12 => x"c040",13 => x"127f",14 => x"c241",16 => x"9440",22 => x"83f5",25 => x"ffed",others => "0000000000000000");

-- you can use the above mentioned way to initialise the memory with the instructions and the data as required to test your processor
begin
-- reading
Mem_dataout <= Memory(conv_integer(address));
--writing
--Mem_write:
process (mem_write,Mem_datain,address,clk)
	begin
	if(mem_write = '1') then
		if(rising_edge(clk)) then
			Memory(conv_integer(address)) <= Mem_datain;
		end if;
	end if;
	end process;
end Form;