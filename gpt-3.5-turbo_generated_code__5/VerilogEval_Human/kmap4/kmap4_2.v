module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

// Create a 2x2 Karnaugh map using the inputs a, b, c, d
//   ab
// cd   00 01 11 10
//  00 | 0 | 1 | 0 | 1 |
//  01 | 1 | 0 | 1 | 0 |
//  11 | 0 | 1 | 0 | 1 |
//  10 | 1 | 0 | 1 | 0 |

// Define the outputs for each combination of inputs

always @(a, b, c, d) begin
	case ({a, b, c, d})
		4'b0000: out = 1'b0; // Output for inputs 00
		4'b0001: out = 1'b1; // Output for inputs 01
		4'b0010: out = 1'b0; // Output for inputs 11
		4'b0011: out = 1'b1; // Output for inputs 10
		4'b0100: out = 1'b1; // Output for inputs 00
		4'b0101: out = 1'b0; // Output for inputs 01
		4'b0110: out = 1'b1; // Output for inputs 11
		4'b0111: out = 1'b0; // Output for inputs 10
		4'b1000: out = 1'b0; // Output for inputs 00
		4'b1001: out = 1'b1; // Output for inputs 01
		4'b1010: out = 1'b0; // Output for inputs 11
		4'b1011: out = 1'b1; // Output for inputs 10
		4'b1100: out = 1'b1; // Output for inputs 00
		4'b1101: out = 1'b0; // Output for inputs 01
		4'b1110: out = 1'b1; // Output for inputs 11
		4'b1111: out = 1'b0; // Output for inputs 10
	endcase
end

endmodule

