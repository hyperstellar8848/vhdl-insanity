library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity with_select_code is
    Port ( A : in  STD_LOGIC_VECTOR (2 downto 0);
           B : in  STD_LOGIC_VECTOR (2 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (2 downto 0);
           Cout : out  STD_LOGIC);
end with_select_code;

architecture Behavioral of with_select_code is
    signal temp : STD_LOGIC_VECTOR (3 downto 0);
    signal result0, result1 : STD_LOGIC_VECTOR (3 downto 0);
begin
    result0 <= ('0' & A) + ('0' & B);
    result1 <= ('0' & A) + ('0' & B) + "0001";
    
    with Cin select
        temp <= result0 when '0',
                result1 when '1',
                "0000" when others;
    
    Sum <= temp(2 downto 0);
    Cout <= temp(3);
end Behavioral;
