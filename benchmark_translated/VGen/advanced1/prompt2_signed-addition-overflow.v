Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

Description: The module `signed_adder` implements a signed adder that adds two 8-bit 2's complement numbers and captures a signed overflow.
Verilog code: 
module signed_adder (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);


### Response: