module counter(
    input wire clk,
    input wire reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset)
begin
    if (reset)
        q <= 4'b0001;  // Initializing counter to 1
    else if (q == 4'b1100)  // Check if counter has reached 12
        q <= 4'b0001;  // Reset counter back to 1
    else
        q <= q + 4'b0001;  // Increment counter by 1
end

endmodule

module tb_counter;

reg clk, reset;
wire [3:0] q;

counter dut (
    .clk(clk),
    .reset(reset),
    .q(q)
);

initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
    forever begin
        #5 clk = ~clk;
    end
end

endmodule
