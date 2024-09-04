
module advshift (
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            if (ena) begin
                case(amount)
                    2'b00: q <= {q[62:0],q[63]};
                    2'b01: q <= {q[55:0],q[63:56]};
                    2'b10: q <= {q[0],q[63:1]};
                    2'b11: q <= {q[7:0],q[63:8]};
                endcase
            end
        end
    end

endmodule