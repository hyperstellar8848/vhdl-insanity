LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY test IS
END test;
 
architecture Behavioral of test is

    component if_code ------------------------------------------- rename to test other modules
        Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
               B : in STD_LOGIC_VECTOR (2 downto 0);
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC_VECTOR (2 downto 0);
               Cout : out STD_LOGIC);
    end component;

    signal A : STD_LOGIC_VECTOR (2 downto 0);
    signal B : STD_LOGIC_VECTOR (2 downto 0);
    signal Cin : STD_LOGIC;
    signal Sum : STD_LOGIC_VECTOR (2 downto 0);
    signal Cout : STD_LOGIC;

begin

    UUT: if_code  -------------------------------------------- rename to test other modules
        port map(
            A => A,
            B => B,
            Cin => Cin,
            Sum => Sum,
            Cout => Cout
        );

    process
    begin

        A <= "000"; B <= "000"; Cin <= '0';
        wait for 10 ns;

        A <= "001"; B <= "010"; Cin <= '0';
        wait for 10 ns;

        A <= "011"; B <= "001"; Cin <= '1';
        wait for 10 ns;

        A <= "111"; B <= "001"; Cin <= '0';
        wait for 10 ns;

        A <= "101"; B <= "011"; Cin <= '1';
        wait for 10 ns;

        wait;

    end process;

END;
