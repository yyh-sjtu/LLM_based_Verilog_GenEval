module priority_encoder (
    input [7:0] in,
    output reg [2:0] pos
);
  
always @(*) begin
    for (int i = 0; i < 8; i = i + 1) begin
        if (in[i] == 1'b1) begin
            pos = i;
            break;
        end
        else
            pos = 3'b0;
    end
end
  
endmodule

module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
  
priority_encoder PE(
    .in(in),
    .pos(pos)
);
  
endmodule

