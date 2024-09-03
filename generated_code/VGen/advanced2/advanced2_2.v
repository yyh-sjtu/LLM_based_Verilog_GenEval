
module decade_counter(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

reg [3:0] next_q;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        q <= 4'b0000;
    end else if (slowena) begin
        next_q = q + 1;
        if (next_q == 4'b1010) begin
            next_q <= 4'b0000;
        end else begin
            q <= next_q;
        end
    end
end

endmodule