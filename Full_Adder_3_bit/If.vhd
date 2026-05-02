library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity if_code is
    Port ( A : in  STD_LOGIC_VECTOR (2 downto 0);
           B : in  STD_LOGIC_VECTOR (2 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (2 downto 0);
           Cout : out  STD_LOGIC);
end if_code;

architecture Behavioral of if_code is
    signal temp : STD_LOGIC_VECTOR (3 downto 0);
begin
    process(A, B, Cin)
    begin
        if (Cin = '0') then
            temp <= ('0' & A) + ('0' & B);
        else
            temp <= ('0' & A) + ('0' & B) + "0001";
        end if;
    end process;
    
    Sum <= temp(2 downto 0);
    Cout <= temp(3);
end Behavioral;
