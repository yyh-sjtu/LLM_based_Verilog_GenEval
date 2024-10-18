
module TopModule (
    input clk,
    input reset,
    output reg shift_ena
);

reg [3:0] shift_cnt;

always @(posedge clk) begin
    if (reset) begin
        shift_ena <= 1;
        shift_cnt <= 4'b1111;
    end else begin
        if (shift_cnt > 0) begin
            shift_ena <= 1;
            shift_cnt <= shift_cnt - 1;
        end else begin
            shift_ena <= 0;
        end
    end
end

endmodule