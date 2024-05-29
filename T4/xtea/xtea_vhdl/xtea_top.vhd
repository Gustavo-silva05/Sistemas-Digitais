library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity xtea_top is 
port(
    start, clk, reset config : IN std_logic;
    data_i, key : IN std_logic_vector (127 downto 0);
    busy, ready : out std_logic;
    key : OUT std_logic_vector (127 downto 0)
);
end Entity;
architecture xtea_top of xtea_top is

    Type state is (IDLE, ENC, DEC, END);
    signal EA, PE : state;

begin
    process(clk,reset)
    begin
        if reset = '1' then
            EA <= IDLE;
        elsif rising_edge(clk) then
            EA <= PE;
        end if;
    end process;

    process (clk, EA)
    begin
        case EA is
            When IDLE =>
                if start = '1' then
                    if config = '1' then
                        PE <= ENC;
                    else
                        PE <= DEC;
                    end if ;
                else
                    PE <= IDLE;
                end if ;
            When ENC => 
                encriptador: entity work.xtea_enc
                        port map ();
                PE <= FIM;
            When DEC =>
                descriptador: entity work.xtea_dec
                        port map ();
                PE <= FIM;
            When END =>
                PE <= IDLE;
        end case;
    end process;
end architecture;