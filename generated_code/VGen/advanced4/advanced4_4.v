module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module advshift(
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case(amount)
                2'b00: q <= {q[62:0], 1'b0};
                2'b01: q <= {q[55:0], 8'b0};
                2'b10: q <= {1'b0, q[63:1]};
                2'b11: q <= {8'b0, q[63:8]};
            endcase
        end
    end

endmodule
