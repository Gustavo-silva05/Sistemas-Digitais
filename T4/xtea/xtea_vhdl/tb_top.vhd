library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_top is
end entity;

architecture tb_top of tb_top is
signal clk                  :   std_logic := '0';
signal reset, start,config  :   std_logic;
signal data_i, key          :   std_logic_vector (127 downto 0);
signal data_o               :   std_logic_vector (127 downto 0);
begin
    encriptador : entity work.xtea_top 
    port map (  clk => clk, reset => reset, start=>start,
                data_i=> data_i, key=> key, 
                data_o=> data_o , config=>config
            ); 
    
    clk     <= not clk after 5 ns;
    reset   <= '1', '0' after 20 ns;
    data_i  <= x"A5A5A5A501234567FEDCBA985A5A5A5A"; 
    key     <= x"DEADBEEF0123456789ABCDEFDEADBEEF";
    start <= '1', '0' after 30 ns;
    config <= '0', after 10000 ns

end architecture;