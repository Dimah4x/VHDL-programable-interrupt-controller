LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_unsigned.all; 

 
ENTITY read_register_tb IS 
END read_register_tb; 
 
ARCHITECTURE behavior OF read_register_tb IS  
 
-- Component Declaration for the Unit Under Test (UUT) 
 
COMPONENT read_register 
PORT( 

  	 irr_en : in std_logic;
	 inta_and_rst: in std_logic;
	 clk: in std_logic;
	 prio: in std_logic_vector(7 downto 0);
	 irr: out std_logic_vector(7 downto 0)
); 
END COMPONENT read_register; 
 
--Inputs 
signal clk_tb : std_logic := '0'; 
signal inta_and_rst_tb : std_logic := '1'; 
signal irr_en_tb : std_logic := '0'; 
signal  prio_tb : std_logic_vector (7 downto 0) := "00000000"; 
--Outputs 
signal irr_tb : std_logic_vector (7 downto 0) := "00000000"; 

-- Clock period definitions 
constant clk_period : time := 10 ns; 
 
BEGIN 
 
-- Instantiate the Unit Under Test (UUT) 
uut: read_register PORT MAP ( clk=> clk_tb, 
			      inta_and_rst => inta_and_rst_tb,
 			      irr_en => irr_en_tb, 
			      prio=> prio_tb, 
			      irr=> irr_tb); 
 
-- Clock process definitions 
process 
begin 
clk_tb <= '0'; 
wait for 50 ns; 
clk_tb <= '1'; 
wait for 50 ns; 
end process; 
 
-- Stimulus process 
stim_proc: process 
begin  

prio_tb<="11110000"; 

-- hold reset state for 100ms. 
wait for 100 ns;  

prio_tb<="00001111"; 
wait for 100 ns; 

prio_tb<="11101111"; 
wait for 100 ns; 

irr_en_tb <= '1'; 
prio_tb<="11101111"; 
wait for 150 ns; 

irr_en_tb <= '0'; 
inta_and_rst_tb <= '0'; 
wait for 100 ns; 

wait; 
end process; 
END; 
