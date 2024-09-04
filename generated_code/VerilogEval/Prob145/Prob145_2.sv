
module TopModule(
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_next, q_next;

always @(posedge clock) begin
    p <= p_next;
    q <= q_next;
end

always @(posedge clock) begin
    p_next <= a;
    q_next <= p;
end

endmodule