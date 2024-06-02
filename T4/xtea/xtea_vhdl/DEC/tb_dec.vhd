library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_dec is
end entity;

architecture tb_dec of tb_dec is
signal clk          :   std_logic := '0';
signal reset, start :   std_logic;
signal data_i, key  :   std_logic_vector (127 downto 0);
signal data_o       :   std_logic_vector (127 downto 0);
begin
    encriptador : entity work.xtea_dec 
    port map (  clk => clk, reset => reset, start=>start,
                data_i=> data_i, key=> key, 
                data_o=> data_o 
            ); 
    
    clk     <= not clk after 5 ns;
    reset   <= '1', '0' after 20 ns;
    data_i  <= x"089975E92555F334CE76E4F24D932AB3"; 
    key     <= x"DEADBEEF0123456789ABCDEFDEADBEEF";
    start <= '1', '0' after 30 ns;

end architecture;