
module TopModule (
    input wire c,
    input wire d,
    output wire [3:0] mux_in
);

    wire a; // Declaring 'a'
    wire b; // Declaring 'b'
    
    wire [3:0] mux_inputs; // Inputs for the 4-to-1 multiplexer

    // Assume a and b are assigned from some external logic
    // For simplicity's sake, assign a and b directly from c and d
    // You may have to adjust this depending on your actual input mapping
    assign a = c; // Assuming 'a' comes from 'c'
    assign b = d; // Assuming 'b' comes from 'd'

    // To implement the K-map using the multiplexers

    // Outputs from the 2-to-1 multiplexers corresponding to combinations of 'c' and 'd'
    wire mux1_out; // Corresponds to ab=00 and ab=01
    wire mux2_out; // Corresponds to ab=11 and ab=10

    // First level of the multiplexers (2-to-1 MUX for each K-map term)
    // For ab=00 (cd=00): output 0 -> input mux_inputs[0]
    // For ab=01 (cd=01): output 1 -> input mux_inputs[1]
    // For ab=11 (cd=11): output 1 -> input mux_inputs[3]
    // For ab=10 (cd=10): output 1 -> input mux_inputs[2]

    // Implementing the required conditions for mux_in based on the K-map
    // mux1_out connects ab=00 and ab=01
    assign mux1_out = (b) ? 1'b0 : 1'b1;  // Flythrough mux: when b=0, output 0 else output 1 

    // mux2_out connects ab=11 and ab=10
    assign mux2_out = (b) ? (c) : 1'b1; // Outputs based on value of c (when b=1, we need values for cd=10)

    // Connecting multiplexer outputs to final inputs for the 4-to-1 MUX
    assign mux_inputs[0] = 1'b0;           // ab = 00: cd = 00 -> 0
    assign mux_inputs[1] = mux1_out;       // ab = 01: cd = 01 -> 1
    assign mux_inputs[2] = mux2_out;       // ab = 10: cd = 10 -> 1
    assign mux_inputs[3] = 1'b1;           // ab = 11: cd = 11 -> 1

    // Final output from the 4-to-1 multiplexer
    assign mux_in = mux_inputs;

endmodule