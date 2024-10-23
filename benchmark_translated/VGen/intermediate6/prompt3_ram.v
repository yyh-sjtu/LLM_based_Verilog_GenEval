Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

"Description: The module `ram` implements a RAM with parameterizable address and data widths.
Verilog code: 
module ram #(
	parameter ADDR_WIDTH = 6,
	parameter DATA_WIDTH = 8
) (
	input [DATA_WIDTH-1:0] data,
	input [ADDR_WIDTH-1:0] addr,
	input we,
	input clk,
	output [DATA_WIDTH-1:0] q
);


### Response: