<div align="center">

# RISC-V Design

**Hardware I course project in Verilog (ECE AUTH, 2024-25)**

Low-level Hardware Digital Systems I - Aristotle University of Thessaloniki

---

</div>

## Overview

This repository contains the full implementation workflow of a simplified RISC-V processor, developed progressively through five exercises:

- arithmetic and logic unit (ALU)
- calculator datapath and ALU operation encoder
- register file
- processor datapath
- top-level processor integration with instruction/data memories and simulation testbench

Along with the source code, the repository includes:
- the official assignment statement
- a final report documenting the work
- provided baseline memory modules and RISC-V reference material

| Exercise | Topic | Main Deliverable |
|:--------:|-------|------------------|
| **1** | ALU design | 32-bit combinational ALU with arithmetic, logic, comparison, and shift ops |
| **2** | Calculator system | Button-encoded ALU control, accumulator-based calculator, validation testbench |
| **3** | Register file | Parameterized 32x32 register file with synchronous write and read outputs |
| **4** | Datapath | PC logic, immediate generation, ALU path, register file integration, write-back path |
| **5** | Processor top integration | Multicycle control FSM, memory interface, top-level simulation setup |

---

## Repository Structure

```text
RISC-V-Design/
|-- Exercise1/
|   `-- alu.v
|
|-- Exercise2/
|   |-- calc_enc.v
|   |-- calc.v
|   `-- calc_tb.v
|
|-- Exercise3/
|   `-- regfile.v
|
|-- Exercise4/
|   `-- datapath.v
|
|-- Exercise5/
|   |-- top_proc.v
|   |-- top_proc_tb.v
|   |-- rom.v
|   |-- ram.v
|   |-- rom_bytes.data
|   `-- FSM.png
|
|-- Given/
|   |-- rom.v
|   |-- ram.v
|   |-- rom_bytes.data
|   `-- riscv-spec-20191213.pdf
|
|-- Εκφώνηση Εργασίας 2024.pdf
|-- Manolidou_Anatoli_HWI.pdf
`-- README.md
```

---

## Exercises

### Exercise 1 - ALU

- Goal: implement a 32-bit ALU supporting core RISC-V style operations.
- File: [Exercise1/alu.v](Exercise1/alu.v)
- Implemented operations:
	- `ADD`, `SUB`
	- `AND`, `OR`, `XOR`
	- `SLT` (signed less-than)
	- `LSL`, `LSR`, `ASR`
- Notes:
	- signed behavior is used where needed (`SLT`, arithmetic right shift)
	- shift amount is taken from `op2[4:0]`

### Exercise 2 - Calculator + Control Encoding

- Goal: connect user inputs (buttons + switches) to ALU execution through a small calculator datapath.
- Files:
	- [Exercise2/calc_enc.v](Exercise2/calc_enc.v)
	- [Exercise2/calc.v](Exercise2/calc.v)
	- [Exercise2/calc_tb.v](Exercise2/calc_tb.v)
- Highlights:
	- `calc_enc.v`: gate-level logic encoder mapping button combinations to `alu_op`
	- `calc.v`: accumulator-based calculator, LED output, reset and commit controls
	- `calc_tb.v`: functional testbench with multiple operation scenarios and expected-value displays

### Exercise 3 - Register File

- Goal: build a parameterized register file module suitable for the processor datapath.
- File: [Exercise3/regfile.v](Exercise3/regfile.v)
- Features:
	- parameterized data width and number of registers
	- initialized register array
	- synchronous write
	- read outputs with same-cycle forwarding behavior when read/write target matches

### Exercise 4 - Datapath

- Goal: integrate PC logic, register file, immediate generation, ALU, and write-back routing.
- File: [Exercise4/datapath.v](Exercise4/datapath.v)
- Integrated blocks:
	- PC update with sequential and branch target selection
	- instruction field decoding for source/destination registers
	- immediate generation for `I`, `S`, `B`, and `R`-type paths
	- ALU operand muxing (`ALUSrc` control)
	- write-back source selection (`MemToReg`)

### Exercise 5 - Top Processor Integration

- Goal: build the processor top level and validate instruction flow with memory modules.
- Files:
	- [Exercise5/top_proc.v](Exercise5/top_proc.v)
	- [Exercise5/top_proc_tb.v](Exercise5/top_proc_tb.v)
	- [Exercise5/rom.v](Exercise5/rom.v)
	- [Exercise5/ram.v](Exercise5/ram.v)
	- [Exercise5/FSM.png](Exercise5/FSM.png)
- Highlights:
	- control logic for ALU operation selection from opcode/funct fields
	- multicycle FSM (`IF -> ID -> EX -> MEM -> WB`)
	- memory control (`MemRead`, `MemWrite`) and branch handling (`PCSrc` + `Zero`)
	- top-level simulation testbench instantiating processor, ROM, and RAM

---

## Reports And Supporting Material

- Assignment statement: [Εκφώνηση Εργασίας 2024.pdf](%CE%95%CE%BA%CF%86%CF%8E%CE%BD%CE%B7%CF%83%CE%B7%20%CE%95%CF%81%CE%B3%CE%B1%CF%83%CE%AF%CE%B1%CF%82%202024.pdf)
- Final report: [Manolidou_Anatoli_HWI.pdf](Manolidou_Anatoli_HWI.pdf)
- Provided baseline files and references:
	- [Given/rom.v](Given/rom.v)
	- [Given/ram.v](Given/ram.v)
	- [Given/rom_bytes.data](Given/rom_bytes.data)
	- [Given/riscv-spec-20191213.pdf](Given/riscv-spec-20191213.pdf)

---

## Simulation Notes

The repository includes two simulation entry points:

- calculator verification: [Exercise2/calc_tb.v](Exercise2/calc_tb.v)
- processor integration verification: [Exercise5/top_proc_tb.v](Exercise5/top_proc_tb.v)

The testbenches generate VCD waveforms (`calc.vcd`, `top_proc_tb.vcd`) that can be viewed in GTKWave.

---

<div align="center">
<sub>Aristotle University of Thessaloniki - School of Electrical & Computer Engineering</sub>
</div>
