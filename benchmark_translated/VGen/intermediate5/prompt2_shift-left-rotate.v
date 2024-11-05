Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

Description: The module `left_rotate` implements a shift left and rotate operation.
Verilog code: 
module left_rotate (
	input clk,
	input reset,
	input [2:0] amount,
	input [7:0] data,
	input load,
	output reg [7:0] out
);


### Response: