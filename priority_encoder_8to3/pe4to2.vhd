library ieee;
use ieee.std_logic_1164.all;

entity pe4to2 is
    port (
        r : in  std_logic_vector(3 downto 0); 
        q : out std_logic_vector(1 downto 0);  -- encoded output 2 bit
        v : out std_logic                   
    );
end entity pe4to2;

architecture structural of pe4to2 is

    component inv is
        port (a : in std_logic; y : out std_logic);
    end component;

    component and2 is
        port (a : in std_logic; b : in std_logic; y : out std_logic);
    end component;

    component or2 is
        port (a : in std_logic; b : in std_logic; y : out std_logic);
    end component;

    component or4 is
        port (a : in std_logic; b : in std_logic; c : in std_logic;
              d : in std_logic; y : out std_logic);
    end component;


    signal not_r2 : std_logic;  -- NOT r(2)
    signal and_q0 : std_logic;  -- r(1) AND NOT r(2)

begin
    -- q(1) = r(3) OR r(2)
    g_q1: or2 port map (a => r(3), b => r(2), y => q(1));

    -- q(0) = r(3) OR (r(1) AND NOT r(2))
    g_not_r2: inv  port map (a => r(2), y => not_r2);
    g_and_q0: and2 port map (a => r(1), b => not_r2, y => and_q0);
    g_q0:     or2  port map (a => r(3), b => and_q0, y => q(0));

    -- v = r(3) OR r(2) OR r(1) OR r(0)
    g_v: or4 port map (a => r(3), b => r(2), c => r(1), d => r(0), y => v);

end architecture structural;
