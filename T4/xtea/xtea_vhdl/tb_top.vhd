LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL;

ENTITY tb_top IS
END ENTITY tb_top;

ARCHITECTURE tb_top OF tb_top IS
    SIGNAL clk          : STD_LOGIC := '0';
    SIGNAL reset, start : STD_LOGIC;
    signal config       : STD_LOGIC := '0';
    SIGNAL busy, ready  : STD_LOGIC ;
    SIGNAL data_i, key  : STD_LOGIC_VECTOR (127 DOWNTO 0);
    SIGNAL data_o       : STD_LOGIC_VECTOR (127 DOWNTO 0);

    
    TYPE dados_test IS ARRAY(NATURAL RANGE <>) OF std_logic_vector(127 downto 0);
    CONSTANT dados_teste : dados_test := (
        x"089975E92555F334CE76E4F24D932AB3", x"A5A5A5A501234567FEDCBA985A5A5A5A",
        x"01234567890123456789012345678901", x"B4AFCEADDA134A4936A4AA71F7DEE5A1",
        x"98765432198765432198765432198765", x"6781B1F4686C59CD8E64AF4BD9CAACF1",
        x"1A2B3C4D5E6F1A2B3C4D5E6F1A2B3C4D", x"688289A7AC092EF55F758D19DF3AFC5F",
        x"ABCDEFABCDEFABCDEFABCDEFABCDEFAB", x"CD11831527B0B98C60584277EC389AD0"
        

    );
    CONSTANT chaves_teste : dados_test := (
        x"DEADBEEF0123456789ABCDEFDEADBEEF", x"DEADBEEF0123456789ABCDEFDEADBEEF",
        x"CABE1234567891234565DEFADEDEBEEF", x"CABE1234567891234565DEFADEDEBEEF",
        x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
        x"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", x"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
        x"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC", x"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"

    );
BEGIN
    encriptador : ENTITY work.xtea_top
        PORT MAP(
            clk => clk, reset => reset, start => start,
            data_i => data_i, key => key,
            data_o => data_o, config => config,
            busy => busy, ready => ready
        );

    clk <= NOT clk AFTER 5 ns;
    reset <= '1', '0' AFTER 20 ns;
    config <= not config after 12000 ns;

    PROCESS
    BEGIN
        FOR i IN dados_teste'RANGE LOOP
            data_i <= dados_teste(i);
            key <= chaves_teste(i);
            start <= '1', '0' AFTER 50 ns;
            WAIT FOR 12000 ns;
        END LOOP;

    END PROCESS;
END ARCHITECTURE tb_top;