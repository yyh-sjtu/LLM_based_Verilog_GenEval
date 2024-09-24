module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output data_out
);
    reg [3:0] code;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            code <= 0;
        else
            code <= code + 1;
    assign data_out = code[3];
endmodule

