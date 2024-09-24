
module TopModule (
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter; // Internal 10-bit counter

    always @(posedge clk) begin
        if (load) begin
            // Load the counter with new data when 'load' is asserted
            counter <= data;
            tc <= 1'b0; // Reset terminal count since counting starts over
        end else if (counter > 0) begin
            // Decrement the counter when 'load' is not asserted
            counter <= counter - 1;
            tc <= 1'b0; // 'tc' is low while counting down
        end
        
        // Assert 'tc' when counter reaches 0
        if (counter == 0) begin
            tc <= 1'b1; // Terminal count asserted
        end
    end

endmodule