
module TopModule (
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        counter <= data;
    end else begin
        if (counter > 0) begin
            counter <= counter - 1;
        end
    end
end

always @(posedge clk) begin
    if (counter == 0) begin
        tc <= 1'b1;
    end else begin
        tc <= 1'b0;
    end
end

endmodule