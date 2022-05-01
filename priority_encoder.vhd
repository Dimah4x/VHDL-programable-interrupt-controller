library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder is

port( irq: in std_logic_vector(7 downto 0); -- The data bus. only the higher bit will pass to the prio after mask
	  mask: in std_logic_vector(7 downto 0); -- mask vector to mask. It is not like a regular mask. The bits equal to 1 !!!BLOCKS!!! the 1 bits in irq. 
	  prio: out std_logic_vector(7 downto 0)  -- will give as output only the higher bit that equals '1' from irq vector. example: 00001000
);                            
end priority_encoder;

architecture priority_encoder_logic of priority_encoder is

signal masked_irq: std_logic_vector(7 downto 0);
signal highest_one: std_logic;
begin

masked_irq <= irq AND (NOT mask); -- if mask is "1100" it blocks the 3,2 bits. Thus, in order to mask we invert the mask bits in order to do a "real mask" by doing bitwise AND with (NOT mask)

 PROCESS(masked_irq)

BEGIN

    -- priority encoder

    IF masked_irq(7) = '1' THEN
        prio <= "10000000";
    ELSIF masked_irq(6) = '1' THEN
        prio <= "01000000";
    ELSIF masked_irq(5) = '1' THEN
        prio <= "00100000";
    ELSIF masked_irq(4) = '1' THEN
        prio <= "00010000";
    ELSIF masked_irq(3) = '1' THEN
        prio <= "00001000";
    ELSIF masked_irq(2) = '1' THEN
        prio <= "00000100";
    ELSIF masked_irq(1) = '1' THEN
        prio <= "00000010";
    ELSIF masked_irq(0) = '1' THEN
        prio <= "00000001";
    ELSE
        prio <= "00000000";
    END IF;
	
end PROCESS;


end priority_encoder_logic;