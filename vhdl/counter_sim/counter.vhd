library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity counter is
    
    generic(
        N_BIT : integer := 8
    );
    port(
        CLK : in std_logic;
        RST : in std_logic;
        COUNT : out std_logic_vector(N_BIT - 1 downto 0)
    );
    
end counter;

architecture RTL of counter is

    signal COUNT_TMP : std_logic_vector(N_BIT - 1 downto 0);
    
begin

    process(CLK, RST)
    begin
        if(CLK'event and CLK = '1') then
            if(RST = '1') then
                COUNT_TMP <= (others => '0');
            else
                COUNT_TMP <= COUNT_TMP + 1;
            end if;
        end if;
    end process;
            
    COUNT <= COUNT_TMP;
    
end RTL;

