
module TopModule (
    input  wire clock,
    input  wire a,
    output reg  p,
    output reg  q
);

    always @(posedge clock) begin
        // Process the inputs on clock rising edge
        if (a) begin
            p <= 1; // when a is high and clock goes high
        end else begin
            p <= 0; // when a is low, p resets
        end
    end

    always @(negedge clock) begin
        // Process the inputs on clock falling edge
        if (a) begin
            q <= ~q; // toggle q when a is high
        end else begin
            q <= 0; // when a is low, reset q
        end
    end

endmodule