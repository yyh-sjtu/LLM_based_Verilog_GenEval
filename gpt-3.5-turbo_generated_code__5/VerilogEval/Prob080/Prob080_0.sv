
module TopModule (
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter;
reg tc_out;
reg d_ff;

always @(posedge clk) begin
    if (load == 1) begin
        counter <= data;
    end
    else begin
        if (counter > 0) begin
            counter <= counter - 1;
        end
        if (counter == 0) begin
            tc_out <= 1;
        end
    end
end

always @(posedge clk) begin
    d_ff <= tc_out;
end

assign tc = d_ff;

endmodule