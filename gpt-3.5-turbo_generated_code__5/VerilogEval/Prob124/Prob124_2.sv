
module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (int i = 0; i < 512; i = i + 1) begin
            // Get the states of the center cell and its neighbors
            bit left = (i == 0) ? 0 : q[i-1];
            bit center = q[i];
            bit right = (i == 511) ? 0 : q[i+1];
            
            // Calculate the next state of the center cell based on Rule 110
            if (left == 1 && center == 1 && right == 1) begin
                next_q[i] = 0;
            end else if (left == 1 && center == 1 && right == 0) begin
                next_q[i] = 1;
            end else if (left == 1 && center == 0 && right == 1) begin
                next_q[i] = 1;
            end else if (left == 1 && center == 0 && right == 0) begin
                next_q[i] = 0;
            end else if (left == 0 && center == 1 && right == 1) begin
                next_q[i] = 1;
            end else if (left == 0 && center == 1 && right == 0) begin
                next_q[i] = 1;
            end else if (left == 0 && center == 0 && right == 1) begin
                next_q[i] = 1;
            end else begin
                next_q[i] = 0;
            end
        end
        
        q <= next_q;
    end
end

endmodule