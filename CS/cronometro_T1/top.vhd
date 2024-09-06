LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY top IS
  PORT (
    clock, reset : IN STD_LOGIC;
    stop, split, start : IN STD_LOGIC;
    an, dec_ddp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END top;

ARCHITECTURE arch_top OF top IS
  SIGNAL rstn_i : STD_LOGIC;
  SIGNAL clock1cs, out_250ms : STD_LOGIC;
  SIGNAL enable, do_split : STD_LOGIC;
  SIGNAL centsec, hour : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL second, minute : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL deb_stop, deb_reset : STD_LOGIC;
  SIGNAL deb_split, deb_start : STD_LOGIC;
  SIGNAL d1, d2, d3, d4, d5, d6, d7, d8 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL fsm_state : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
  rstn_i <= not reset;

  debounce_stop : ENTITY work.debounce
    GENERIC MAP(DELAY => 500000)
    PORT MAP(
      clk_i => clock,
      rstn_i => rstn_i,
      key_i => stop,
      debkey_o => deb_stop
    );

  debounce_split : ENTITY work.debounce
    GENERIC MAP(DELAY => 500000)
    PORT MAP(
      clk_i => clock,
      rstn_i => rstn_i,
      key_i => split,
      debkey_o => deb_split
    );

  debounce_start : ENTITY work.debounce
    GENERIC MAP(DELAY => 500000)
    PORT MAP(
      clk_i => clock,
      rstn_i => rstn_i,
      key_i => start,
      debkey_o => deb_start
    );
  clock_div_inst : ENTITY work.clock_divider
    PORT MAP(
      clock => clock,
      reset => reset,
      clock1cs => clock1cs,
      out_250ms => out_250ms
    );

  fsm_inst : ENTITY work.fsm
    PORT MAP(
      clock => clock,
      reset => reset,
      start => deb_start,
      stop => deb_stop,
      split => deb_split,
      enable => enable,
      do_split => do_split,
      fsm_state => fsm_state
    );

  time_counters_inst : ENTITY work.time_counters
    PORT MAP(
      clock1cs => clock1cs,
      reset => reset,
      enable => enable,
      do_split => do_split,
      centsec => centsec,
      second => second,
      minute => minute,
      hour => hour,
      fsm_state => fsm_state
    );

  d1 <= ('0' & centsec(3 DOWNTO 0) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & centsec(3 DOWNTO 0) & '1');
  d2 <= ('0' & centsec(7 DOWNTO 4) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & centsec(7 DOWNTO 4) & '1');
  d3 <= ('0' & second(3 DOWNTO 0) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & second(3 DOWNTO 0) & '1');
  d4 <= ('0' & '0' & second(6 DOWNTO 4) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & '0' & second(6 DOWNTO 4) & '1');
  d5 <= ('0' & minute(3 DOWNTO 0) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & minute(3 DOWNTO 0) & '1');
  d6 <= ('0' & '0' & minute(6 DOWNTO 4) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & '0' & minute(6 DOWNTO 4) & '1');
  d7 <= ('0' & hour(3 DOWNTO 0) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & hour(3 DOWNTO 0) & '1');
  d8 <= ('0' & hour(7 DOWNTO 4) & '1') WHEN (fsm_state = "101" OR fsm_state = "110") AND out_250ms = '0' ELSE
    ('1' & hour(7 DOWNTO 4) & '1');

  dspl_drv_inst : ENTITY work.dspl_drv_8dig
    PORT MAP(
      clock => clock,
      reset => reset,
      d1 => d1,
      d2 => d2,
      d3 => d3,
      d4 => d4,
      d5 => d5,
      d6 => d6,
      d7 => d7,
      d8 => d8,
      an => an,
      dec_ddp => dec_ddp
    );

END arch_top;