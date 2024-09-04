
module TopModule (
    input     [2:0] vec,
    output reg [2:0] outv,
    output reg       o2,
    output reg       o1,
    output reg       o0
);

assign o0 = vec[0];
assign o1 = vec[1];
assign o2 = vec[2];

always @* begin
    outv = vec;
end

endmodule