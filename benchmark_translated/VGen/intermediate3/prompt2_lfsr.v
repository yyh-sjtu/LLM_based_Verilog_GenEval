Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

Description: The module `lfsr` implements a 5-bit maximal-length Galois LFSR with taps at bit positions 5 and 3.
Verilog code: 
module lfsr (
    input clk,
    input reset,
    output [4:0] q
);


### Response: