
module TopModule (
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;
reg [9:0] next_counter;

always @(posedge clk) begin
    if (load) begin
        counter <= data;
    end else begin
        if (counter > 0) begin
            next_counter <= counter - 1;
        end else begin
            next_counter <= 0;
        end
    end
end

always @(*) begin
    if (counter == 0) begin
        tc = 1;
    end else begin
        tc = 0;
    end
end

always @(posedge clk) begin
    counter <= next_counter;
end

endmodule