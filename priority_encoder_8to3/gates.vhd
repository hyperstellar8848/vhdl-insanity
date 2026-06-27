library ieee;
use ieee.std_logic_1164.all;

-- not
entity inv is
    port (
        a : in  std_logic;
        y : out std_logic
    );
end entity inv;

architecture rtl of inv is
begin
    y <= not a;
end architecture rtl;

--- and 2
library ieee;
use ieee.std_logic_1164.all;

entity and2 is
    port (
        a : in  std_logic;
        b : in  std_logic;
        y : out std_logic
    );
end entity and2;

architecture rtl of and2 is
begin
    y <= a and b;
end architecture rtl;

-- or 2
library ieee;
use ieee.std_logic_1164.all;

entity or2 is
    port (
        a : in  std_logic;
        b : in  std_logic;
        y : out std_logic
    );
end entity or2;

architecture rtl of or2 is
begin
    y <= a or b;
end architecture rtl;

-- or 3
library ieee;
use ieee.std_logic_1164.all;

entity or3 is
    port (
        a : in  std_logic;
        b : in  std_logic;
        c : in  std_logic;
        y : out std_logic
    );
end entity or3;

architecture rtl of or3 is
begin
    y <= a or b or c;
end architecture rtl;

-- or 4
library ieee;
use ieee.std_logic_1164.all;

entity or4 is
    port (
        a : in  std_logic;
        b : in  std_logic;
        c : in  std_logic;
        d : in  std_logic;
        y : out std_logic
    );
end entity or4;

architecture rtl of or4 is
begin
    y <= a or b or c or d;
end architecture rtl;
