
module TopModule (
    input        clk,      // Clock input
    input        enable,   // Enable input
    input        S,        // Shift in input
    input        A,        // Address input A
    input        B,        // Address input B
    input        C,        // Address input C
    output reg   Z         // Output Z
);

    // 8-bit shift register using D flip-flops
    reg [7:0] Q; // 8-bit register

    // 3 to 8 decoder for address select
    wire [2:0] addr;
    assign addr = {C, B, A}; // Combine A, B, C into a 3-bit address

    // Shift register logic
    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]}; // Shift left and insert S at MSB
        end
    end

    // Multiplexer logic to select Z based on address
    always @(*) begin
        case (addr)
            3'b000: Z = Q[0]; // ABC = 000 selects Q[0]
            3'b001: Z = Q[1]; // ABC = 001 selects Q[1]
            3'b010: Z = Q[2]; // ABC = 010 selects Q[2]
            3'b011: Z = Q[3]; // ABC = 011 selects Q[3]
            3'b100: Z = Q[4]; // ABC = 100 selects Q[4]
            3'b101: Z = Q[5]; // ABC = 101 selects Q[5]
            3'b110: Z = Q[6]; // ABC = 110 selects Q[6]
            3'b111: Z = Q[7]; // ABC = 111 selects Q[7]
            default: Z = 0;   // Default case
        endcase
    end

endmodule