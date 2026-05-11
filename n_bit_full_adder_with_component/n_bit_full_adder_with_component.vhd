library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-----------------------------------------------------------
-- 1. HALF ADDER
-----------------------------------------------------------
entity half_adder is
    Port ( a : in  STD_LOGIC;   
           b : in  STD_LOGIC;    
           s : out STD_LOGIC;   
           c : out STD_LOGIC);   -- the Carry bit
end half_adder;                


architecture Behavioral of half_adder is
begin
    s <= a xor b;                -- Logical XOR: Sum is '1' only if inputs differ
    c <= a and b;                -- Logical AND: Carry is '1' only if both inputs are '1'
end Behavioral;                

-----------------------------------------------------------
-- 2. FULL ADDER
-----------------------------------------------------------
library IEEE;                  
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( a    : in  STD_LOGIC; -- First operand bit
           b    : in  STD_LOGIC; -- Second operand bit
           cin  : in  STD_LOGIC; -- Carry from the previous (lower) bit stage
           s    : out STD_LOGIC; -- The resulting sum for this bit position
           cout : out STD_LOGIC);-- The carry to pass to the next (higher) stage
end full_adder;

-- This architecture is 'Structural' because it maps components together
architecture Structural of full_adder is
    -- 'signal' defines internal wires that don't leave the entity
    signal s1, c1, c2 : STD_LOGIC; 
begin
    -- 'entity work.X' tells VHDL to look in the current file for entity X
    -- HA1 is a name for this specific instance of the half_adder
    HA1: entity work.half_adder 
        port map (a => a, b => b, s => s1, c => c1);   -- Mapping local pins to HA pins

    -- HA2 takes the sum of (A+B) and adds the incoming Carry (Cin)
    HA2: entity work.half_adder 
        port map (a => s1, b => cin, s => s, c => c2); -- Final sum 's' is output here

    -- If either HA1 or HA2 produced a carry, the Full Adder carries over
    cout <= c1 or c2;            -- The OR gate logic for the final carry-out
end Structural;

-----------------------------------------------------------
-- 3. N-BIT ADDER: The scalable system
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity n_bit_adder is
    -- 'generic' allows you to change the bit-width without changing the logic
    generic (
        n : integer := 4         -- 'n' is a variable used during synthesis (default 4)
    );
    Port ( a    : in  STD_LOGIC_VECTOR (n-1 downto 0); -- A bus of 'n' bits
           b    : in  STD_LOGIC_VECTOR (n-1 downto 0); -- B bus of 'n' bits
           cin  : in  STD_LOGIC;                       -- The very first carry-in
           s    : out STD_LOGIC_VECTOR (n-1 downto 0); -- The final 'n' bit sum
           cout : out STD_LOGIC);                      -- The final overflow bit
end n_bit_adder;

architecture RippleCarry of n_bit_adder is
    -- A signal 'bus' to carry the bits internally between the stages
    -- It is n+1 bits wide to hold the initial cin and the final cout
    signal carry : STD_LOGIC_VECTOR (n downto 0);
begin
    -- Seed the carry chain with the initial input
    carry(0) <= cin;

    -- 'generate' is a loop that the compiler uses to build hardware
    -- It creates 'n' copies of the Full Adder circuit
    GEN_ADDER: for i in 0 to n-1 generate
        -- Each instance gets its own unique label based on index 'i'
        FA_INST: entity work.full_adder
            port map (
                a    => a(i),        -- Maps the i-th bit of input A
                b    => b(i),        -- Maps the i-th bit of input B
                cin  => carry(i),    -- Takes carry from the previous 'i' stage
                s    => s(i),        -- Maps the result to the i-th sum bit
                cout => carry(i+1)   -- Passes carry to the next 'i+1' stage
            );
    end generate GEN_ADDER;

    -- Map the very last carry bit to the output pin
    cout <= carry(n);
end RippleCarry;
