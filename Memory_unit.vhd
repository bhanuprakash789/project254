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

type regarray is array(65535 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
signal Memory: regarray:=(
	0 => x"0078", -- 0000 000 001 111 000 ADD
	1 => x"005a", -- 0000 000 001 011 010 ADC
	2 => x"106f", -- 0001 000 001 101 111 ADI
	3 => x"2068", -- 0010 000 001 101 000 NDU
	4 => x"2072", -- 0010 000 001 110 010 NDC
	5 => x"2051", -- 0010 000 001 010 001 NDZ
	6 => x"31e5", -- 0011 000 111 100 101 LHI
	7 => x"41c5", -- 0100 000 111 000 101 LW
	8 => x"41e0", -- 0100 000 111 100 000 LW
	9 => x"51c4", -- 0101 000 111 000 100 SW stores reg 0 into memory 6
	10 => x"42c4", -- 0100 001 011 000 100 LW loads memory 6 into reg 1
	11 => x"6000", -- 0110 000 000 000 000 load all registers from mem(0) to mem(7)
	12 => x"7000", -- 0110 000 000 000 000 store all
	13 => x"0000", -- 0000 000 000 000 000 addition
	14 => x"6c00", -- 0110 110 000 000 000 load all
	15 => x"c040", -- 1100 000 001 000 000  BEQ (not equal case)
	16 => x"1c00", -- 0001 110 000 000 000 ADI (add 0 to reg 6 and store in reg 0)
	17 => x"c183", -- 1100 000 110 000 011 BEQ (equal case)
	20 => x"8003", -- 1000 000 000 000 011 JAL (store 20 in reg 0 and jump to memory address 23)
	21 => x"0002", 
	23 => x"81fe", -- 1000 000 111 111 110 JAL (store 23 in reg 0 and jump to memory address 21 - nehative immediate)
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