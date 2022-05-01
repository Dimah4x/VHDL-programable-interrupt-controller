library ieee;
use ieee.std_logic_1164.all;

entity ctrl is
-- insert code
port(	write_n : in std_logic;
	read_n: in std_logic;
	irr: in std_logic_vector(7 downto 0);
	d_inout: inout std_logic_vector(7 downto 0);
	msk: out std_logic_vector(7 downto 0);
	cs_n: in std_logic;
	irq_pic: out std_logic;
	mask_en: out std_logic;
	irr_en: out std_logic
	);
end ctrl;

architecture ctrl_logic of ctrl is

begin

irq_pic <= (irr(7) or irr(6) or irr(5) or irr(4) or irr(3) or irr(2) or irr(1) or irr(0));
d_inout <= irr when ((cs_n = '0') and (read_n = '0')) else (others => 'Z');
msk <= d_inout when ((cs_n = '0') and (write_n = '0')) else (others => '1');
irr_en <= '0' when ((cs_n = '0') and (read_n = '0')) else '1';
mask_en <= '0' when ((cs_n = '0') and (write_n = '0')) else '1';

end ctrl_logic;