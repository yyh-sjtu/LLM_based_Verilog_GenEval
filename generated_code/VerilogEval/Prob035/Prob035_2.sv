
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

// Register to hold the current count value
reg [3:0] count;

// Always block triggered on positive edge of clock
always @(posedge clk) begin
    if (reset) begin
        count <= 4'b0001; // Reset counter to 1
    end else begin
        if (count == 4'b1010) begin // If count reaches 10, roll over to 1
            count <= 4'b0001;
        end else begin
            count <= count + 1; // Increment counter
        end
    end
end

assign q = count; // Output current count value

endmodule