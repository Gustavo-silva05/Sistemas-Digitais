LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL;

ENTITY xtea_enc IS
    PORT (
        clk, reset, start : IN STD_LOGIC;
        data_i, key : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
        data_o : OUT STD_LOGIC_VECTOR (127 DOWNTO 0);
        busy, ready : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE xtea_enc OF xtea_enc IS
    TYPE state_type IS (IDLE, ENCRIP_XOR, ENCRIP_XOR2, ENCRIP_SOMA, ENCRIP_SOMA2, ENCRIP_KEY, ENCRIP_DATA, ENCRIP_SUM, RES);
    SIGNAL EA, PE : state_type;
    SIGNAL data_temp : STD_LOGIC_VECTOR (127 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL delta : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp2 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp3 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp4 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp5 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL data_encriptada : STD_LOGIC_VECTOR (127 DOWNTO 0);
    SIGNAL index_key : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL counter : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL op : STD_LOGIC_VECTOR (2 DOWNTO 0);
BEGIN
    states : PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            EA <= IDLE;
        ELSIF rising_edge(clk) THEN
            EA <= PE;
        END IF;
    END PROCESS states;
    ---------------------------------------------------------------------------------
    operations : PROCESS (clk, reset, EA, op)
    BEGIN
    
    IF rising_edge(clk) THEN
        data_o <= data_encriptada(31 DOWNTO 0) & data_encriptada(63 DOWNTO 32) & data_encriptada(95 DOWNTO 64) & data_encriptada(127 DOWNTO 96);
        IF EA = IDLE THEN
            op <= "000";
            counter <= x"00";
            data_temp <= data_i(31 DOWNTO 0) & data_i(63 DOWNTO 32) & data_i(95 DOWNTO 64) & data_i(127 DOWNTO 96);
            sum <= x"00000000";
            delta <= x"9E3779B9";
        ELSIF EA = ENCRIP_DATA THEN
            data_temp <= data_encriptada;
            IF op = "011" THEN
                op <= "000";
                counter <= counter + '1';
            ELSE
                op <= op + '1';
            END IF;
        ELSIF EA = ENCRIP_SUM THEN
            IF op = "01" THEN
                sum <= sum + delta;
            END IF;
        END IF;
    END IF;
END PROCESS operations;
-----------------------------------------------------------------------------------------------------------------
saidas : PROCESS (clk, reset, EA)
BEGIN
    CASE EA IS
        WHEN IDLE =>
            ready <= '0';
        WHEN ENCRIP_XOR =>
            ready <= '0';
        WHEN ENCRIP_XOR2 =>
            ready <= '0';
        WHEN ENCRIP_SOMA =>
            ready <= '0';
        WHEN ENCRIP_SOMA2 =>
            ready <= '0';
        WHEN ENCRIP_KEY =>
            ready <= '0';
        WHEN ENCRIP_DATA =>
            ready <= '0';
        WHEN ENCRIP_SUM =>
            ready <= '0';
        WHEN RES =>
            ready <= '1';
        WHEN OTHERS =>
            ready <= '0';
    END CASE;
END PROCESS saidas;
---------------------------------------------------------------------------------------------
fsm_NEXT_STATE : PROCESS (clk, EA, op, start, index_key, counter)
BEGIN
    CASE EA IS
        WHEN IDLE =>
            IF start = '1' THEN
                PE <= ENCRIP_XOR;
            ELSE
                PE <= IDLE;
            END IF;
        WHEN ENCRIP_XOR =>
            data_encriptada <= data_temp;
            IF counter < x"20" THEN
                IF op = "00" THEN
                    temp <= data_temp (95 DOWNTO 64) SLL 4 XOR data_temp (95 DOWNTO 64) SRL 5;
                ELSIF op = "01" THEN
                    temp <= data_temp (31 DOWNTO 0) SLL 4 XOR data_temp (31 DOWNTO 0) SRL 5;
                ELSIF op = "10" THEN
                    temp <= data_temp (127 DOWNTO 96) SLL 4 XOR data_temp (127 DOWNTO 96) SRL 5;
                ELSIF op = "11" THEN
                    temp <= data_temp (63 DOWNTO 32) SLL 4 XOR data_temp (63 DOWNTO 32) SRL 5;
                END IF;
                PE <= ENCRIP_SOMA;
            ELSE
                PE <= RES;
            END IF;
        WHEN ENCRIP_SOMA =>
            IF op = "00" THEN
                temp2 <= temp + data_temp(95 DOWNTO 64);
            ELSIF op = "01" THEN
                temp2 <= temp + data_temp(31 DOWNTO 0);
            ELSIF op = "10" THEN
                temp2 <= temp + data_temp(127 DOWNTO 96);
            ELSIF op = "11" THEN
                temp2 <= temp + data_temp(63 DOWNTO 32);
            END IF;
            PE <= ENCRIP_KEY;

        WHEN ENCRIP_KEY =>
            IF op = "00" OR op = "01" THEN
                index_key <= sum (1 DOWNTO 0) AND "11";
                IF index_key = "00" THEN
                    temp3 <= key(31 DOWNTO 0);
                ELSIF index_key = "01" THEN
                    temp3 <= key(63 DOWNTO 32);
                ELSIF index_key = "10" THEN
                    temp3 <= key(95 DOWNTO 64);
                ELSIF index_key = "11" THEN
                    temp3 <= key(127 DOWNTO 96);
                END IF;
            ELSE
                index_key <= sum (12 DOWNTO 11) AND "11";
                IF index_key = "00" THEN
                    temp3 <= key(31 DOWNTO 0);
                ELSIF index_key = "01" THEN
                    temp3 <= key(63 DOWNTO 32);
                ELSIF index_key = "10" THEN
                    temp3 <= key(95 DOWNTO 64);
                ELSIF index_key = "11" THEN
                    temp3 <= key(127 DOWNTO 96);
                END IF;
            END IF;
            PE <= ENCRIP_SOMA2;

        WHEN ENCRIP_SOMA2 =>
            temp4 <= sum + temp3;
            PE <= ENCRIP_SUM;

        WHEN ENCRIP_SUM =>
            PE <= ENCRIP_XOR2;

        WHEN ENCRIP_XOR2 =>
            temp5 <= temp2 XOR temp4;
            PE <= ENCRIP_DATA;

        WHEN ENCRIP_DATA =>
            IF op = "00" THEN
                data_encriptada (127 DOWNTO 96) <= data_temp (127 DOWNTO 96) + temp5;
            ELSIF op = "01" THEN
                data_encriptada (63 DOWNTO 32) <= data_temp (63 DOWNTO 32) + temp5;
            ELSIF op = "10" THEN
                data_encriptada (95 DOWNTO 64) <= data_temp (95 DOWNTO 64) + temp5;
            ELSIF op = "11" THEN
                data_encriptada (31 DOWNTO 0) <= data_temp (31 DOWNTO 0) + temp5;
            END IF;
            PE <= ENCRIP_XOR;

        WHEN RES =>
            PE <= IDLE;

        WHEN OTHERS =>
            PE <= IDLE;

    END CASE;
END PROCESS fsm_NEXT_STATE;
END ARCHITECTURE;