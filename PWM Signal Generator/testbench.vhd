library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_PWM_Generator is
end TB_PWM_Generator;

architecture Simulation of TB_PWM_Generator is

    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '1';
    signal duty    : INTEGER range 0 to 100 := 25;
    signal pwm_out : STD_LOGIC;

begin

    uut: entity work.PWM_Generator
        port map (
            clk     => clk,
            reset   => reset,
            duty    => duty,
            pwm_out => pwm_out
        );

    clk_process: process
    begin
        for i in 0 to 519 loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    stimulus: process
    begin
        wait for 20 ns;
        reset <= '0';

        duty <= 25;
        wait for 1000 ns;

        duty <= 50;
        wait for 1000 ns;

        duty <= 75;
        wait for 1000 ns;

        duty <= 100;
        wait for 1000 ns;

        duty <= 0;
        wait for 1000 ns;

        wait;
    end process;

end Simulation;
