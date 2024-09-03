module
module advshift(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

// Define internal registers for shift operations
reg [63:0] temp;

// Always block triggered by positive edge of clock
always @(posedge clk) begin
    if (load) begin
        // Load data when load signal is high
        q <= data;
    end else if (ena) begin
        // Perform shift operations based on amount selected
        case(amount)
            2'b00: temp <= {q[62:0], 1'b0}; // Shift left by 1 bit
            2'b01: temp <= {q[55:0], 8'b0}; // Shift left by 8 bits
            2'b10: temp <= {1'b0, q[63:1]}; // Shift right by 1 bit
            2'b11: temp <= {8'b0, q[63:8]}; // Shift right by 8 bits
        endcase
        q <= temp;
    end
end

endmodule

