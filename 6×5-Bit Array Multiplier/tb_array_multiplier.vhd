library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_array_multiplier is
end tb_array_multiplier;

architecture Simulation of tb_array_multiplier is

    signal A : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal B : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal P : STD_LOGIC_VECTOR(10 downto 0);

begin

    -- Instantiate the multiplier
    uut: entity work.array_multiplier
        port map (
            A => A,
            B => B,
            P => P
        );

    -- Apply test cases
    stim_proc: process
    begin

        for i in 0 to 63 loop
            for j in 0 to 31 loop

                A <= STD_LOGIC_VECTOR(to_unsigned(i, 6));
                B <= STD_LOGIC_VECTOR(to_unsigned(j, 5));

                wait for 10 ns;

                -- Check multiplication result
                assert unsigned(P) = to_unsigned(i*j, 11)
                    report "Multiplication error detected!"
                    severity error;

            end loop;
        end loop;

        report "All tests passed"
            severity note;

        wait;
    end process;

end Simulation;
