
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
            4'd0: out = a;  // when sel = 0, assign a to out
            4'd1: out = b;  // when sel = 1, assign b to out
            4'd2: out = c;  // when sel = 2, assign c to out
            4'd3: out = d;  // when sel = 3, assign d to out
            4'd4: out = e;  // when sel = 4, assign e to out
            4'd5: out = f;  // when sel = 5, assign f to out
            4'd6: out = g;  // when sel = 6, assign g to out
            4'd7: out = h;  // when sel = 7, assign h to out
            4'd8: out = i;  // when sel = 8, assign i to out
            default: out = 16'b1111111111111111;  // sel = 9 to 15, all bits set to 1
        endcase
    end

endmodule