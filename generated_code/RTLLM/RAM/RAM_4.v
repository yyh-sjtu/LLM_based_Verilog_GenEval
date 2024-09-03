
module RAM #(
    parameter WIDTH = 6,
    parameter DEPTH = 8
)(
    input wire clk,
    input wire rst_n,
    input wire write_en,
    input wire [WIDTH-1:0] write_addr,
    input wire [WIDTH-1:0] write_data,
    input wire read_en,
    input wire [WIDTH-1:0] read_addr,
    output reg [WIDTH-1:0] read_data
);

reg [WIDTH-1:0] RAM [0:(2**DEPTH)-1];

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i = 0; i < 2**DEPTH; i++)
            RAM[i] <= 6'h00;
    end else begin
        if (write_en) begin
            RAM[write_addr] <= write_data;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        read_data <= 6'h00;
    end else begin
        if (read_en) begin
            read_data <= RAM[read_addr];
        end
    end
end

endmodule