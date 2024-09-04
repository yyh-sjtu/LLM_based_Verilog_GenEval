module advshift(input clk,
                  input load,
                  input ena,
                  input [1:0] amount,
                  input [63:0] data,
                  output reg [63:0] q);

    reg [63:0] shift_reg;

    always @(posedge clk) begin
        if (load) begin
            shift_reg <= data;
        end else if (ena) begin
            case(amount)
                2'b00: shift_reg <= {shift_reg[62:0], 1'b0};
                2'b01: shift_reg <= {shift_reg[55:0], 8'b0};
                2'b10: shift_reg <= {1'b0, shift_reg[63:1]};
                2'b11: shift_reg <= {8'b0, shift_reg[63:8]};
                default: shift_reg <= shift_reg;
            endcase
        end
    end

    assign q = shift_reg;

endmodule

