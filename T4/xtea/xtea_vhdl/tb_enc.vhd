library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_enc is
end entity;

architecture tb_enc of tb_enc is
signal clk          :   std_logic := '0';
signal reset, start :   std_logic;
signal data_i, key  :   std_logic_vector (127 downto 0);
signal data_o       :   std_logic_vector (127 downto 0);
begin
    encriptador : entity work.xtea_enc 
    port map (  clk => clk, reset => reset, start=>start,
                data_i=> data_i, key=> key, 
                data_o=> data_o 
            ); 
    
    clk     <= not clk after 2 ns;
    reset   <= '1', '0' after 10 ns;
    data_i  <= x"A5A5A5A501234567FEDCBA985A5A5A5A"; 
    key     <= x"DEADBEEF0123456789ABCDEFDEADBEEF";
    process
    begin
        wait for 50 ns;
        start <= '1', '0' after 10 ns;
    end process;


end architecture;