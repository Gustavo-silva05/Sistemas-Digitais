LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE tb OF tb IS
    SIGNAL clock : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL stop, split, start : STD_LOGIC;
    SIGNAL an, dec_ddp : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    DUT : ENTITY work.top
        PORT MAP(clock => clock, reset => reset, stop => stop, split => split, start => start, an => an, dec_ddp => dec_ddp);
    clock <= NOT clock AFTER 5 ns;
    reset <= '0', '1' AFTER 20 ns, '0' AFTER 100 ns , '1' after 1000_000 ns, '0' after 1100_000 ns;

    start <= '0',
        '1' AFTER 150000 ns,
        '0' AFTER 220000 ns,
        '1' AFTER 500000 ns,
        '0' AFTER 515000 ns;

    stop <= '0',
        '1' AFTER 280000 ns,
        '0' AFTER 350000 ns;

    split <= '0',
        '1' AFTER 600000 ns,
        '0' after 615000 ns,
        '1' after 750000 ns,
        '0' after 800000 ns;

END tb;