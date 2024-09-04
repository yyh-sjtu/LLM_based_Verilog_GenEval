
module TopModule(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            // Load the initial state
            q <= data;
        end else begin
            // Apply Rule 90 to advance the state
            reg [511:0] next_q; // Temporary storage for the next state
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                // Use boundary conditions: q[-1] = 0 (left-most), q[512] = 0 (right-most)
                next_q[i] = (i > 0 ? q[i-1] : 1'b0) ^ (i < 511 ? q[i+1] : 1'b0);
            end
            q <= next_q; // Update state to next state
        end
    end

endmodule