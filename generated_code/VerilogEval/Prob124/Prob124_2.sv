
module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] next_state; // Next state for each cell

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        // Apply Rule 110 to each cell
        for (int i = 0; i < 512; i++) begin
            if (i == 0) begin
                next_state[i] = (q[0] & ~q[1]) | (~q[0] & ~q[1]);
            end else if (i == 511) begin
                next_state[i] = (~q[510] & q[511]) | (~q[510] & ~q[511]);
            end else begin
                next_state[i] = (~q[i-1] & q[i] & q[i+1]) | (~q[i-1] & ~q[i] & q[i+1]) | (~q[i-1] & ~q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]);
            end
        end
        
        q <= next_state; // Update current state with next state
    end
end

endmodule