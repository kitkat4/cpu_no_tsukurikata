library IEEE;
use IEEE.std_logic_1164.all;


entity counter_sim is
end counter_sim;

architecture SIM of counter_sim is

    component counter
        generic(
            N_BIT : integer := 8
        );
        port(
            CLK : in std_logic;
            RST : in std_logic;
            COUNT : out std_logic_vector(N_BIT - 1 downto 0)
        );
    end component;

    signal CLK_TMP : std_logic;
    signal RESULT : std_logic_vector(15 downto 0);
    signal RST_TMP : std_logic := '1';

begin

    C1: counter
        generic map(
            N_BIT => 16
        )
        port map(
            CLK => CLK_TMP,
            RST => RST_TMP,
            COUNT => RESULT
        );

    process
    begin
        
        CLK_TMP <= '0';
        wait for 10 ns;
        CLK_TMP <= '1';
        wait for 10 ns;
        
        if(RST_TMP = '1') then
            RST_TMP <= '0';
        end if;
    end process;
    
end SIM;

