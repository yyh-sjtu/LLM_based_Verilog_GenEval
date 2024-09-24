module priority_encoder(
    input [2:0] in,
    output reg [1:0] pos
);
always @ (*)
    begin
        pos = 0;
    end
endmodule

