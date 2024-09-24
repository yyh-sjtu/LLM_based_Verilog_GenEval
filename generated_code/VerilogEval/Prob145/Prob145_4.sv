
module TopModule (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    if (state == 0 && a == 1) begin
        p <= 1;
        q <= 0;
        state <= 1;
    end else if (state == 1 && a == 1) begin
        p <= 1;
        q <= 0;
        state <= 1;
    end else if (state == 1 && a == 0) begin
        p <= 0;
        q <= 1;
        state <= 2;
    end else if (state == 2 && a == 0) begin
        p <= 0;
        q <= 1;
        state <= 2;
    end else begin
        p <= 0;
        q <= 0;
        state <= 0;
    end
end

endmodule