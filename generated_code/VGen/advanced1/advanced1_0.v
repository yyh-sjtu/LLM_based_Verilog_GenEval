module signed_adder(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] temp;

    always @(*) begin
        temp = {1'b0, a} + {1'b0, b};
        
        if (temp[8] != temp[9]) begin
            overflow = 1'b1;
        end else begin
            overflow = 1'b0;
        end
        
        s = temp[7:0];
    end

endmodule

