
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

reg [WIDTH-1:0] RAM [2**WIDTH-1:0];

// Write Operation
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Reset RAM array on negative edge of reset signal
        for (int i = 0; i < 2**WIDTH; i = i + 1) begin
            RAM[i] <= 6'b000000;
        end
    end else begin
        // Write data to RAM array at write address when write enable signal is active
        if (write_en) begin
            RAM[write_addr] <= write_data;
        end
    end
end

// Read Operation
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Reset read_data register on negative edge of reset signal
        read_data <= 6'b000000;
    end else begin
        // Assign data from RAM array at read address to read_data register when read enable signal is active
        if (read_en) begin
            read_data <= RAM[read_addr];
        end else begin
            read_data <= 6'b000000;
        end
    end
end

endmodule