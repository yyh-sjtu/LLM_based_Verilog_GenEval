
module TopModule(
    input  [2:0] sel,       // 3-bit selection input
    input  [3:0] data0,     // 4-bit data input 0
    input  [3:0] data1,     // 4-bit data input 1
    input  [3:0] data2,     // 4-bit data input 2
    input  [3:0] data3,     // 4-bit data input 3
    input  [3:0] data4,     // 4-bit data input 4
    input  [3:0] data5,     // 4-bit data input 5
    output reg [3:0] out    // 4-bit output
);

    always @(*) begin
        // Default output is 0
        out = 4'b0000;
        
        // Select the appropriate data input based on sel
        case (sel)
            3'b000: out = data0; // sel = 0
            3'b001: out = data1; // sel = 1
            3'b010: out = data2; // sel = 2
            3'b011: out = data3; // sel = 3
            3'b100: out = data4; // sel = 4
            3'b101: out = data5; // sel = 5
            default: out = 4'b0000; // sel out of range, output 0
        endcase
    end

endmodule