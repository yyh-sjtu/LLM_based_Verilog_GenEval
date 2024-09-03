module that counts from 1 to 12

module counter( 
    input clk,
    input reset,
    output reg [3:0] q
);
    reg [3:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0001; // Start counting from 1
        end else begin
            if (count == 4'b1100) begin // If count reaches 12, reset to 1
                count <= 4'b0001;
            end else begin
                count <= count + 1; // Increment count
            end
        end
    end

    assign q = count; // Output the count value
endmodule

