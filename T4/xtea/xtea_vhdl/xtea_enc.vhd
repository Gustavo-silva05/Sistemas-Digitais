library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xtea_enc is 
port(
    clk, reset,start   : in std_logic;
    data_i, key  : in std_logic_vector (127 downto 0);
    data_o  : out std_logic_vector (127 downto 0)
);
end entity;

architecture xtea_enc of xtea_enc is
    type state_type is (IDLE, INV, ENCRIP);
    signal EA, PE : state_type;
    signal data_temp : std_logic_vector (127 downto 0);
    
begiN
    process (clk, reset) 
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                EA <= IDLE;
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
                PE <= ENCRIP;       
            When ENCRIP => 
                PE <= IDLE;
            when others=>
                PE <= IDLE;
            
        end case;
    end process;

end architecture;