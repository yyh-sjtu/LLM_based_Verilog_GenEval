
// This is a RAM module
module ram #( parameter ADDR_WIDTH=6, parameter DATA_WIDTH=8) (
    input [DATA_WIDTH-1:0] data,       // Data input
    input [ADDR_WIDTH-1:0] addr,       // Address input
    input we,                           // Write enable
    input clk,                          // Clock input
    output reg [DATA_WIDTH-1:0] q      // Data output
);
    // Memory array declaration
    reg [DATA_WIDTH-1:0] ram[0:(2**ADDR_WIDTH)-1]; // RAM array

    // Always block for write and read operations
    always @(posedge clk) begin
        if (we) begin
            ram[addr] <= data;         // Write data to RAM
        end
        q <= ram[addr];                // Read data from RAM
    end
endmodule