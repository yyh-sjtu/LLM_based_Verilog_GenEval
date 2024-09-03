
module count_slow(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

    // Internal signals
    reg [3:0] count;

    // Decade counter logic
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (slowena) begin
            if (count == 4'b1001) begin
                count <= 4'b0000;
            end else begin
                count <= count + 1;
            end
        end
    end

    // Output logic
    always @(*) begin
        q = count;
    end

endmodule