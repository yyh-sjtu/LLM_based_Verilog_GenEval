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
            code <= 8'h00;
        else
            code <= code + 8'h01;
    end
    assign dout_parallel = code;
    assign dout_valid = code[7];
endmodule

