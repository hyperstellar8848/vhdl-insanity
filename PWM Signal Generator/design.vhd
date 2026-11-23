library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_Generator is
    Port (
        clk     : in STD_LOGIC;
        reset   : in STD_LOGIC;
        duty    : in INTEGER range 0 to 100;
        pwm_out : out STD_LOGIC
    );
end PWM_Generator;

architecture Behavioral of PWM_Generator is
    signal counter : INTEGER range 0 to 99 := 0;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            pwm_out <= '0';

        elsif rising_edge(clk) then
            if counter = 99 then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;

            if counter < duty then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
