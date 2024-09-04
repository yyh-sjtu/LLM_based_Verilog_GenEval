
module TopModule (
    input   [2:0] sel,  // 3-bit selection input
    input   [3:0] data0, // 4-bit input data0
    input   [3:0] data1, // 4-bit input data1
    input   [3:0] data2, // 4-bit input data2
    input   [3:0] data3, // 4-bit input data3
    input   [3:0] data4, // 4-bit input data4
    input   [3:0] data5, // 4-bit input data5
    output  reg [3:0] out  // 4-bit output
);

    always @(*) begin
        case (sel)
            3'b000: out = data0; // Select data0 when sel is 0
            3'b001: out = data1; // Select data1 when sel is 1
            3'b010: out = data2; // Select data2 when sel is 2
            3'b011: out = data3; // Select data3 when sel is 3
            3'b100: out = data4; // Select data4 when sel is 4
            3'b101: out = data5; // Select data5 when sel is 5
            default: out = 4'b0000; // Output zero for invalid sel
        endcase
    end

endmodule