module serial2parallel (
    input clk,
    input rst_n,
    input din_serial,
    input din_valid,
    output [7:0] dout_parallel,
    output dout_valid
);
    reg [7:0] code;
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            code <= 8'b0;
        else
            if(din_serial)
                code <= code + 8'b1;
    end
    assign dout_parallel = code;
    assign dout_valid = code[7];
endmodule

