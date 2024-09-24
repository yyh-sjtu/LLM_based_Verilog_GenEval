module decade_counter(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

    // Internal signal to keep track of current count
    reg [3:0] count;

    // On positive edge of clock and slowena is high, increment count
    always @(posedge clk) begin
        if (slowena && !reset) begin
            if (count == 4'd9) begin
                count <= 4'd0;
            end else begin
                count <= count + 1;
            end
        end
    end

    // Output the count value
    always @(*) begin
        q = count;
    end

endmodule

