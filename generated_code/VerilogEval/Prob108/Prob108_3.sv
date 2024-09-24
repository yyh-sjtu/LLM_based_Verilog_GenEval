
module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        next_state[0] = q[1] ^ q[0] ^ 0; // Rule 90 for the first cell
        next_state[511] = q[510] ^ q[511] ^ 0; // Rule 90 for the last cell
        for (int i = 1; i < 511; i = i + 1) begin
            next_state[i] = q[i-1] ^ q[i] ^ q[i+1]; // Rule 90 for the rest of the cells
        end
        q <= next_state;
    end
end

endmodule