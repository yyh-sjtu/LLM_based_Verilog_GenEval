Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

Description: The module `P_box` implements a permutation block that permutes a 32-bit input based on a predefined table.
Verilog code: 
module P_box (
	input [31:0] In32,
	output reg [31:0] Out32
);


### Response: