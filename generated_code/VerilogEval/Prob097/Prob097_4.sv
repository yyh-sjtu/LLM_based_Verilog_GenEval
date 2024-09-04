
module TopModule (
    input  [15:0] a,
    input  [15:0] b,
    input  [15:0] c,
    input  [15:0] d,
    input  [15:0] e,
    input  [15:0] f,
    input  [15:0] g,
    input  [15:0] h,
    input  [15:0] i,
    input  [3:0]  sel,
    output reg [15:0] out
);

    always @(*) begin
        case (sel)
            4'b0000: out = a;  // sel=0 chooses a
            4'b0001: out = b;  // sel=1 chooses b
            4'b0010: out = c;  // sel=2 chooses c
            4'b0011: out = d;  // sel=3 chooses d
            4'b0100: out = e;  // sel=4 chooses e
            4'b0101: out = f;  // sel=5 chooses f
            4'b0110: out = g;  // sel=6 chooses g
            4'b0111: out = h;  // sel=7 chooses h
            4'b1000: out = i;  // sel=8 chooses i
            default: out = 16'b1111111111111111; // sel=9 to 15 sets out to '1'
        endcase
    end

endmodule