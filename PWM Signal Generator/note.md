# PWM Signal Generator

## Description
This project implements a Pulse Width Modulation (PWM) signal generator using VHDL. The output signal's duty cycle can be adjusted while maintaining a constant frequency.

## Design
The PWM generator uses:
- `clk`: Clock input.
- `reset`: Resets the counter and output.
- `duty`: Controls the duty cycle (0–100%).
- `pwm_out`: Generated PWM output.

## Testbench
The testbench generates a clock signal and tests five duty cycle values:

| Duty Cycle | HIGH Time | LOW Time |
|---|---:|---:|
| 25% | 25 ns | 75 ns |
| 50% | 50 ns | 50 ns |
| 75% | 75 ns | 25 ns |
| 100% | 100 ns | 0 ns |
| 0% | 0 ns | 100 ns |

## Simulation Results
The waveform demonstrates that:
- Increasing the duty cycle increases the HIGH duration.
- Decreasing the duty cycle decreases the HIGH duration.
- At 100%, the output remains HIGH.
- At 0%, the output remains LOW.
- The PWM period remains constant at 100 ns.
