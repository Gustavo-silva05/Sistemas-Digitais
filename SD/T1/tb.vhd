library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity tb is
end entity tb;


architecture tb of tb is
    signal clk : std_logic :='0'; 
    signal rst, configurar, valido : std_logic;
    signal entrada: std_logic_vector(3 downto 0);
    signal tranca, configurado, alarme : std_logic;

    type test_vector is record
        valido : std_logic;
        entrada : integer;
    end record;

    type test_vector_array is array(natural range <>) of test_vector;

  constant test_vectors : test_vector_array := (
    -- configurar, valido, entrada;
    ('0', 3),
    ('1', 3),  -- define Vezes (3)
    ('0', 3),
    
    ('0', 5),
    ('1', 5), -- define senha1 (5)
    ('0', 5),

    ('0', 2),
    ('1', 2), -- define senha2 (2)
    ('0', 2),

    ('0', 5),
    ('1', 5), -- define senha3 (5)
    ('0', 5),

    ('0', 1),
    ('1', 1),
    ('0', 1),

    ('0', 5),
    ('1', 5),
    ('0', 5),

    ('0', 3),
    ('1', 3),
    ('0', 3),

    ('0', 1),
    ('1', 1),
    ('0', 1),

    ('0', 5),
    ('1', 5),
    ('0', 5),

    ('0', 3),
    ('1', 3),
    ('0', 3)



  ); 


begin
    DUT: entity work.tranca
    port map(clk=>clk, rst=>rst, configurar => configurar, valido=>valido, entrada=>entrada, tranca=>tranca, configurado=>configurado, alarme=>alarme);
    
        clk <=  not clk after 6.25 ns;
        rst <= '1', '0' after 10 ns;
        configurar <= '1', '0' after 300 ns;
        process
        begin
            wait for 10 ns;
            for i in test_vectors'range loop 
                valido <= test_vectors(i).valido;
                entrada <= conv_std_logic_vector(test_vectors(i).entrada, entrada'length);
                wait for 30 ns;
            end loop;

        end process;
end architecture;
