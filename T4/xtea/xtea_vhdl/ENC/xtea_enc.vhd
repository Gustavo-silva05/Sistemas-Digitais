library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity xtea_enc is 
port(
    clk, reset,start   : in std_logic;
    data_i, key  : in std_logic_vector (127 downto 0);
    data_o  : out std_logic_vector (127 downto 0)
);
end entity;

architecture xtea_enc of xtea_enc is
    type state_type is (IDLE, ENCRIP_XOR, ENCRIP_XOR2, ENCRIP_SOMA, ENCRIP_SOMA2, ENCRIP_KEY, ENCRIP_DATA, ENCRIP_SUM);
    signal EA, PE           : state_type;
    signal data_temp        : std_logic_vector  (127 downto 0);
    signal sum              : std_logic_vector  (31 downto 0);
    signal delta            : std_logic_vector  (31 downto 0);
    signal temp             : std_logic_vector  (31 downto 0);
    signal temp2            : std_logic_vector  (31 downto 0);
    signal temp3            : std_logic_vector  (31 downto 0);
    signal temp4            : std_logic_vector  (31 downto 0);
    signal temp5            : std_logic_vector  (31 downto 0);
    signal data_encriptada  : std_logic_vector  (127 downto 0);
    signal index_key        : std_logic_vector  (1 downto 0);
    signal counter          : std_logic_vector  (7 downto 0);
    signal op               : std_logic_vector  (2 downto 0);
begin
    states: process (clk, reset) 
    begin
        if rising_edge(clk) then
            if reset = '1' then
                EA <= IDLE;
                delta <= x"9E3779B9";
            else
                EA <= PE;
            end if ;
        end if;
    end process states;

    operations: process(clk, reset)
    begin
        if reset = '1' then
            op <= "000";
        elsif rising_edge(clk) then
            if EA = ENCRIP_DATA then
                if op = "011" then
                    op <= "000";
                else 
                    op <= op + '1';
                end if;
            end if;
        end if;
    end process operations;

    countering: process(clk, reset)
    begin
        if reset = '1' then
            counter <= x"00";
        elsif rising_edge(clk) then
            if EA = IDLE then
                counter <= x"00";
            elsif EA = ENCRIP_DATA then
                if op = "11" then
                    counter <= counter + '1';
                end if;
            end if;
        end if;
    end process countering;

    data: process(clk, reset, EA, op)
    begin
        if reset = '1' then
            data_o <= x"00000000000000000000000000000000";
            data_temp <= data_i(31 downto 0) & data_i(63 downto 32) & data_i(95 downto 64) & data_i(127 downto 96);
        elsif rising_edge(clk) then
            data_o <= data_encriptada(31 downto 0) & data_encriptada(63 downto 32) & data_encriptada(95 downto 64) & data_encriptada(127 downto 96);
            if EA =  ENCRIP_DATA then
                    data_temp <= data_encriptada;
            end if;
        end if;
    end process data;

    somador: process(clk, reset,EA)
    begin
        if reset = '1' then
            sum <= x"00000000";
        elsif rising_edge(clk) then
            if EA = ENCRIP_SUM then
                if op = "01" then 
                    sum <= sum + delta;
                end if;
            end if;
        end if;
    end process somador;

   fsm : process (clk , EA , op, start, index_key,counter) 
    begin
        case EA is
            When IDLE =>
                if start = '1' then
                    data_encriptada <= data_temp;
                    PE <= ENCRIP_XOR;
                else
                    PE <= IDLE;
                end if ;
            
    
            When ENCRIP_XOR => 
                if counter < x"20" then
                    if op = "00" then
                        temp    <=  data_temp (95 downto 64) sll 4 xor  data_temp (95 downto 64) srl 5;
                    elsif op = "01" then
                        temp    <=  data_temp (31 downto 0) sll 4 xor  data_temp (31 downto 0) srl 5;
                    elsif op = "10" then
                        temp    <=  data_temp (127 downto 96) sll 4 xor  data_temp (127 downto 96) srl 5;
                    elsif op = "11" then
                        temp    <=  data_temp (63 downto 32) sll 4 xor  data_temp (63 downto 32) srl 5;   
                    end if;
                    PE <= ENCRIP_SOMA;
                else
                    PE <= IDLE;
                end if;

            
            when ENCRIP_SOMA =>
                if op = "00" then
                    temp2   <= temp + data_temp(95 downto 64);
                elsif op = "01" then
                    temp2   <= temp + data_temp(31 downto 0);
                elsif op = "10" then
                    temp2   <= temp + data_temp(127 downto 96);
                elsif op = "11" then
                    temp2   <= temp + data_temp(63 downto 32);
                end if;
                PE <= ENCRIP_KEY;
            
            WHEN ENCRIP_KEY =>
                if op = "00" or op = "01" then
                    index_key   <= sum (1 downto 0) and "11";
                    if index_key = "00" then
                        temp3   <=  key(31 downto 0);
                    elsif index_key = "01" then
                        temp3   <=  key(63 downto 32);
                    elsif index_key = "10" then
                        temp3   <=  key(95 downto 64);
                    elsif index_key = "11"  then
                        temp3   <=  key(127 downto 96);
                    end if ;
                else
                    index_key <= sum (12 DOWNTO 11) and "11";
                    if index_key = "00" then
                        temp3   <=  key(31 downto 0);
                    elsif index_key = "01" then
                        temp3   <=  key(63 downto 32);
                    elsif index_key = "10" then
                        temp3   <=  key(95 downto 64);
                    elsif index_key = "11"  then
                        temp3   <=  key(127 downto 96);
                    end if ;
                end if;
                PE <= ENCRIP_SOMA2;
            
            WHEN ENCRIP_SOMA2 =>
                temp4 <= sum + temp3;
                PE <= ENCRIP_SUM;

            WHEN ENCRIP_SUM =>        
                PE <= ENCRIP_XOR2;
            
            WHEN ENCRIP_XOR2 =>
                temp5 <= temp2 xor temp4;
                PE <= ENCRIP_DATA;
            
            WHEN ENCRIP_DATA =>
                if op = "00" then
                    data_encriptada (127 downto 96) <= data_temp (127 downto 96) +  temp5;
                elsif op = "01" then
                    data_encriptada (63 downto 32) <= data_temp (63 downto 32) +  temp5;
                elsif op = "10" then
                    data_encriptada (95 downto 64) <= data_temp (95 downto 64) +  temp5;
                elsif op = "11" then
                    data_encriptada (31 downto 0) <= data_temp (31 downto 0) +  temp5;
                end if;
                PE <= ENCRIP_XOR;
            
            when others=>
                PE <= IDLE;
            
        end case;
    end process fsm;
    
end architecture;