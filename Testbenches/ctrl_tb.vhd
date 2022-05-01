library ieee;
use ieee.std_logic_1164.all;

entity ctrl_tb is
end entity ctrl_tb;

architecture ctrl_logic_tb of ctrl_tb is
component ctrl is

port(
	write_n : in std_logic;
	cs_n: in std_logic;
	read_n: in std_logic;
	irr: in std_logic_vector(7 downto 0);
	d_inout: inout std_logic_vector(7 downto 0);
	irq_pic: out std_logic;
	irr_en: out std_logic;
	mask_en: out std_logic;
	msk: out std_logic_vector(7 downto 0)
	);

end component ctrl;
--signal decleration
signal write_n_tb: std_logic:= '1';
signal cs_n_tb: std_logic:= '0';
signal read_n_tb: std_logic:= '1';
signal irr_tb : std_logic_vector(7 downto 0):="00000000" ;
signal d_inout_tb:  std_logic_vector(7 downto 0) ; -- The data bus. only the higher bit will pass to the prio after mask
signal irq_pic_tb: std_logic:= '0';
signal irr_en_tb: std_logic:= '0';
signal mask_en_tb: std_logic:= '0';
signal msk_tb : std_logic_vector(7 downto 0) := "00000000";

begin 

uut: ctrl

port map(

	write_n => write_n_tb,
	cs_n  => cs_n_tb,
	read_n => read_n_tb,  
	irr => irr_tb, 
	d_inout => d_inout_tb,
	irq_pic =>  irq_pic_tb, 
	irr_en => irr_en_tb, 
	mask_en => mask_en_tb, 
	msk => msk_tb 
	 );

stim_proc : process

begin
 d_inout_tb   <= (others => 'Z');
wait for 10 ns; 
	irr_tb <= "00010010";
wait for 10 ns; 
	cs_n_tb <= '0'; 
	read_n_tb <= '0'; --check read mode
wait for 10 ns; 
	read_n_tb <= '1'; --set idle
	cs_n_tb <= '1';		 
wait for 10 ns; 
	write_n_tb <= '0'; --check write mode
	cs_n_tb <= '0';
	d_inout_tb   <= "01010101";
wait for 10 ns; 
	write_n_tb <= '1'; --set idle
	cs_n_tb <= '1';
	d_inout_tb <= (others => 'Z');
wait for 10 ns; 
	cs_n_tb <= '0'; 
	read_n_tb <= '0'; 
	irr_tb  <= "10000000";
wait for 10 ns; 
	cs_n_tb <= '1'; 
	read_n_tb <= '1'; 
wait for 100 ns;

wait;
end process;

end architecture ctrl_logic_tb;

