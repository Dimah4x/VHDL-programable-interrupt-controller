LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_unsigned.all; 

 
ENTITY mask_register_tb IS 
END mask_register_tb; 
 
ARCHITECTURE behavior OF mask_register_tb IS  
 
-- Component Declaration for the Unit Under Test (UUT) 
 
COMPONENT mask_register 
PORT( 

  	 mask_en : in std_logic;
	 rst_n: in std_logic;
	 clk: in std_logic;
	 msk: in std_logic_vector(7 downto 0);
	 mask: out std_logic_vector(7 downto 0)
); 
END COMPONENT mask_register; 
 
--Inputs 
signal clk_tb : std_logic := '0'; 
signal rst_n_tb : std_logic := '1'; 
signal mask_en_tb : std_logic := '0'; 
signal msk_tb : std_logic_vector (7 downto 0) := "00000000"; 
--Outputs 
signal mask_tb : std_logic_vector (7 downto 0) := "00000000"; 

-- Clock period definitions 
constant clk_period : time := 10 ns; 
 
BEGIN 
 
-- Instantiate the Unit Under Test (UUT) 
uut: mask_register PORT MAP ( clk=> clk_tb, rst_n => rst_n_tb, mask_en => mask_en_tb, msk=> msk_tb, mask=> mask_tb); 
 
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

msk_tb<="11110000"; 

-- hold reset state for 100ms. 
wait for 100 ns;  

msk_tb<="00001111"; 
wait for 100 ns; 

msk_tb<="11101111"; 
wait for 100 ns; 

mask_en_tb <= '1'; 
msk_tb<="11101111"; 
wait for 150 ns; 

mask_en_tb <= '0'; 
rst_n_tb <= '0'; 
wait for 100 ns; 

wait; 
end process; 
END; 
