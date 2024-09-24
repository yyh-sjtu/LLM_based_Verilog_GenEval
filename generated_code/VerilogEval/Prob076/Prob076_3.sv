
module TopModule(
    input  [2:0] sel,       // 3-bit selection input
    input  [3:0] data0,     // 4-bit input data 0
    input  [3:0] data1,     // 4-bit input data 1
    input  [3:0] data2,     // 4-bit input data 2
    input  [3:0] data3,     // 4-bit input data 3
    input  [3:0] data4,     // 4-bit input data 4
    input  [3:0] data5,     // 4-bit input data 5
    output reg [3:0] out    // 4-bit output
);
    
    always @(*) begin
        case (sel)
            3'b000: out = data0;  // Select data0
            3'b001: out = data1;  // Select data1
            3'b010: out = data2;  // Select data2
            3'b011: out = data3;  // Select data3
            3'b100: out = data4;  // Select data4
            3'b101: out = data5;  // Select data5
            default: out = 4'b0000; // Default case - output 0
        endcase
    end

endmodule