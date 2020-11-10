library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity adder_4bit is
    port(
        AIN : in  std_logic_vector(3 downto 0),
        BIN : in  std_logic_vector(3 downto 0),
        SOUT: out std_logic_vector(4 downto 0)
    );
end adder_4bit;

architecture RTL of adder_4bit is
begin

    SOUT <= ('0' & AIN) + ('0' & BIN);

end RTL;

