-- and_or.vhd
library IEEE;
use IEEE.std_logic_1164.all;

-- I/O definitions
entity and_or is
    port(
        A     : in  std_logic;
        B     : in  std_logic;
        Z_AND : out std_logic;
        Z_OR  : out std_logic
    );
end and_or;

architecture RTL of and_or is

begin

    Z_AND <= A and B;

    Z_OR <= A or B;
    
end RTL;
    
