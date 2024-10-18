
module TopModule (
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;
reg tc_next;

always @(posedge clk) begin
    if (load == 1) begin
        counter <= data;
    end else begin
        if (counter > 0) begin
            counter <= counter - 1;
        end
    end
end

always @(posedge clk) begin
    if (load == 1) begin
        tc_next <= 0;
    end else begin
        tc_next <= (counter == 0);
    end
end

always @(posedge clk) begin
    tc <= tc_next;
end

endmodule