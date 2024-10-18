
module serial2parallel (
    input clk,
    input rst_n,
    input din_serial,
    input din_valid,
    output reg [7:0] dout_parallel,
    output reg dout_valid
);

reg [3:0] cnt;  // 4-bit counter to keep track of number of serial bits

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 0;
        dout_valid <= 0;
    end else begin
        if (din_valid) begin
            cnt <= cnt + 1;
            dout_parallel <= {dout_parallel[6:0], din_serial};  // Shift in serial input
        end
        
        if (cnt == 7) begin  // When all 8 serial bits received
            dout_valid <= 1;
        end else begin
            dout_valid <= 0;
        end
        
        if (cnt == 8) begin  // Reset counter and parallel output when 8 bits received
            cnt <= 0;
            dout_parallel <= 0;
        end
    end
end

endmodule