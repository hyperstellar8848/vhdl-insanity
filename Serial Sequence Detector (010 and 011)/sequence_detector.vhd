

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sequence_detector is
    port (
        clk   : in  std_logic;  
        reset : in  std_logic;  
        din   : in  std_logic;  

        y010  : out std_logic; 
        y011  : out std_logic   
    );
end entity sequence_detector;


architecture Behavioral of sequence_detector is

    type state_type is (
        S0,
        S1,
        S01,
        DET010,
        DET011
    );


    signal current_state : state_type := S0;

    signal next_state : state_type := S0;

begin

    state_register : process(clk, reset)
    begin
        if reset = '1' then


            current_state <= S0;

        elsif rising_edge(clk) then

            current_state <= next_state;

        end if;
    end process state_register;


    next_state_logic : process(current_state, din)
    begin


        next_state <= S0;

        case current_state is

            when S0 =>
                if din = '0' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;


            when S1 =>
                if din = '0' then
                    next_state <= S1;
                else
                    next_state <= S01;
                end if;


            when S01 =>
                if din = '0' then
                    next_state <= DET010;
                else
                    next_state <= DET011;
                end if;




            when DET010 =>
                if din = '0' then
                    next_state <= S1;
                else
                    next_state <= S01;
                end if;


            when DET011 =>
                if din = '0' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;




            when others =>
                next_state <= S0;

        end case;

    end process next_state_logic;


    output_logic : process(current_state)
    begin

        y010 <= '0';
        y011 <= '0';

        case current_state is

            when DET010 =>
                y010 <= '1';

            when DET011 =>
                y011 <= '1';

            when others =>
                null;

        end case;

    end process output_logic;

end architecture Behavioral;
