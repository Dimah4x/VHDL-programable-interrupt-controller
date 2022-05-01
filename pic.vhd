library ieee;
use ieee.std_logic_1164.all;

entity pic is
-- insert code
port(-- inputs:
	cs_n:in std_logic;
	write_n:in std_logic;
	read_n:in std_logic;
	clk:in std_logic;
	rst_n:in std_logic;
	inta_n:in std_logic;
	irq:in std_logic_vector(7 downto 0);
	--inouts
	d_inout: inout std_logic_vector(7 downto 0);
	--outputs
	irq_pic: out std_logic);
end pic;

architecture pic_logic of pic is
--inner connections
signal mask_en, irr_en: std_logic;
signal msk,mask,prio,irr: std_logic_vector(7 downto 0);
signal inta_and_rst: std_logic;

component ctrl
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
end component;

component priority_encoder
port( 
	irq: in std_logic_vector(7 downto 0);
	mask: in std_logic_vector(7 downto 0);
	prio: out std_logic_vector(7 downto 0) 
	);
end component;

component mask_register
port(
	mask_en : in std_logic;
	rst_n: in std_logic;
	clk: in std_logic;
	msk: in std_logic_vector(7 downto 0);
	mask: out std_logic_vector(7 downto 0)
	);
end component;

component read_register
port(
	irr_en : in std_logic;
	inta_and_rst: in std_logic;
	clk: in std_logic;
	prio: in std_logic_vector(7 downto 0);
	irr: out std_logic_vector(7 downto 0)
	);
end component;

begin
inta_and_rst <= inta_n and rst_n;

--ctrl_unit: ctrl port map ( write_n => write_en, 
--						   cs_n => cs_en, 
--						   irr_7_0_inner => irr_vect
--						   read_n=>read_n, 
--						   d_inout => d_in_out, 
--						   irq_pic=>irq_pic);
						   
ctrl_unit: ctrl port map(
	write_n => write_n, 
	cs_n=>cs_n, 
	d_inout=>d_inout, 
	irq_pic=>irq_pic,
	read_n=>read_n,
	irr=>irr,
	irr_en=>irr_en, 
	mask_en=>mask_en,
	msk=>msk
	);

mask_unit: mask_register port map(
	msk=>msk,
	mask_en=>mask_en,
	clk=>clk,
	mask=>mask,
	rst_n=>rst_n
	);
								  
read_unit: read_register port map(
	irr_en=>irr_en,
	irr=>irr,
	inta_and_rst => inta_and_rst,
	prio=>prio,
	clk=>clk
	);

priority_encoder_unit: priority_encoder port map(
	mask=>mask,
	prio=>prio,
	irq=>irq
	);


end pic_logic;



































