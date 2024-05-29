library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xtea_dec is 
port(
    clk, reset   : in std_logic;
    data_i, key  : in std_logic_vector (127 downto 0);
    data_o  : out std_logic_vector (127 downto 0)
);
end entity;

architecture xtea_dec of xtea_dec is

    type state is (INV, DESCRIP, END);
    signal EA, PE : state;

    process (clk, reset) begin
        if reset = '1' then
            EA <= INV;
        else
            EA <= PE;
        end if ;
    end process;

    process (clk , EA) begin
        case EA is
            When INV => 
            When DESCRIP => 
            When END => 
        end case;
    end process;

end architecture;