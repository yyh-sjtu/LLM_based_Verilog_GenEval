
module TopModule (
    input clk,
    input resetn,
    input in,
    output reg out
);

reg [3:0] shiftReg;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        shiftReg <= 4'b0;
    end else begin
        // Shift the register
        shiftReg <= {in, shiftReg[3:1]};
    end
end

assign out = shiftReg[0];

endmodule