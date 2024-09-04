
module advshift(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

reg [63:0] shift_data;

always @(posedge clk) begin
    if (load) begin
        shift_data <= data;
    end else begin
        case(amount)
            2'b00: begin // shift left by 1 bit
                shift_data <= {shift_data[62:0], 1'b0};
            end
            2'b01: begin // shift left by 8 bits
                shift_data <= {shift_data[55:0], 8'b00000000};
            end
            2'b10: begin // shift right by 1 bit
                shift_data <= {1'b0, shift_data[63:1]};
            end
            2'b11: begin // shift right by 8 bits
                shift_data <= {8'b00000000, shift_data[63:8]};
            end
            default: begin
                shift_data <= data;
            end
        endcase
    end
end

always @(*) begin
    if (ena) begin
        q = shift_data;
    end else begin
        q = data;
    end
end

endmodule