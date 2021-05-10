library ieee;
use ieee.std_logic_1164.all;

entity IITB_PROC is 
	port (clk, reset : in std_logic;
			O:  out std_logic_vector(15 downto 0);
			Done: out std_logic);
end entity

architecture Form of iitb_proc is 

	component alu is
	port (a, b: in std_logic_vector(15 downto 0);
		  control : in std_logic;
		  carry, z: out std_logic;
		  out_alu: out std_logic_vector(15 downto 0));
	end component alu;

	component rf_file is
	port (rf_a1, rf_a2, rf_a3: in std_logic_vector(2 downto 0);
		  rf_d3: in std_logic_vector(15 downto 0);
		  rf_d1, rf_d2: out std_logic_vector(15 downto 0);
		  rf_write_in, clk: in std_logic);
	end component rf_file;

	component memory_unit is
	port (address,Mem_datain: in std_logic_vector(15 downto 0); 
		  clk,write_signal: in std_logic;
		  Mem_dataout: out std_logic_vector(15 downto 0));
	end component memory_unit;

	component sign_extend_10 is
	port (inp: in std_logic_vector(5 downto 0); 
		   extended: out std_logic_vector(15 downto 0));
	end component sign_extend_10;

	component sign_extend_7 is
	port (inp: in std_logic_vector(8 downto 0); 
		   extended: out std_logic_vector(15 downto 0));
	end component sign_extend_7;
	
	
	
	type FSMState is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, 
		S17, S18, S);
	signal fsm_state: FSMState;
	
	signal instr_reg, instr_pointer: std_logic_vector(15 downto 0);
	signal mem_A, mem_Din, MEM_DOUT, ALU_A, ALU_B, ALU_O, RF_D1, RF_D2, RF_D3, SIGN_EXTENDER_10_OUTPUT, SIGN_EXTENDER_7_OUTPUT : std_logic_vector(15 downto 0);
	signal MEM_WRITING, ALU_C, ALU_Z, ALU_X, C_FLAG, Z_FLAG, RF_WRITING : std_logic;
	signal RF_A1, RF_A2, RF_A3 : std_logic_vector(2 downto 0);
	signal T1, T2, T3, T4, T5 : std_logic_vector(15 downto 0);
	signal ALU_CONTROL : std_logic;
	signal SIGN_EXTERNDER_10_INPUT : std_logic_vector(5 downto 0);
	signal SIGN_EXTERNDER_7_INPUT : std_logic_vector(8 downto 0);

	
	begin

		Memory : memory_unit port map (
			mem_A, mem_Din, clk, MEM_WRITE, MEM_DOUT
		);
		
		Arithmetic_Logical_Unit : alu port map (
			ALU_A, ALU_B, ALU_CONTROL, ALU_C, ALU_Z, ALU_O
		);

		Register_file : rf_file port map (
			RF_A1, RF_A2, RF_A3, RF_D3, RF_D1, RF_D2, RF_WRITE_IN, clk
		);

		SE10 : sign_extend_10 port map (
			SIGN_EXTERNDER_10_INPUT, SIGN_EXTENDER_10_OUTPUT
		);

		SE7 : sign_extend_7 port map (
			SIGN_EXTERNDER_7_INPUT, SIGN_EXTENDER_7_OUTPUT
		);
	

	
	process(clk)
	
	variable next_fsm_state_var : FSMState;
		
		variable PC, temp_T1, temp_T2, temp_T3, temp_T4, temp_T5, instr_reg_var : std_logic_vector(15 downto 0);
		variable TZ_TEMP, TC_TEMP : std_logic;
		variable count :integer;

		begin
		
		next_fsm_state_var :=  fsm_state;
		PC := instr_pointer;
		temp_T4 := T4;
		temp_T1 := T1;
		temp_T2 := T2;
		temp_T3 := T3;
		temp_T5 := T5;
		TZ_TEMP := Z_FLAG;
		TC_TEMP := C_FLAG;
		instr_reg_var := instr_reg;
	
	variable pc: std_logic_vector(15 downto 0);
	
	begin		
		
		if(rising_edge(clk)) then
				
			if (rst = '1') then
				pc <= x"0000";
				fsm_state <= S0;
			else
			
				case( fsm_state ) is
			
				when S0 =>
					MEM_WRITING<='0';
					RF_WRITING <= '0';
					MEM_A <= pc;
					instr_reg_var := MEM_DOUT;
					case (instr_reg(15 downto 12)) is
						when "0011" =>
							next_fsm_state_var := S6;
						when "1001" =>
							next_fsm_state_var := S16;
						when "1000" =>
							next_fsm_state_var := S16;
						when others =>
							next_fsm_state_var := S1;
					end case;
					
				when S1 =>
					MEM_WRITING<='0';
					RF_WRITING <= '0';
					RF_A1 <= instr_reg(11 downto 9);
					RF_A2 <= instr_reg(8 downto 6);
					temp_T1:=RF_D1; temp_T2:=RF_D2;
					temp_T3:=x"0000";
					case (instr_reg(15 downto 12)) is
						when "0111" => 
							next_fsm_state_var := S13;
						when "0110" =>
							next_fsm_state_var := S11;
						when "0100" =>
							next_fsm_state_var := S7;
						when "0101" =>
							next_fsm_state_var := S7;
						when "0001" =>
							next_fsm_state_var := S4;
						when "1100" =>
							if conv_integer(RF_D1) = conv_integer(RF_D2) ---need to implement this
							then
								next_fsm_state_var := S15;
							end if
						when "0000" =>
							if (instr_reg(1 downto 0) = "00" or (instr_reg(1 downto 0) = "10" and TC_TEMP ='1') or (instr_reg(1 downto 0) = "01" and TZ_TEMP = '1'))
							then 
								ALU_CONTROL <= '0';
								next_fsm_state_var := S2;
							else
								next_fsm_state_var := S;
							end if
						when "0010" =>
							if (instr_reg(1 downto 0) = "00" or (instr_reg(1 downto 0) = "10" and TC_TEMP ='1') or (instr_reg(1 downto 0) = "01" and TZ_TEMP = '1'))
							then 
								ALU_CONTROL <= '0';
								next_fsm_state_var := S2;
							else
								next_fsm_state_var := S;
							end if	
					end case;
				
				when S2 =>
					MEM_WRITING<='0';
					ALU_A <= T1; ALU_B <= T2;Temp_T3 := ALU_O;
					TC_TEMP := ALU_C;
					TZ_TEMP := ALU_Z;
					RF_WRITING <= '0';
					next_fsm_state_var := S3;
													
					
				when S3 =>
					RF_WRITING <= '1';
					RF_A3 <= instr_reg_var(5 downto 3);
					RF_D3 <= T3;
					next_fsm_state_var := S;
					
				when S4 =>
					ALU_CONTROL <= '0';
					ALU_A <= T1; 
					SIGN_EXTERNDER_10_INPUT<= instr_reg(5 downto 0);
					ALU_B <= SIGN_EXTENDER_10_OUTPUT;
					next_fsm_state_var := S5;
					
				when S5 =>
					RF_WRITING <= '1';
					RF_A3 <= instr_reg_var(8 downto 6);
					RF_D3 <= T3;
					next_fsm_state_var := S;
				
				when S6 =>
					RF_WRITING <= '1';
					RF_D3(15 downto 7) := instr_reg(8 downto 0);
					RF_D3(6 downto 0) := "0000000";
					RF_A3 <= instr_reg_var(11 downto 9);
					next_fsm_state_var:= S;
				
				
				when S7 =>
					ALU_CONTROL <= '0';
					ALU_A <= T2;
					SIGN_EXTERNDER_10_INPUT<= instr_reg(5 downto 0);
					ALU_B <= SIGN_EXTENDER_10_OUTPUT;
					Temp_T2 := ALU_O;
					
					case(instr_reg(15 downto 12)) is
						when "0100" =>
							next_fsm_state_var:= S8;
							
						when "0101" =>
							next_fsm_state_var:= S9;					
					end case;
					
				
				when S8 =>
				
					mem_A <= T2;
					Temp_T3 := MEM_DOUT;
					MEM_WRITING<='0';
					if (conv_integer(Temp_T3) = 0) ---need to implement this
					then
						TZ_TEMP := '1';
					end if
					next_fsm_state_var:= S10;
				
				when S9 =>
					MEM_WRITING<='1';
					mem_A <= T2;
					mem_Din <= T1;
					next_fsm_state_var:= S;
					
				when S10 =>
					RF_WRITING <= '1';
					RF_A3 <= instr_reg(11 downto 9);
					RF_D3 <= T3;
					next_fsm_state_var:= S;
					
				when S11 =>
					MEM_WRITING <= '0';
					ALU_CONTROL <= '0';
					ALU_A <= T1;
					ALU_B <= "0000000000000001";
					temp_T1 := ALU_O;
					MEM_A <= temp_T1;
					temp_T2 <= MEM_DOUT;
					next_fsm_state_var:= S12;
					
				when S12 =>
					RF_WRITING <= '1';
					RF_A3 <= T3(2 downto 0);
					RF_D3 <= T2;
					ALU_CONTROL <= '0';
					ALU_A <= T3;
					ALU_B <= "0000000000000001";
					temp_T3 <= ALU_O;
					case(T3(2 downto 0)) is
						when "111" =>
							next_fsm_state_var:= S;
						when others =>
							next_fsm_state_var:= S11;
					end case;
				
				when S13 =>
					RF_WRITING <= '0';
					RF_A1 <= T3(2 downto 0);
					temp_T2 := RF_D1; 
					ALU_CONTROL <= '0';
					ALU_A <= T3;
					ALU_B <= "0000000000000001";
					temp_T3 := ALU_O;
					next_fsm_state_var:= S14;
				
				when S14 => 
					MEM_WRITING <= '1'; 
					MEM_A <= T1;
					MEM_DIN <= T2;
					ALU_CONTROL <= '0';
					ALU_A <= T1;
					ALU_B <= "0000000000000001";
					temp_T1 <= ALU_O;
					case(T3(2 downto 0)) is
						when "111" =>
							next_fsm_state_var:= S;
						when others =>
							next_fsm_state_var:= S13;
					end case;
					
					
				when S15 =>
					ALU_CONTROL <= '0';
					ALU_A <= instr_ptr;
					SIGN_EXTERNDER_10_INPUT<= instr_reg(5 downto 0);
					ALU_B <= SIGN_EXTENDER_10_OUTPUT;
					PC := ALU_O;
					next_fsm_state_var:= S0;
					
				
				when S16 =>
					RF_WRITING <= '1';
					RF_A3 <= instr_reg(11 downto 9);
					RF_D3 <= instr_ptr;
					RF_A2 <= instr_reg(8 downto 0);
					temp_T2 <= RF_D2;
					
					case(instr_reg(3 downto 0)) is
					
					when "1000" =>
						next_fsm_state_var:= S15;
						
					when "1001" =>
						next_fsm_state_var:= S17;
						
					end case;
			
				when S17 => 
					Pc := T2;
					next_fsm_state_var:= S0;
					
					
				when S =>
					ALU_CONTROL <= '0';
					ALU_A <= instr_ptr;
					ALU_B <= "0000000000000001";
					PC := ALU_B;
					next_fsm_state_var:= S0;
				
			end case;
			T1 <= temp_T1; 
			T2 <= temp_T2; 
			T3 <= temp_T3; 
			T4 <= temp_T4; 
			T5 <= temp_T5;
			instr_reg <= instr_reg_var;
			C_FLAG <= TC_TEMP; 
			Z_FLAG <= TZ_TEMP;
			next_ptr <= PC;
			
			fsm_state <= next_fsm_state_var;
			end if;
		end if;
	end process
	
	
	
		