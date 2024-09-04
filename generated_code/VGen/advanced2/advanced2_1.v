
module decade_counter(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

    // Internal signal to keep track of the current count
    reg [3:0] count;

    // Assign q to the count variable
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 4'h0;
        end else begin
            if(slowena) begin
                if(count == 4'h9) begin
                    count <= 4'h0;
                end else begin
                    count <= count + 1;
                end
            end
        end
    end

    // Assign the count to q
    always @(posedge clk) begin
        q <= count;
    end

endmodule