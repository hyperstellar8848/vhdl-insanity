-- type: fa_result_t
-- subtype: bit_t
library ieee;
use ieee.std_logic_1164.all;

entity full_adder_simple is
    port(
        a, b, cin : in  std_logic;  
        sum, cout : out std_logic   
    );
end entity;

architecture rtl of full_adder_simple is
    subtype bit_t is std_logic;

    type fa_result_t is record
        s : bit_t;  -- sum
        c : bit_t;  -- carry out
    end record;

    signal r : fa_result_t;  -- a record signal

begin

    r.s <= a xor b xor cin;
    r.c <= (a and b) or (a and cin) or (b and cin);

    sum  <= r.s;
    cout <= r.c;
end architecture;
