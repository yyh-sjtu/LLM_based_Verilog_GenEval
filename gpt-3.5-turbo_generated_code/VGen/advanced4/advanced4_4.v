module advshift(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

reg [63:0] reg_data;

always @(posedge clk) begin
    if (load) begin
        reg_data <= data;
    end else begin
        if (ena) begin
            case(amount)
                2'b00: reg_data <= {reg_data[62:0], 1'b0};
                2'b01: reg_data <= {reg_data[55:0], 8'b0};
                2'b10: reg_data <= {1'b0, reg_data[63:1]};
                2'b11: reg_data <= {8'b0, reg_data[63:8]};
                default: reg_data <= reg_data;
            endcase
        end
    end
end

assign q = reg_data;

endmodule

