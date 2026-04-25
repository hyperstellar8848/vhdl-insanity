-- Engineer:        hyperstellar
-- Create Date:     06:59:07 04/25/2026  
-- Module Name:     Full_Adder_1_bit - Structural
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder_1_bit is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        CIN  : in  STD_LOGIC;
        SUM  : out STD_LOGIC;
        COUT : out STD_LOGIC
    );
end Full_Adder_1_bit;

architecture Structural of Full_Adder_1_bit is

    signal temp0, temp1, temp2 : STD_LOGIC;

begin

    temp0 <= A xor B;
    SUM   <= temp0 xor CIN;

    temp1 <= A and B;
    temp2 <= temp0 and CIN;

    COUT  <= temp1 or temp2;

end Structural;
