library ieee;
use ieee.std_logic_1164.all;

entity read_register is
-- insert code
port(irr_en : in std_logic;
	 inta_and_rst: in std_logic;
	 clk: in std_logic;
	 prio: in std_logic_vector(7 downto 0);
	 irr: out std_logic_vector(7 downto 0));
end read_register;

architecture read_register_logic of read_register is

begin

process(clk,inta_and_rst)
begin

	if inta_and_rst='0' then  -- active low!!!
		irr <= (others => '0');
	elsif clk='1' and clk'event then
		irr <= prio;
	end if;

end process;

end read_register_logic;