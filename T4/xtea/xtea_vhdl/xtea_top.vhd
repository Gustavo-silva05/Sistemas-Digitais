library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity xtea_top is 
port(
    start, clk, reset, config : IN std_logic;
    data_i, key : IN std_logic_vector (127 downto 0);
    busy, ready : out std_logic;
    data_o : OUT std_logic_vector (127 downto 0)
);
end Entity;
architecture xtea_top of xtea_top is

    Type state is (IDLE, ENC, DEC, FIM);
    signal EA, PE : state;
    signal busy_temp, ready_temp : std_logic;

begin
    states: process(clk,reset)
    begin
        if reset = '1' then
            EA <= IDLE;
        elsif rising_edge(clk) then
            EA <= PE;
        end if;
    end process states;

    saidas: process(clk, reset, EA)
    begin
        if reset = '1' then
            busy <= '0';
        elsif rising_edge(clk) then
            if EA = IDLE or EA = FIM then
                busy <= '0';
                if EA = FIM then
                    ready <= '1';
                elsif EA = IDLE then
                    ready <= '0';
                end if;
            else 
                ready <= '0';
                busy <= '1';
            end if;
        end if;
    end process saidas;


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
                encriptador_TOP: entity work.xtea_enc
                        port map (clk=>clk,reset =>reset, start=>start, key=>key, data_i=>data_i, data_o=>data_o);
                PE <= FIM;
            When DEC =>
                descriptador_TOP: entity work.xtea_dec
                        port map (clk=>clk,reset =>reset, start=>start, key=>key, data_i=>data_i, data_o=>data_o);
                PE <= FIM;
            WHEN FIM =>
                PE <= IDLE;
        end case;
    end process;
end architecture;