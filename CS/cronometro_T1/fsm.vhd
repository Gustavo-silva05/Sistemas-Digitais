library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fsm is
    port (
        clock, reset       : in std_logic;
        start, stop, split : in std_logic;
        an: out STD_LOGIC_VECTOR (7 downto 0);
		dec_ddp: out STD_LOGIC_VECTOR (7 downto 0)
    );
end fsm;

architecture arch of fsm is
    type states is (S_RESET, S_START, S_STOP_HIGH, S_STOP, S_SPLIT_HIGH, S_SPLIT);
    signal EA, PE : states;
    signal rst : std_logic;
    signal start_d, stop_d, split_d : std_logic;
    signal clock1cs : std_logic;
    signal centsec, hour: std_logic_vector(7 downto 0);
    signal second, minute:  std_logic_vector(6 downto 0)
begin

    process (clock, reset)
    begin
        if reset = '1' then
            EA <= S_RESET;
        elsif rising_edge(clock) then
            EA <= PE;
        end if;
    end process;

    process (EA, start, stop, split)
    begin
        case EA is
            when S_RESET =>
                if (start_d = '1') then
                    PE <= S_START;
                else
                    PE <= S_RESET;
                end if;

            when S_START =>
                if (stop_d = '1') then
                    PE <= S_STOP_HIGH;
                else if (split_d = '1') then
                    PE <= S_SPLIT_HIGH;
                else
                    PE <= S_START;
                end if;

            when S_STOP_HIGH =>
                if (stop_d = '0') then
                    PE <= S_STOP;
                end if;

            when S_STOP =>
                if (stop_d = '1') then
                    PE <= S_START;
                else
                    PE <= S_STOP;
                end if;
  
            when S_SPLIT_HIGH =>
                if (split_d = '0') then
                    PE <= S_SPLIT;
                end if;
                
            when S_SPLIT =>  
                if (split_d = '1') then
                    PE <= S_START;
                else
                    PE <= S_SPLIT;
                end if;

        end case;
    end process;

    rst <= not reset;

    contador : entity work.time_counters
    port map(clock1cs=>clock1cs, reset=>reset, start=>start_d, centsec=>centsec, hour=>hour, second=>second, minute=>minute);
        
    display: entity work.dspl_drv_8dig
    port map (
        clock=> clock,
		reset=> reset,
		d8=> '1'    & centsec(3 downto 0)   & '0', 
		d7=> '1'    & centsec(7 downto 4)   & '1',
		d6=> '1'    & second(3 downto 0)    & '0',
		d5=> "10"   & second(6 downto 4)    & '0',
		d4=> '1'    & minute(3 downto 0)    & '1',
		d3=> "10"   & minute(6 downto 4)    & '0',
		d2=> '1'    & hour  (3 downto 0)    & '1',
		d1=> '1'    & hour  (7 downto 4)    & '0',
		an=> an, 
		dec_ddp=> dec_ddp
    );

    dcm : entity work.clock_divider
        port map (clock=> clk, reset=>reset, clock1cs=>clock1cs);
    
    deb_start : entity work.debounce
        port map(clk_i=> clk, rstn_i => rst, key_i=> start, debkey_o=> start_d);

    deb_stop : entity work.debounce
        port map(clk_i=> clk, rstn_i => rst, key_i=> stop, debkey_o=> stop_d);

    deb_split : entity work.debounce
        port map(clk_i=> clk, rstn_i => rst, key_i=> split, debkey_o=> split_d);

end arch;