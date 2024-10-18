
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

// Declare internal signals
reg [3:0] counter;

// Implement decade counter logic
always @(posedge clk) begin
    if (reset) begin
        counter <= 4'b0001;
    else begin
        if (counter == 4'b1010) begin
            counter <= 4'b0001;
        else begin
            counter <= counter + 1;
        end
    end
end

// Assign output
assign q = counter;

endmodule