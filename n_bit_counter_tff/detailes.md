# 🔢 N-Bit Up/Down Counter using T-Flip Flops (VHDL)

A structurally modeled, scalable **N-bit synchronous counter** built entirely with **T-Flip Flops** in VHDL.  
Supports:

- ⬆️ Up-counting
- ⬇️ Down-counting
- ♾️ Generic N-bit scaling
- 🧩 MOD-N operation

---


# 1. T-Flip Flop Fundamentals

The entire counter is built using **T-Flip Flops (Toggle Flip Flops)**.

## Core Behavior

| T | Behavior |
|---|---|
| 0 | Hold current state |
| 1 | Toggle state |

---

## VHDL Implementation

The `TFF` module is implemented behaviorally with:

- Clocked state updates
- Asynchronous reset
- Toggle-based state transitions

The asynchronous reset immediately forces:

```vhdl
Q <= '0';
```

independent of the clock.

However, the actual counting mechanism relies completely on synchronous manipulation of the `T` input.

---

# 2. Counter Toggle Logic

To create an N-bit counter using TFFs, the system must dynamically determine:

> Which flip-flops should toggle on each clock cycle?

This logic is generated combinationally.

---

## ⬆️ Up-Counting Logic

In binary up-counting:

- Bit 0 toggles every cycle
- Bit 1 toggles when Bit 0 = 1
- Bit 2 toggles when Bit 1 AND Bit 0 = 1
- etc.

### General Rule

A bit toggles only when **all less significant bits are 1**.

---

## ⬇️ Down-Counting Logic

For down-counting:

- A bit toggles only when all lower bits are 0

Example:

- Bit 1 toggles when Bit 0 = 0
- Bit 2 toggles when Bit 1 = 0 AND Bit 0 = 0

---

## VHDL Implementation

Inside the combinational process, two helper variables are used:

```vhdl
all_ones
all_zeros
```

A nested loop scans all less significant bits:

```vhdl
for j in 0 to i-1 loop
```

This dynamically determines whether the current bit should toggle.

### Logic Applied

```vhdl
if count_up = '1' then
    toggle_signal(i) <= all_ones;
else
    toggle_signal(i) <= all_zeros;
end if;
```

This creates a scalable AND-gate cascade for every TFF input.

---

# 3. MOD-N Reset Logic

A MOD-N counter counts from:

\[
0 \rightarrow MOD\_VALUE - 1
\]

then wraps back to zero.

Example:

A MOD-4 counter produces:

```text
0 → 1 → 2 → 3 → 0 → 1 ...
```

---

## The Interesting Part 🚀

Resetting a TFF-based counter is trickier than with DFFs.

Instead of directly forcing:

```text
Q_next = 0
```

the design uses a clever identity:

\[
T = Q
\]

---

## Why Does This Work?

If:

### Current state:

```text
Q = 1
```

then:

```text
T = 1
```

causes a toggle:

```text
1 → 0
```

---

If:

```text
Q = 0
```

then:

```text
T = 0
```

causes the state to remain:

```text
0 → 0
```

---

## Result

Assigning:

\[
T = Q
\]

guarantees:

\[
Q_{next} = 0
\]

for every flip-flop simultaneously.


---

## Detection Logic

The counter continuously checks whether the limit is reached:

```vhdl
nmod_reached <= '1'
    when (
        COUNTER_TYPE = "NMOD"
        and unsigned(counter_value) = MOD_VALUE - 1
    )
    else '0';
```

---

## Reset Execution

When the limit is reached:

```vhdl
toggle_signal(i) <= counter_value(i);
```

This effectively applies:

```text
T = Q
```

to every flip-flop.

On the next clock edge, the entire counter resets back to zero synchronously.

No extra reset pulse required.

---

# 4. Structural Modeling

The project follows a **structural VHDL architecture** rather than behavioral arithmetic like:

```vhdl
Q <= Q + 1;
```

Instead, the design explicitly instantiates physical components and wires them together.

---

## Generate-Based Instantiation

```vhdl
gen_flipflops: for i in 0 to N-1 generate

    FF: TFF
    port map(
        T     => toggle_signal(i),
        CLK   => CLK,
        RESET => RESET,
        Q     => counter_value(i)
    );

end generate;
```

This tells the synthesizer to physically create:

- N TFF instances
- Shared clock/reset routing
- Individual toggle wiring

The combinational process generates the toggle network that drives every T input.

This approach closely resembles real hardware netlist construction.
