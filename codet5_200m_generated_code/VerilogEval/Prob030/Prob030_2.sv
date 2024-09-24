module TopModule (
    input [254:0] in,
    output [7:0] out
);
    reg [7:0] code;
    always @ (in)
    begin
        code = in + 1;
    end
    assign out = code;
endmodule

