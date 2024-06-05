LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY xtea_top IS
    PORT (
        start, clk, reset, config : IN STD_LOGIC;
        data_i, key : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
        busy, ready : OUT STD_LOGIC;
        data_o : OUT STD_LOGIC_VECTOR (127 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE xtea_top OF xtea_top IS

BEGIN

    encrip : ENTITY work.xtea_enc
        PORT MAP(clk => clk, reset => reset, start => start, key => key, data_i => data_i, data_o => data_o, busy => busy, ready => ready, config => config);
    
    -- descrip : ENTITY work.xtea_dec
    --     PORT MAP (clk => clk, reset => reset, start => start, key => key, data_i => data_i, data_o => data_o, busy => busy, ready => ready, config => config);
    
END ARCHITECTURE xtea_top;