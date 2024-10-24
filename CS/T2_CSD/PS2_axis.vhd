library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ps2_axis is
    generic (
        DATA_WIDTH : integer := 8
    );
    port (
        -- AXI stream interface signals
        axis_aclk_i     : in std_logic;
        axis_aresetn_i  : in std_logic;
        m_axis_tready_i : in std_logic;
        m_axis_tvalid_o : out std_logic;
        m_axis_tdata_o  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        
        -- PS/2 interface signals (conectados aos pinos definidos no .xdc)
        ps2_clk_i       : in std_logic;  -- Pino do clock PS/2
        ps2_data_i      : in std_logic   -- Pino do dado PS/2
    );
end ps2_axis;

architecture rtl of ps2_axis is
    -- Sinais do driver PS/2
    signal ps2_code_new : std_logic;
    signal ps2_code     : std_logic_vector(7 downto 0);

    -- Estados da máquina de estados
    type state_type is (st_idle, st_data);
    signal state       : state_type := st_idle;
    signal tvalid      : std_logic := '0';
    signal data        : std_logic_vector(DATA_WIDTH-1 downto 0);

begin
    -- Saída de validação do AXI
    m_axis_tvalid_o <= tvalid;

    -- Instanciação do driver PS/2
    ps2_driver: entity work.ps2_keyboard
        generic map (
            clk_freq => 50_000_000,        -- Frequência do clock do sistema
            debounce_counter_size => 8     -- Parâmetro de debounce
        )
        port map (
            clk          => axis_aclk_i,   -- O clock será o mesmo da interface AXI
            ps2_clk      => ps2_clk_i,     -- Sinal do clock PS/2 vindo do pino mapeado no .xdc
            ps2_data     => ps2_data_i,    -- Sinal de dados PS/2 vindo do pino mapeado no .xdc
            ps2_code_new => ps2_code_new,  -- Indica que um novo código foi capturado
            ps2_code     => ps2_code       -- Código da tecla PS/2 capturado
        );

    -- Máquina de estados para controle da transmissão via AXI
    process(axis_aclk_i) is
    begin
        if axis_aresetn_i = '0' then
            tvalid <= '0';
            state <= st_idle;
        elsif rising_edge(axis_aclk_i) then
            case state is
                when st_idle =>
                    if ps2_code_new = '1' then
                        -- Novo código PS/2 disponível
                        tvalid <= '1';
                        data <= ps2_code; -- Armazena o código da tecla
                        if m_axis_tready_i = '1' then
                            -- Transmite o código PS/2 via AXI
                            m_axis_tdata_o <= data;
                            state <= st_data;
                        end if;
                    end if;
                when st_data =>
                    -- Reseta a transmissão após enviar o dado
                    tvalid <= '0';
                    state <= st_idle;
            end case;
        end if;
    end process;

end rtl;