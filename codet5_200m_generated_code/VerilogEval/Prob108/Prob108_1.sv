module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);
    reg [511:0] c;
    always @(posedge clk) begin
        if (load) begin
            c <= 511;
        end
        else begin
            c <= c + 511;
        end
    end
    reg [511:0] c_next;
    reg [511:0] q;
    always @(posedge clk) begin
        if (load) begin
            c_next <= 511;
        end
        else begin
            c_next <= c;
        end
    end
    assign q = c_next;
endmodule

