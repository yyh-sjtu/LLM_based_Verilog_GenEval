module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module full_adder_16bit(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire cin,
    output wire [15:0] sum,
    output wire cout
);

wire [15:0] c;
wire [15:0] s;

full_adder fa[15:0](a[15:0], b[15:0], cin, s, c);

assign sum = s;
assign cout = c[15];

endmodule

module ram #(
    parameter ADDR_WIDTH=6,
    parameter DATA_WIDTH=8
)(
    input wire [DATA_WIDTH-1:0] data,
    input wire [ADDR_WIDTH-1:0] addr,
    input wire we,
    input wire clk,
    output wire [DATA_WIDTH-1:0] q
);

reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

always @(posedge clk) begin
    if (we) begin
        ram[addr] <= data;
    end
    q <= ram[addr];
end

endmodule

