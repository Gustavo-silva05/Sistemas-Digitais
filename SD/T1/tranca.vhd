library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity tranca is
    port (
        clk, rst, configurar, valido : in std_logic;
        entrada : in std_logic_vector(3 downto 0);
        tranca, configurado, alarme : out std_logic
    );
end entity;

architecture tranca of tranca is

    type state is (DESCONFIG, RE, RE0, RE01, RE010, ESPERA, CONFIG, VAL0, VAL01, VAL010, TIMER_LIBERADO, ALARME_ON, LIBERADO);
    signal EA, PE : state;
    signal control, vezes, tentativas, senha : integer;
    signal alarme_lig : std_logic;
    signal senha1, senha2, senha3 : std_logic_vector(3 downto 0);
    signal timer_s : std_logic_vector(15 downto 0);

begin
    -- precesso clock, reset e troca de estado;
    seq : process (clk, rst)
    begin
        if rst = '1' then
            EA <= DESCONFIG;
        elsif rising_edge(clk) then
            EA <= PE;
        end if;
    end process;
    -- PREOCESSO DE INCREMENTO DO TIMER DE DESTRAVA
    process (clk, rst)
    begin
        if rst = '1' then
            timer_s <= (others => '0');
        elsif rising_edge(clk) then
            if EA = TIMER_LIBERADO then
                timer_s <= timer_s + '1';
            elsif EA = CONFIG then
                timer_s <= (others => '0');
            end if;
        end if;
    end process;

    -- processo de troca de estado;
    comb : process (EA, valido, configurar, entrada)
    begin
        case EA is
            when DESCONFIG => -- maquina resetada.
                if configurar = '1' then
                    PE <= RE;
                    control <= 0;
                else
                    PE <= DESCONFIG;
                end if;
            when RE =>
                if valido = '0' then -- configuração inicial
                    PE <= RE0;
                else
                    PE <= RE;
                end if;
            when RE0 =>
                if valido = '1' then -- leitura do valido 
                    PE <= RE01;
                else
                    PE <= RE0;
                end if;

            when RE01 =>
                if valido = '0' then
                    PE <= RE010; -- leitura do valido 
                else
                    PE <= RE01;
                end if;

            when RE010 =>
                if control = 0 then
                    vezes <= conv_integer(unsigned(entrada));
                    control <= control + 1;
                    PE <= RE;
                elsif control = 1 then
                    senha1 <= entrada;
                    control <= control + 1; --
                    PE <= RE; -- definição de senhas
                elsif control = 2 then --
                    senha2 <= entrada;
                    control <= control + 1;
                    PE <= RE;
                elsif control = 3 then
                    senha3 <= entrada;
                    control <= control + 1;
                    PE <= RE;
                else
                    PE <= ESPERA;
                end if;

            when ESPERA => --  aguarda botão configurar ir a 0;
                if configurar = '0' then
                    PE <= CONFIG;
                    tentativas <= 0;
                    senha <= 1;
                    alarme_lig <= '0';
                else
                    PE <= ESPERA;
                end if;

            when CONFIG => --  maquina configurada e aguarda valido ir a 0;
                if tentativas < vezes then
                    if valido = '0' then
                        PE <= VAL0;
                    else
                        PE <= CONFIG;
                    end if;
                else
                    PE <= ALARME_ON;
                end if;
            when VAL0 => -- agurda valido ir a 1;
                if valido = '1' then
                    PE <= VAL01;
                else
                    PE <= VAL0;
                end if;
            when VAL01 => -- agurda valido ir a 0;
                if valido = '0' then
                    PE <= VAL010;
                else
                    PE <= VAL01;
                end if;
            when VAL010 =>
                if senha = 1 then --  verifica senha1
                    if entrada = senha1 then
                        senha <= senha + 1;
                        PE <= CONFIG;
                    else
                        tentativas <= tentativas + 1;
                        PE <= CONFIG;
                    end if;
                elsif senha = 2 then -- verifica senha2
                    if entrada = senha2 then
                        senha <= senha + 1;
                        PE <= CONFIG;
                    else
                        tentativas <= tentativas + 1;
                        senha <= 1;
                        PE <= CONFIG;
                    end if;
                elsif senha = 3 then -- verifica senha3
                    if entrada = senha3 then
                        PE <= LIBERADO;
                    else
                        tentativas <= tentativas + 1;
                        senha <= 1;
                        PE <= CONFIG;
                    end if;
                end if;

            when ALARME_ON =>
                if valido = '0' then
                    PE <= VAL0;
                    alarme_lig <= '1';
                else
                    PE <= ALARME_ON;
                end if;

            when LIBERADO =>
                PE <= TIMER_LIBERADO;
                tentativas <= 0;
                senha <= 1;
                alarme_lig <= '0';

            when TIMER_LIBERADO =>
                if timer_s > x"7530" then -- timer quando o estado esta LIBERADO
                    PE <= CONFIG;
                else
                    PE <= TIMER_LIBERADO;
                end if;

            when others =>
                PE <= DESCONFIG;
        end case;
    end process;

    saidas : process (EA, alarme_lig)
    begin
        case EA is
            when DESCONFIG =>
                tranca <= '1';
                configurado <= '0';
                alarme <= '0';

            when RE =>
                tranca <= '1';
                configurado <= '0';
                alarme <= '0';

            when RE0 =>
                tranca <= '1';
                configurado <= '0';
                alarme <= '0';

            when RE01 =>
                tranca <= '1';
                configurado <= '0';
                alarme <= '0';

            when RE010 =>
                tranca <= '1';
                configurado <= '0';
                alarme <= '0';

            when ESPERA =>
                tranca <= '1';
                configurado <= '0';
                alarme <= '0';

            when CONFIG =>
                tranca <= '1';
                configurado <= '1';
                if alarme_lig = '1' then
                    alarme <= '1';
                else
                    alarme <= '0';
                end if;

            when VAL0 =>
                tranca <= '1';
                configurado <= '1';
                if alarme_lig = '1' then
                    alarme <= '1';
                else
                    alarme <= '0';
                end if;

            when VAL01 =>
                tranca <= '1';
                configurado <= '1';
                if alarme_lig = '1' then
                    alarme <= '1';
                else
                    alarme <= '0';
                end if;

            when VAL010 =>
                tranca <= '1';
                configurado <= '1';
                if alarme_lig = '1' then
                    alarme <= '1';
                else
                    alarme <= '0';
                end if;

            when ALARME_ON =>
                tranca <= '1';
                configurado <= '1';
                alarme <= '1';

            when LIBERADO =>
                tranca <= '0';
                configurado <= '1';
                alarme <= '0';

            when TIMER_LIBERADO =>
                tranca <= '0';
                configurado <= '1';
                alarme <= '0';

            when others =>
                tranca <= '1';
                configurado <= '0';
                alarme <= '0';

        end case;
    end process;
end architecture;