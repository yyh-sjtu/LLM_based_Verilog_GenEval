
module TopModule (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

reg [7:0] register;

always @(posedge clk) begin
    if (enable) begin
        register <= {S, register[7:1]};
    end
end

always @* begin
    case ({A, B, C})
        3'b000: Z = register[0];
        3'b001: Z = register[1];
        3'b010: Z = register[2];
        3'b011: Z = register[3];
        3'b100: Z = register[4];
        3'b101: Z = register[5];
        3'b110: Z = register[6];
        3'b111: Z = register[7];
    endcase
end

endmodule