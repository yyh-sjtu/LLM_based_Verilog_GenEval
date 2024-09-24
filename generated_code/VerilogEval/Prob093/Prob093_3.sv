
module TopModule (
    input  wire c,      // input c
    input  wire d,      // input d
    output wire [3:0] mux_in // output mux_in (4 bits)
);

// Define intermediate wires for connections
wire a, b; 
wire mux_a0, mux_a1; // Outputs from the first layer of 2-to-1 MUXes
wire mux_a2, mux_a3; // Outputs from the second layer of 2-to-1 MUXes

// Assign selector inputs for the 4-to-1 multiplexer
assign a = c; // Using input c as a
assign b = d; // Using input d as b

// First Layer 2-to-1 MUX
// mux_a0 corresponds to K-map entry for ab = 00
// mux_a1 corresponds to K-map entry for ab = 01
assign mux_a0 = 0;                // ab = 00 -> Always 0
assign mux_a1 = (c == 0) ? 1 : 0; // ab = 01 -> 1 if c=0, else 0

// Second Layer 2-to-1 MUX
// mux_a2 corresponds to K-map entry for ab = 10
// mux_a3 corresponds to K-map entry for ab = 11
assign mux_a2 = (c == 1) ? 1 : 0; // ab = 10 -> 1 if c=1, else 0
assign mux_a3 = (d == 1) ? 1 : 0; // ab = 11 -> 1 if d=1, else 0

// Final assignments to mux_in based on 'a' and 'b' select inputs
assign mux_in[0] = mux_a0; // mux_in[0] corresponds to ab = 00
assign mux_in[1] = mux_a1; // mux_in[1] corresponds to ab = 01
assign mux_in[2] = mux_a2; // mux_in[2] corresponds to ab = 10
assign mux_in[3] = mux_a3; // mux_in[3] corresponds to ab = 11

endmodule