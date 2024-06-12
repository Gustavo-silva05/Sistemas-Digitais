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
    TYPE state_type IS (IDLE, ENC, DEC, RES);
    SIGNAL EA, PE : state_type;
    SIGNAL start_enc, start_dec : STD_LOGIC;
    SIGNAL ready_enc, ready_dec : STD_LOGIC;
    SIGNAL data_o_enc, data_o_dec : STD_LOGIC_VECTOR (127 DOWNTO 0);


BEGIN

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            EA <= IDLE;
        ELSIF rising_edge(clk) THEN
            EA <= PE;
        END IF;
    END PROCESS;

    next_state : PROCESS (clk, start, config, EA, ready_enc, ready_dec)
    BEGIN
        CASE EA IS
            WHEN IDLE =>
                IF start = '1' THEN
                    IF config = '1' THEN
                        start_enc <= '1';
                        start_dec <= '0';
                        PE <= ENC;
                    ELSIF config = '0' THEN
                        start_enc <= '0';
                        start_dec <= '1';
                        PE <= DEC;
                    END IF;
                ELSE
                    PE <= IDLE;
                END IF;
            WHEN ENC =>
                IF ready_enc = '1' THEN
                    PE <= RES;
                ELSE
                    PE <= ENC;
                END IF;
            WHEN DEC =>
                IF ready_dec = '1' THEN
                    PE <= RES;
                ELSE
                    PE <= DEC;
                END IF;
            WHEN RES =>
                start_enc <= '0';
                start_dec <= '0';
                PE <= IDLE;
            WHEN OTHERS =>
                PE <= IDLE;
        END CASE;
    END PROCESS next_state;

    saidas : PROCESS (clk,EA, start_enc)
    BEGIN
        CASE EA IS
            WHEN IDLE =>
                busy <= '0';
                ready <= '0';
            WHEN ENC =>
                busy <= '1';
                ready <= '0';
                data_o <= data_o_enc;
            WHEN DEC =>
                busy <= '1';
                ready <= '0';
                data_o <= data_o_dec;
            WHEN RES =>
                IF ready_enc = '1' THEN
                    data_o <= data_o_enc;
                ELSIF ready_dec = '1' THEN
                    data_o <= data_o_dec;
                END IF;
                busy <= '0';
                ready <= '1';
        END CASE;
    END PROCESS saidas;

    encrip : ENTITY work.xtea_enc
        PORT MAP(clk => clk, reset => reset, start => start_enc, key => key, data_i => data_i, data_o => data_o_enc, ready => ready_enc);

    descrip : ENTITY work.xtea_dec
        PORT MAP(clk => clk, reset => reset, start => start_dec, key => key, data_i => data_i, data_o => data_o_dec, ready => ready_dec);

END ARCHITECTURE xtea_top;