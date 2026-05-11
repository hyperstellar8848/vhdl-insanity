The project follows a structural hierarchy. Instead of describing *what* the hardware does (behavioral), we describe *what it is* (structural). 

### The Hierarchy:
1.  **Half Adder:** The atomic unit. It performs the simplest addition of two bits but lacks the "memory" to accept a carry from a previous state.
2.  **Full Adder:** The bridge. By combining two Half Adders and an OR gate, it gains the ability to process an incoming carry, allowing for infinite scalability.
3.  **N-Bit Adder:** The system. Utilizing a `generate` loop, the design replicates the Full Adder $n$ times, creating a "Ripple Carry" chain where logic flows from the least significant bit to the most significant bit.


### **The Carry Logic: Why `cout <= c1 or c2`?**
**Question:** What if both half-adders produced a carry? Wouldn't an `OR` gate be insufficient?
**Answer:** In this specific architecture, it is mathematically impossible for both internal carries ($c1$ and $c2$) to be high at the same time.
* If $A$ and $B$ are both '1', $c1$ triggers. However, this forces the intermediate sum to '0'.
* Because the intermediate sum is '0', the second half-adder is adding '0' to the incoming carry. 
* Mathematically: $0 \text{ AND } cin = 0$. Therefore, $c2$ must be '0'.
Since they are mutually exclusive, the `OR` gate is the most efficient hardware "merger" for the final carry output.



### **The Assignment Operators: `:=` vs `<=`**
* **Signal Assignment (`<=`):** This represents a physical wire. It describes the continuous flow of information through the circuit.
* **Variable/Initial Assignment (`:=`):** This is used for "setting the stage." We use it to define the default size of the hardware (the `generic` value) before the circuit is actually synthesized into reality.

### **The Injection Point: `carry(0) <= cin;`**
**Question:** What is the value of that external `cin`? Is it 0?
**Answer:** `cin` is an **Input Port**, not a hardcoded constant. 
* By connecting `carry(0)` to `cin`, we create the "Initial Condition" of the chain.
* **The Value:** While usually grounded to '0' for standard addition, leaving it as a port allows for **multi-purpose reality**. If `cin` is set to '1' and the inputs are inverted, this exact hardware becomes a subtractor. 


| Term | Functional Meaning |
| :--- | :--- |
| **Entity** | The physical boundary and the external pins of the component. |
| **Architecture** | The internal logic and "brain" of the device. |
| **Generic** | A parameter that sets the scale (bit-width) of the hardware. |
| **Signal** | An internal wire used to connect components that aren't visible from the outside. |
| **Port Map** | The act of physically wiring one component's pins to another. |
| **Generate** | A hardware instruction to replicate a structure $n$ times. |
