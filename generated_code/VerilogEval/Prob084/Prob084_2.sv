
module TopModule (
    input wire clk,
    input wire enable,
    input wire S,
    input wire A,
    input wire B,
    input wire C,
    output wire Z
);

    // Internal signal declarations
    reg [7:0] Q; // 8-bit shift register
    wire [2:0] addr; // Address for the multiplexer
    wire [7:0] mux_out;

    // Shift Register Logic
    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]}; // Shift in S at Q[0] and shift rest right
        end
    end

    // Address calculation from inputs A, B, C
    assign addr = {A, B, C}; // Concatenate A, B, C to form a 3-bit address

    // Multiplexer Logic to select output Z based on address
    assign Z = (addr == 3'b000) ? Q[0] :
               (addr == 3'b001) ? Q[1] :
               (addr == 3'b010) ? Q[2] :
               (addr == 3'b011) ? Q[3] :
               (addr == 3'b100) ? Q[4] :
               (addr == 3'b101) ? Q[5] :
               (addr == 3'b110) ? Q[6] :
               (addr == 3'b111) ? Q[7] : 1'b0; // In case of invalid address

endmodule