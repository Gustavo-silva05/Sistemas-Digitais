library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity xtea_enc is 
port(
    clk, reset,start   : in std_logic;
    data_i, key  : in std_logic_vector (127 downto 0);
    data_o  : out std_logic_vector (127 downto 0)
);
end entity;

architecture xtea_enc of xtea_enc is
    type state_type is (IDLE, INV, ENCRIP);
    signal EA, PE       : state_type;
    signal data_temp    : std_logic_vector (127 downto 0);
    signal key_temp     : std_logic_vector (127 downto 0);
    signal sum          : std_logic_vector (31 downto 0);
    signal delta        : std_logic_vector (31 downto 0);
    signal temp         : std_logic_vector (31 downto 0);
    signal temp2        : std_logic_vector (31 downto 0);
    signal temp3        : std_logic_vector (31 downto 0);
    signal temp4       : std_logic_vector (31 downto 0);
    signal temp5       : std_logic_vector (31 downto 0);
    signal temp6       : std_logic_vector (31 downto 0);
    signal index_key    : std_logic_vector (1 downto 0);
begiN
    process (clk, reset) 
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                EA <= IDLE;
                sum <= x"00000000";
                delta <= x"9E3779B9";
            else
                EA <= PE;
            end if ;
        end if;
    end process;

    process (clk , EA) 
    begin
        case EA is
            When IDLE =>
                if start = '1' then
                    PE <= INV;
                else
                    PE <= IDLE;
                end if ;
            When INV => 
                data_temp <= data_i(31 downto 0) & data_i(63 downto 32) & data_i(95 downto 64) & data_i(127 downto 96);
                key_temp <= key(31 downto 0) & key(63 downto 32) & key(95 downto 64) & key(127 downto 96);
                PE <= ENCRIP;       
            When ENCRIP => 
                
                temp    <=  data_temp (95 downto 64) sll 4 xor  data_temp (95 downto 64) srl 5;
                temp2   <= temp + data_temp(95 downto 64);
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
                temp4 <= sum + temp3;
                temp5 <= temp2 xor temp4;
                temp6 <= data_temp (127 downto 96) +  temp5;
                data_temp (127 downto 96) <= temp6;

            when others=>
                PE <= IDLE;
            
        end case;
    end process;

    data_o <= data_temp;

end architecture;