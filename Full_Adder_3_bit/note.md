**Inputs:**

- `A` and `B`: 3-bit addends.
- `Cin`: Carry-in input (extra input carry bit).

**Outputs:**

- `Sum`: 3-bit sum of the inputs.
- `Cout`: Final carry out (carry after the addition).

---

### How the addition operation is performed
```vhdl
('0' & A) + ('0' & B)
```
**& is the concatenation operator** <br>

'0' & A means concatenating a ‘0’ bit at the most significant position of A. <br>
'0' & B does the same for B. <br>
This effectively turns 3-bit inputs into 4-bit vectors (with a leading zero). The addition of these two 4-bit vectors produces a 4-bit result, which can include a carry-out in the most significant bit (bit 3). <br>

Why add with '0' & A and '0' & B? <br>
To perform a full addition including potential carry, we need to consider the carry-over bit after adding the lower bits.<br>
The '0' & padding ensures that the sum is computed in a 4-bit space, allowing the extra carry to be captured in the most significant bit (bit 3).<br>
<br>
Example: <br>
A = "011"  (which is 3 in decimal) <br>
B = "001"  (which is 1 in decimal) <br>
Cin = '0'  (no initial carry)<br>
<br>
**Pad inputs with zero:**<br>
('0' & A) = "0011"  (binary for 3, with a leading zero, now 4 bits)<br>
('0' & B) = "0001"  (binary for 1, with a leading zero)<br>
<br>
**Add these two 4-bit vectors:**<br>
<br>
  0011   (3)  + 0001   (1)   =  0100   (which is 4 in decimal)
  
**Extract the sum and carry:** <br>
The lower 3 bits (bits 2 downto 0) of the result give the Sum:<br>
Sum = "100"  (which is 4 in decimal, but since it's 3 bits, it fits)<br>
The most significant bit (bit 3) is the carry out (Cout):<br>
Cout = '0'  (since no carry was generated in this example)
