Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.


### Instruction:
Based on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.

### Input:

Description: The module `simple_fsm` implements a Moore state machine with two states 0 and 1, one input `in`, and one output `out`. Reset state is 0. Output is high in state 0. If `in` is low, state changes.
Verilog code: 
module simple_fsm (
	input clk,
	input reset,
	input in,
	output out
);


### Response: