module TopModule (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [24:0] o = {a,b,c,d,e};
    genvar i;
    generate
        for (i=0; i<24; i=i+1) begin
            assign out[i] = o[i];
        end
    endgenerate
endmodule

