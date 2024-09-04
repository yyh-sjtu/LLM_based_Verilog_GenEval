
module TopModule (
    input wire clock,
    input wire a,
    output reg p,
    output reg q
);

reg q_next;

always @(posedge clock or negedge a) begin
    if (~a) begin
        q <= 0;
    end else begin
        q <= q_next;
    end
end

always @* begin
    case({a, q})
        2'b00: begin
            p = 0;
            q_next = q;
        end
        2'b01: begin
            p = 0;
            q_next = 0;
        end
        2'b10: begin
            p = 1;
            q_next = 1;
        end
        2'b11: begin
            p = 0;
            q_next = 0;
        end
    endcase
end

endmodule