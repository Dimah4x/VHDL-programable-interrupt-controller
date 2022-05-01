 library IEEE;
use IEEE.std_logic_1164.all;

-------------------------------
entity pic_tb is
end entity pic_tb;
 
architecture arc_pic_tb of pic_tb is
component Pic is
port(
        -- inputs:
	cs_n:in std_logic;
	write_n:in std_logic;
	read_n:in std_logic;
	clk:in std_logic;
	rst_n:in std_logic;
	inta_n:in std_logic;
	irq:in std_logic_vector(7 downto 0);
	d_inout: inout std_logic_vector(7 downto 0);
	 --outputs:
		irq_pic: out std_logic);
 
end component Pic;

--------------------------------------------
-- signnals--
signal cs_n_tb  : std_logic:='1';
signal write_n_tb  : std_logic:='1';
signal read_n_tb  : std_logic:='1';
signal clk_tb : std_logic:='0';
signal rst_n_tb : std_logic:='1';
signal inta_n_tb: std_logic:='1';
signal irq_tb : std_logic_vector(7 downto 0):="00000000";
signal d_inout_tb   : std_logic_vector(7 downto 0):=(others =>'Z');
signal irq_pic_tb : std_logic;

---------------------------------------------------------------
begin
clock : process
	begin
        	wait for 5 ns; clk_tb  <= not clk_tb;
      	end process clock;

dut: Pic
port map(
	cs_n  => cs_n_tb,
	write_n  => write_n_tb,
	read_n  => read_n_tb,
        clk => clk_tb,
        rst_n => rst_n_tb,
        inta_n=> inta_n_tb,
        irq => irq_tb,
        d_inout   => d_inout_tb,
        irq_pic => irq_pic_tb
   	);
   
stimulus : process
   begin
wait for 10 ns; 
	rst_n_tb  <= '0';
wait for 10 ns; 
	rst_n_tb  <= '1';
wait for 10 ns; 
	cs_n_tb  <='0'; write_n_tb <= '0'; d_inout_tb <= "00000000";
wait for 10 ns; 
	cs_n_tb  <='1'; write_n_tb <= '1'; d_inout_tb <= "ZZZZZZZZ";
wait for 10 ns; 
	irq_tb  <= "10101010";
wait for 10 ns; 
	cs_n_tb  <='0'; read_n_tb <= '0'; 
wait for 10 ns; 
	cs_n_tb  <='1'; read_n_tb <= '1'; 
wait for 10 ns; 
	inta_n_tb  <= '0'; irq_tb <= "00000000";
wait for 10 ns;
	inta_n_tb  <= '1'; 
wait for 10 ns;
	cs_n_tb  <='0'; write_n_tb <= '0';
wait for 10 ns;
	d_inout_tb <= "01010101";
wait for 10 ns;
	cs_n_tb  <='1'; write_n_tb <= '1';
wait for 10 ns;
	d_inout_tb <= "ZZZZZZZZ"; irq_tb <= "01010101";
wait for 10 ns;
	cs_n_tb  <='0'; read_n_tb <= '0'; 
wait for 10 ns;
	cs_n_tb  <='1'; read_n_tb <= '1';         


end process stimulus;
end architecture arc_pic_tb;