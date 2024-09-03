
module advshift(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

reg [63:0] shift_data;

always @ (posedge clk) begin
    if (load) begin
        shift_data <= data;
    end else begin
        if (ena) begin
            case (amount)
                2'b00: shift_data <= {shift_data[62:0], 1'b0}; // shift left by 1 bit
                2'b01: shift_data <= {shift_data[55:0], 8'b00000000}; // shift left by 8 bits
                2'b10: shift_data <= {1'b0, shift_data[63:1]}; // shift right by 1 bit
                2'b11: shift_data <= {8'b00000000, shift_data[63:8]}; // shift right by 8 bits
                default: shift_data <= shift_data; // no shift
            endcase
        end
    end
end

assign q = shift_data;

endmodule