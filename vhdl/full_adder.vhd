-- full_adder.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
    port(
        A  : in  std_logic;
        B  : in  std_logic;
        CI : in  std_logic;
        CO : out std_logic;
    );
end full_adder;

architecture RTL of full_adder is

    -- Declaration
    component half_adder
        port(
            A  : in  std_logic;
            B  : in  std_logic;
            S  : out std_logic;
            CO : out std_logic
        );
    end component;

    -- Internal signals
    signal S_TMP   : std_logic;
    signal CO_TMP1 : std_logic;
    signal CO_TMP2 : std_logic;

begin

    C1: half_adder
        port map(
            A => A,
            B => B,
            CO => CO_TMP1,
            S => S_TMP
        );

    C2: half_adder
        port map(
            A => CI,
            B => S_TMP,
            CO => CO_TMP2,
            S => S
        );

    CO <= CO_TMP1 or CO_TMP2;
    
end RTL;

