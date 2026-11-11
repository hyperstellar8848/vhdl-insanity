library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_multiplier is
    Port (
        A : in  STD_LOGIC_VECTOR(5 downto 0);
        B : in  STD_LOGIC_VECTOR(4 downto 0);
        P : out STD_LOGIC_VECTOR(10 downto 0)
    );
end array_multiplier;

architecture Structural of array_multiplier is

    type pp_array_t is array (0 to 4) of
        STD_LOGIC_VECTOR(10 downto 0);

    type sum_array_t is array (0 to 5) of
        STD_LOGIC_VECTOR(10 downto 0);

    type carry_array_t is array (0 to 4) of
        STD_LOGIC_VECTOR(11 downto 0);

    signal pp : pp_array_t;
    signal sum_stage : sum_array_t;
    signal carry : carry_array_t;

begin

    -- Generate partial products
    process(A, B)
        variable temp : STD_LOGIC_VECTOR(10 downto 0);
    begin
        for i in 0 to 4 loop
            temp := (others => '0');

            for j in 0 to 5 loop
                temp(j+i) := A(j) and B(i);
            end loop;

            pp(i) <= temp;
        end loop;
    end process;

    -- Initialize first stage
    sum_stage(0) <= (others => '0');

    -- Generate full adders
    stage_gen: for i in 0 to 4 generate

        carry(i)(0) <= '0';

        bit_gen: for j in 0 to 10 generate

            -- Full adder sum
            sum_stage(i+1)(j) <=
                sum_stage(i)(j) xor pp(i)(j) xor carry(i)(j);

            -- Full adder carry
            carry(i)(j+1) <=
                (sum_stage(i)(j) and pp(i)(j)) or
                (sum_stage(i)(j) and carry(i)(j)) or
                (pp(i)(j) and carry(i)(j));

        end generate bit_gen;

    end generate stage_gen;

    -- Assign final result
    P <= sum_stage(5);

end Structural;
