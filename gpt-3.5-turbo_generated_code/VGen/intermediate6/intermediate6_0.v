
// This is a RAM module
module ram #( 
    parameter ADDR_WIDTH = 6, // Number of address bits
    parameter DATA_WIDTH = 8  // Number of data bits
) (
    input [DATA_WIDTH-1:0] data,        // Input data
    input [ADDR_WIDTH-1:0] addr,        // Address input
    input we,                           // Write enable
    input clk,                          // Clock signal
    output reg [DATA_WIDTH-1:0] q       // Output data
);

    // Declare the RAM memory array
    reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0]; 

    // Synchronous read and write
    always @(posedge clk) begin
        if (we) begin
            // Write data to the specified address
            ram[addr] <= data;
        end
        // Read data from the specified address
        q <= ram[addr];
    end

endmodule