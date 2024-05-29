library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xtea_enc_tb is
end entity;

architecture xtea_enc_tb of xtea_enc_tb is
signal clk, reset,start   :  std_logic;
signal data_i, key  :  std_logic_vector (127 downto 0);
signal data_o  :  std_logic_vector (127 downto 0);
begin
    DUT: work.xtea_enc 
    port map (clk => clk, reset => reset, start=>start ,data_i=> data_i, key=> key, data_o=> data_o ); 
    
    reset <= '1','0' after 10 ns;
    
    process
    begin
    clk <= '0', not clk after 10 ns;
    end process;

end architecture;