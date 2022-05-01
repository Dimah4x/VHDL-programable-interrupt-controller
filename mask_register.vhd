library ieee;
use ieee.std_logic_1164.all;

entity mask_register is
-- insert code
port(mask_en : in std_logic;
	 rst_n: in std_logic;
	 clk: in std_logic;
	 msk: in std_logic_vector(7 downto 0);
	 mask: out std_logic_vector(7 downto 0));
end mask_register;

architecture mask_register_logic of mask_register is

begin

process(clk,rst_n)
begin 
	if rst_n='0' then -- if reset ( active low)
		mask <= (others => '0'); -- set output mask to 0000000
	elsif clk='1' and clk'event then -- if rising edge clock
		mask <= not(msk);  -- set mask output to NOT(msk)
	end if;
end process;

end mask_register_logic;