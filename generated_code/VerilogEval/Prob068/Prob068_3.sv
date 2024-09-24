
module TopModule (
    input clk,
    input reset,
    output reg [3:0] ena,
    output reg [15:0] q
);

reg [15:0] counter;

always @ (posedge clk) begin
    if (reset) begin
        counter <= 16'h0000;
        ena <= 4'b1111;
    end else begin
        if (counter == 16'h9999) begin
            counter <= 16'h0000;
            ena <= 4'b1111;
        end else begin
            if (counter[3:0] == 4'b1001) begin
                ena <= 4'b0111;
            end else if (counter[7:4] == 4'b1001) begin
                ena <= 4'b1011;
            end else if (counter[11:8] == 4'b1001) begin
                ena <= 4'b1101;
            end else begin
                ena <= 4'b1110;
            end
            counter <= counter + 1;
        end
    end
end

assign q = counter;

endmodule