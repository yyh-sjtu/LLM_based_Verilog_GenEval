
module TopModule (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        if (do_sub == 0) begin
            out = a + b;
            if (out == 0) begin
                result_is_zero = 1;
            end else begin
                result_is_zero = 0;
            end
        end else begin
            out = a - b;
            if (out == 0) begin
                result_is_zero = 1;
            end else begin
                result_is_zero = 0;
            end
        end
    end

endmodule