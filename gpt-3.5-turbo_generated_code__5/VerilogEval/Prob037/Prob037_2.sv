
module TopModule (
    input clk,
    input reset,
    output [9:0] q
);

reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 10'b0;
    end else begin
        if (counter < 10'd999) begin
            counter <= counter + 10'd1;
        end else begin
            counter <= 10'b0;
        end
    end
end

assign q = counter;

endmodule