
module TopModule (
    input [254:0] in,
    output reg [7:0] out
);

always @(*) begin
    integer i;
    reg [7:0] count;

    count = 0;
    for (i = 0; i < 255; i = i + 1) begin
        count = count + in[i];
    end

    out = count;
end

endmodule