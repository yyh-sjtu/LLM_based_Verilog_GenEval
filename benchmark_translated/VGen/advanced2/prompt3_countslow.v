Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

"Description: The module `count_slow` implements a decade counter that counts from 0 through 9, inclusive, counting only when `slowena` is high.
Verilog code: 
module count_slow (
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q
);


### Response: