Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

Description: The module `advshift` implements a 64-bit arithmetic shift register with synchronous load capabilities. The shift register can shift either left or right by 1 or 8 bit positions when enabled.
Verilog code: 
module advshift (
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q
);


### Response: