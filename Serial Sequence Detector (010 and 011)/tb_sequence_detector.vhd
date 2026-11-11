

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_sequence_detector is
end entity tb_sequence_detector;


architecture Simulation of tb_sequence_detector is


    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
    signal din   : std_logic := '0';

    signal y010  : std_logic;
    signal y011  : std_logic;


    constant CLK_PERIOD : time := 10 ns;

begin


    UUT : entity work.sequence_detector(Behavioral)
        port map (
            clk   => clk,
            reset => reset,
            din   => din,
            y010  => y010,
            y011  => y011
        );




    clock_generation : process
    begin

        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;

            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;

    end process clock_generation;

        procedure send_bit (
            constant bit_value : in std_logic;
            constant exp_y010  : in std_logic;
            constant exp_y011  : in std_logic
        ) is
        begin

            wait until falling_edge(clk);

            din <= bit_value;

            wait until rising_edge(clk);

            wait for 1 ns;

            assert y010 = exp_y010
                report
                    "ERROR: y010 mismatch. Input bit = "
                    & std_logic'image(bit_value)
                    & ", expected = "
                    & std_logic'image(exp_y010)
                    & ", actual = "
                    & std_logic'image(y010)
                severity error;

            -- Verify the output for pattern 011.
            assert y011 = exp_y011
                report
                    "ERROR: y011 mismatch. Input bit = "
                    & std_logic'image(bit_value)
                    & ", expected = "
                    & std_logic'image(exp_y011)
                    & ", actual = "
                    & std_logic'image(y011)
                severity error;

            assert not (y010 = '1' and y011 = '1')
                report
                    "ERROR: Both detection outputs are high!"
                severity error;

        end procedure send_bit;


    begin



        report "TEST 0: Applying initial reset"
            severity note;

        reset <= '1';

        wait for 2 ns;

        assert y010 = '0' and y011 = '0'
            report "ERROR: Outputs are not low during reset"
            severity error;

        wait until rising_edge(clk);
        wait for 1 ns;

        reset <= '0';

        report "Initial reset completed"
            severity note;



        report "TEST 1: Detecting sequence 010"
            severity note;

        send_bit('0', '0', '0');
        send_bit('1', '0', '0');
        send_bit('0', '1', '0');




        report "TEST 2: Detecting sequence 011"
            severity note;

        reset <= '1';
        wait for 2 ns;

        assert y010 = '0' and y011 = '0'
            report "ERROR: Reset did not clear the outputs"
            severity error;

        wait until rising_edge(clk);
        wait for 1 ns;
        reset <= '0';

        send_bit('0', '0', '0');
        send_bit('1', '0', '0');
        send_bit('1', '0', '1');

        report "TEST 3: Overlap test using 01010"
            severity note;

        reset <= '1';
        wait for 2 ns;
        wait until rising_edge(clk);
        wait for 1 ns;
        reset <= '0';

        send_bit('0', '0', '0');
        send_bit('1', '0', '0');
        send_bit('0', '1', '0');
        send_bit('1', '0', '0');
        send_bit('0', '1', '0');



        report "TEST 4: Both patterns using 01011"
            severity note;

        reset <= '1';
        wait for 2 ns;
        wait until rising_edge(clk);
        wait for 1 ns;
        reset <= '0';

        send_bit('0', '0', '0');
        send_bit('1', '0', '0');
        send_bit('0', '1', '0');
        send_bit('1', '0', '0');
        send_bit('1', '0', '1');




        report "TEST 5: Reset during operation"
            severity note;

        reset <= '1';
        wait for 2 ns;
        wait until rising_edge(clk);
        wait for 1 ns;
        reset <= '0';

        send_bit('0', '0', '0');
        send_bit('1', '0', '0');

        wait until falling_edge(clk);
        wait for 1 ns;
        reset <= '1';

        wait for 1 ns;

        assert y010 = '0' and y011 = '0'
            report "ERROR: Outputs did not clear asynchronously"
            severity error;

        wait until rising_edge(clk);
        wait for 1 ns;
        reset <= '0';
        send_bit('0', '0', '0');


        report "SUCCESS: All sequence detector tests passed!"
            severity note;

        wait;

    end process stimulus;

end architecture Simulation;
