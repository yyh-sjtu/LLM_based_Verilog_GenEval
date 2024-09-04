
module TopModule (
    input wire clk,
    input wire reset,
    output reg [9:0] q // 10 bits to count up to 999
);

    // Internal register for counting
    reg [9:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 10'b0; // Reset the counter to 0
        end else if (count < 10'd999) begin
            count <= count + 1; // Increment the counter
        end else begin
            count <= 10'b0; // Reset the counter back to 0 after reaching 999
        end
    end

    assign q = count; // Output the count value

endmodule