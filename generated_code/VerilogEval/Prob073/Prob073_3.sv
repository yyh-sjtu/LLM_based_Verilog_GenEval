
module TopModule (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

// 16 D flip-flops
reg [15:0] dff;

always @(posedge clk) begin
    if (!resetn) begin
        // Synchronous active-low reset
        dff <= 16'b0;
    end else begin
        // Update flip-flops based on byteena
        if (byteena[0]) begin // Write to lower byte (D[7:0])
            dff[7:0] <= d[7:0];
        end
        if (byteena[1]) begin // Write to upper byte (D[15:8])
            dff[15:8] <= d[15:8];
        end
    end
end

// Assign internal register to output
always @(*) begin
    q = dff;
end

endmodule