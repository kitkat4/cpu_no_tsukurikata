library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity dec_7seg_sim is

end dec_7seg_sim;


architecture SIM of dec_7seg_sim is

    component dec_7seg
        port(
            DIN : in  std_logic_vector(3 downto 0);
            SEG7: out std_logic_vector(6 downto 0)
        );
    end component;

    constant CYCLE : Time := 10 ns;
    
    signal DIN : std_logic_vector(3 downto 0) := "0000";
    signal SEG7: std_logic_vector(6 downto 0);

begin

    C1: dec_7seg
        port_map(
            DIN => DIN,
            SEG7 => SEG7
        );

    process
    begin
        for I in 0 to 15 loop
            wait for CYCLE;
            DIN <= DIN + 1;
        end loop;
        wait;
    end process;

end SIM;


