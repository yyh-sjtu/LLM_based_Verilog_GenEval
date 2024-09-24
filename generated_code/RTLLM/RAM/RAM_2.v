
module RAM (
    input clk,
    input rst_n,
    input write_en,
    input [WIDTH-1:0] write_addr,
    input [WIDTH-1:0] write_data,
    input read_en,
    input [WIDTH-1:0] read_addr,
    output reg [WIDTH-1:0] read_data
);

parameter WIDTH = 6;
parameter DEPTH = 8;

reg [WIDTH-1:0] RAM [2**WIDTH - 1:0];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (int i = 0; i < 2**WIDTH; i=i+1) begin
            RAM[i] <= 6'b000000;
        end
    end else begin
        if (write_en) begin
            RAM[write_addr] <= write_data;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        read_data <= 6'b000000;
    end else begin
        if (read_en) begin
            read_data <= RAM[read_addr];
        end else begin
            read_data <= 6'b000000;
        end
    end
end

endmodule