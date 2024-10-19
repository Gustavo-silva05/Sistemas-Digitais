LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL;

ENTITY xtea_dec IS
    PORT (
        clk, reset, start : IN STD_LOGIC;
        data_i, key : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
        data_o : OUT STD_LOGIC_VECTOR (127 DOWNTO 0);
        ready : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE xtea_dec OF xtea_dec IS
    TYPE state_type IS (IDLE, DECRIP_XOR, DECRIP_XOR2, DECRIP_DECRESE, DECRIP_DECRESE2, DECRIP_KEY, DECRIP_DATA, DECRIP_SUM, RES);
    SIGNAL EA, PE : state_type;
    SIGNAL data_temp : STD_LOGIC_VECTOR (127 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL delta : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp2 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp3 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp4 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL temp5 : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL data_decriptada : STD_LOGIC_VECTOR (127 DOWNTO 0);
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

    
    operations : PROCESS (clk, reset, EA, op)
    BEGIN
        IF rising_edge(clk) THEN
            data_o <= data_decriptada(31 DOWNTO 0) & data_decriptada(63 DOWNTO 32) & data_decriptada(95 DOWNTO 64) & data_decriptada(127 DOWNTO 96);
            IF EA = IDLE THEN
                sum <= x"C6EF3720";
                delta <= x"9E3779B9";
                op <= "000";
                counter <= x"00";
                data_temp <= data_i(31 DOWNTO 0) & data_i(63 DOWNTO 32) & data_i(95 DOWNTO 64) & data_i(127 DOWNTO 96);

            ELSIF EA = DECRIP_DATA THEN
                data_temp <= data_decriptada;
                IF op = "011" THEN
                    op <= "000";
                    counter <= counter + '1';
                ELSE
                    op <= op + '1';
                END IF;
            ELSIF EA = DECRIP_SUM THEN
                IF op = "01" THEN
                    sum <= sum - delta;
                END IF;
            END IF;
        END IF;
    END PROCESS operations;
   
    saidas : PROCESS (clk, reset, EA)
    BEGIN
        CASE EA IS
            WHEN IDLE =>
                ready <= '0';
            WHEN DECRIP_XOR =>
                ready <= '0';
            WHEN DECRIP_XOR2 =>
                ready <= '0';
            WHEN DECRIP_DECRESE =>
                ready <= '0';
            WHEN DECRIP_DECRESE2 =>
                ready <= '0';
            WHEN DECRIP_KEY =>
                ready <= '0';
            WHEN DECRIP_DATA =>
                ready <= '0';
            WHEN DECRIP_SUM =>
                ready <= '0';
            WHEN RES =>
                ready <= '1';
            WHEN OTHERS =>
                ready <= '0';
        END CASE;
    END PROCESS saidas;
    --------------------------------------------------------------
    fsm : PROCESS (clk, EA, op, start, index_key, counter)
    BEGIN
        CASE EA IS
            WHEN IDLE =>
                IF start = '1' THEN
                    PE <= DECRIP_XOR;
                ELSE
                    PE <= IDLE;
                END IF;
            WHEN DECRIP_XOR =>
                data_decriptada <= data_temp;
                IF counter < x"20" THEN
                    IF op = "11" THEN
                        temp <= data_temp (95 DOWNTO 64) SLL 4 XOR data_temp (95 DOWNTO 64) SRL 5;
                    ELSIF op = "10" THEN
                        temp <= data_temp (31 DOWNTO 0) SLL 4 XOR data_temp (31 DOWNTO 0) SRL 5;
                    ELSIF op = "01" THEN
                        temp <= data_temp (127 DOWNTO 96) SLL 4 XOR data_temp (127 DOWNTO 96) SRL 5;
                    ELSIF op = "00" THEN
                        temp <= data_temp (63 DOWNTO 32) SLL 4 XOR data_temp (63 DOWNTO 32) SRL 5;
                    END IF;
                    PE <= DECRIP_DECRESE;
                ELSE
                    PE <= RES;
                END IF;
            WHEN DECRIP_DECRESE =>
                IF op = "11" THEN
                    temp2 <= temp + data_temp(95 DOWNTO 64);
                ELSIF op = "10" THEN
                    temp2 <= temp + data_temp(31 DOWNTO 0);
                ELSIF op = "01" THEN
                    temp2 <= temp + data_temp(127 DOWNTO 96);
                ELSIF op = "00" THEN
                    temp2 <= temp + data_temp(63 DOWNTO 32);
                END IF;
                PE <= DECRIP_KEY;

            WHEN DECRIP_KEY =>
                IF op = "11" OR op = "10" THEN
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
                PE <= DECRIP_DECRESE2;

            WHEN DECRIP_DECRESE2 =>
                temp4 <= sum + temp3;
                PE <= DECRIP_SUM;

            WHEN DECRIP_SUM =>
                PE <= DECRIP_XOR2;

            WHEN DECRIP_XOR2 =>
                temp5 <= temp2 XOR temp4;
                PE <= DECRIP_DATA;

            WHEN DECRIP_DATA =>
                IF op = "11" THEN
                    data_DECRIPtada (127 DOWNTO 96) <= data_temp (127 DOWNTO 96) - temp5;
                ELSIF op = "10" THEN
                    data_DECRIPtada (63 DOWNTO 32) <= data_temp (63 DOWNTO 32) - temp5;
                ELSIF op = "01" THEN
                    data_DECRIPtada (95 DOWNTO 64) <= data_temp (95 DOWNTO 64) - temp5;
                ELSIF op = "00" THEN
                    data_DECRIPtada (31 DOWNTO 0) <= data_temp (31 DOWNTO 0) - temp5;
                END IF;
                PE <= DECRIP_XOR;

            WHEN RES =>
                PE <= IDLE;

            WHEN OTHERS =>
                PE <= IDLE;

        END CASE;
    END PROCESS fsm;

END ARCHITECTURE;