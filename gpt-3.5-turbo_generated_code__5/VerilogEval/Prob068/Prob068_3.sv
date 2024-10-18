
module TopModule (
    input clk,
    input reset,
    output reg [3:0] ena,
    output reg [15:0] q
);

reg [15:0] count;

always @ (posedge clk) begin
    if (reset) begin
        count <= 0;
        ena <= 4'b111;
    end else begin
        if (count == 16'b1001_1001_1001_1001) begin
            count <= 0;
            ena <= 4'b001;
        end else begin
            count <= count + 1;
            ena <= 4'b111;
        end
    end
end

always @* begin
    case (count)
        16'b0000_0000_0000_0000: q = 16'b0000_0000_0000_0000; // 0
        16'b0000_0000_0000_0001: q = 16'b0000_0000_0000_0001; // 1
        16'b0000_0000_0000_0010: q = 16'b0000_0000_0000_0010; // 2
        // add cases for all 10 digits
        default: q = 16'bxxxx_xxxx_xxxx_xxxx; // Invalid state
    endcase
end

endmodule