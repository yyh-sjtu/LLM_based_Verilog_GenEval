
module TopModule (
    input clk,
    input [7:0] in,
    input [7:0] anyedge,
    output reg [7:0] edge_detected
);

reg [7:0] prev_in;

always @(posedge clk) begin
    // Detect any edge in the input signals
    for (int i=0; i<8; i=i+1) begin
        if (prev_in[i] == 1'b0 && in[i] == 1'b1) begin
            edge_detected[i] <= 1'b1;
        end else begin
            edge_detected[i] <= 1'b0;
        end
    end
    
    prev_in <= in;
end

endmodule