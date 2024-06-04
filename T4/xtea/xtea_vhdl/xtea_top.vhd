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
begin
    encrip: entity work.xtea_enc
    port map (clk=>clk, reset =>reset, start=>start, key=>key, data_i=>data_i, data_o=>data_o, busy=>busy, ready=>ready, config=>config);
    
    descrip: entity work.xtea_dec
    port map (clk=>clk, reset =>reset, start=>start, key=>key, data_i=>data_i, data_o=>data_o, busy=>busy, ready=>ready, config=>config);
end architecture xtea_top;