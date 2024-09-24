
module TopModule (
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q
);

    // Intermediate array to hold the next state
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            // Load the input data into q
            q <= data;
        end else begin
            // Apply Rule 90 logic
            next_q[0] = 1'b0; // q[-1] is considered 0
            for (integer i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ q[i+1]; // XOR of left and right neighbors
            end
            next_q[511] = 1'b0; // q[512] is considered 0

            // Update q with the newly calculated next_q
            q <= next_q;
        end
    end

endmodule