
module TopModule (
    input clk,
    input reset,
    output reg [3:0] ena,
    output reg [15:0] q
);

reg [3:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
        ena <= 4'b0001;
    end else begin
        if (count == 9) begin
            count <= 0;
            ena <= ena << 1;
            ena[0] <= 1;
        end else begin
            count <= count + 1;
        end
    end
end

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0000;
    end else begin
        case(ena)
            4'b0001: q[3:0] <= count;
            4'b0010: q[7:4] <= count;
            4'b0100: q[11:8] <= count;
            4'b1000: q[15:12] <= count;
            default: q <= 16'b0000;
        endcase
    end
end

endmodule