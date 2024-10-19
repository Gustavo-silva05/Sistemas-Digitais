library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity switch_axis is
	generic (
		DATA_WIDTH : integer := 8
	);
	port (
		-- external interface signals
		switches_i : in std_logic_vector(DATA_WIDTH-1 downto 0);
		-- AXI stream interface signals
		axis_aclk_i : in std_logic;
		axis_aresetn_i : in std_logic;
		-- master axi stream interface
		m_axis_tready_i : in std_logic;
		m_axis_tvalid_o : out  std_logic;
		m_axis_tdata_o : out  std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end switch_axis;

architecture switch_arch of switch_axis is
	signal tvalid : std_logic;
	type state_type is (st_idle, st_data);
	signal state : state_type;
	signal data : std_logic_vector(DATA_WIDTH-1 downto 0);
begin
	m_axis_tvalid_o <= tvalid;
	data <= switches_i;

	kbd_process: process(axis_aclk_i) is
	begin
		if axis_aresetn_i = '0' then
			tvalid <= '0';
		elsif axis_aclk_i'event and axis_aclk_i = '1' then
			case state is
				when st_idle =>
					tvalid <= '1';
					if m_axis_tready_i = '1' then
						m_axis_tdata_o <= data;
						state <= st_data;
					end if;
				when st_data =>
					tvalid <= '0';
					state <= st_idle;
			end case;
		end if;
	end process;

end switch_arch;
