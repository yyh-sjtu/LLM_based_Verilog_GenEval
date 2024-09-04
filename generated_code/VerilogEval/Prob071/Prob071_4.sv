
module TopModule (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    pos = 3'b0; // initialize output to all zeros
    for (int i = 0; i < 8; i = i + 1) begin
        if (in[i] == 1) begin
            pos = i;
            break; // once the first high bit is found, break the loop
        end
    end
end

endmodule