
module TopModule (
    input  clk,
    input  resetn,
    input  [1:0] byteena,   // 2-bit byte enable
    input  [15:0] d,        // 16-bit data input
    output reg [15:0] q     // 16-bit data output
);

    // 16 D flip-flops
    reg [15:0] dff;

    always @(posedge clk) begin
        if (!resetn) begin
            // Synchronous active-low reset
            dff <= 16'b0;
        end else begin
            // Conditional write based on byteena
            if (byteena[0]) begin
                // Write to lower byte d[7:0]
                dff[7:0] <= d[7:0];
            end
            
            if (byteena[1]) begin
                // Write to upper byte d[15:8]
                dff[15:8] <= d[15:8];
            end
        end
    end
    
    // Assign output q from the flip-flop register
    always @(posedge clk) begin
        q <= dff;
    end

endmodule