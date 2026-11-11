library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder_8to3 is
    port (
        d : in  std_logic_vector(7 downto 0); 
        y : out std_logic_vector(2 downto 0); 
        v : out std_logic                     
    );
end entity priority_encoder_8to3;

architecture structural of priority_encoder_8to3 is
    component pe4to2 is
        port (
            r : in  std_logic_vector(3 downto 0);
            q : out std_logic_vector(1 downto 0);
            v : out std_logic
        );
    end component;

    component inv is
        port (a : in std_logic; y : out std_logic);
    end component;

    component and2 is
        port (a : in std_logic; b : in std_logic; y : out std_logic);
    end component;

    component or2 is
        port (a : in std_logic; b : in std_logic; y : out std_logic);
    end component;

    signal h_q     : std_logic_vector(1 downto 0);  
    signal v_high  : std_logic;                    
    signal l_q     : std_logic_vector(1 downto 0);  
    signal v_low   : std_logic;                    

    signal n_vhigh : std_logic;  
    signal mux1    : std_logic;  
    signal mux0    : std_logic;  

begin
    pe_high: pe4to2 port map (
        r => d(7 downto 4),
        q => h_q,
        v => v_high
    );

    pe_low: pe4to2 port map (
        r => d(3 downto 0),
        q => l_q,
        v => v_low
    );


    g_nvh: inv port map (a => v_high, y => n_vhigh);

    y(2) <= v_high;

    g_mux1: and2 port map (a => n_vhigh, b => l_q(1), y => mux1);
    g_y1:   or2  port map (a => h_q(1),  b => mux1,   y => y(1));

    g_mux0: and2 port map (a => n_vhigh, b => l_q(0), y => mux0);
    g_y0:   or2  port map (a => h_q(0),  b => mux0,   y => y(0));

    g_v: or2 port map (a => v_high, b => v_low, y => v);

end architecture structural;
