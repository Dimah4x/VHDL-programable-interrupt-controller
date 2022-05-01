library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder_tb is
end entity priority_encoder_tb;

architecture priority_encoder_logic_tb of priority_encoder_tb is
component priority_encoder is

port(
      irq: in std_logic_vector(7 downto 0); -- The data bus. only the higher bit will pass to the prio after mask
	  mask: in std_logic_vector(7 downto 0); -- mask vector to mask 
	  prio: out std_logic_vector(7 downto 0)  -- will give as output only the higher bit that equals '1' from irq vector.
);

end component priority_encoder;

signal irq_tb:  std_logic_vector(7 downto 0)  := "00000000"; -- The data bus. only the higher bit will pass to the prio after mask
signal mask_tb:  std_logic_vector(7 downto 0) := "00000000";
signal prio_tb : std_logic_vector(7 downto 0) := "00000000";
begin 

uut: priority_encoder

port map (
		irq => irq_tb,
		mask => mask_tb,
		prio => prio_tb
		 
		 );

stim_proc : process

begin

wait for 100 ns;
irq_tb <= "10001011";
mask_tb <= "11100000";

wait for 100 ns;
irq_tb <= "00011111";
mask_tb <= "11101011";

wait for 100 ns;
irq_tb <= "11111111";
mask_tb <= "11101111";

wait for 100 ns;
irq_tb <= "00000111";
mask_tb <= "11100000";

wait for 100 ns;
irq_tb <= "11000111";
mask_tb <= "01100110";

wait for 100 ns;
wait;
end process;

end architecture priority_encoder_logic_tb;
