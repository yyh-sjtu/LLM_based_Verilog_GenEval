module TopModule (
    input a,
    input b,
    input c,
    input d,
    output q
);
    parameter [1:0] PULLUP = 2'b00;
    parameter [0:0] PULLUP_VALUE = 2'b01;
    initial begin
        $display("PULLUP: %b", PULLUP);
    end
    always @(a or b or c or d) begin
        if (a)
            q <= 1'b0;
        else if (b)
            q <= 1'b1;
        else if (c)
            q <= 1'b0;
    end
    assign q = pULLUP_VALUE;
endmodule

