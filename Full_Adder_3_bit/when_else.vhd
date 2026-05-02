library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity when_else_code is
    Port ( A : in  STD_LOGIC_VECTOR (2 downto 0);
           B : in  STD_LOGIC_VECTOR (2 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (2 downto 0);
           Cout : out  STD_LOGIC);
end when_else_code;

architecture Behavioral of when_else_code is
    signal temp : STD_LOGIC_VECTOR (3 downto 0);
begin
    temp <= ('0' & A) + ('0' & B) + "0001" when Cin = '1' else
            ('0' & A) + ('0' & B);
    
    Sum <= temp(2 downto 0);
    Cout <= temp(3);
end Behavioral;
