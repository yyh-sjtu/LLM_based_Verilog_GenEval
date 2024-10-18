
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

// Edge detection process
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 0;
        down <= 0;
    end else begin
        if (a & ~$past(a)) begin // Rising edge detection
            rise <= 1;
            down <= 0;
        end else if (~a & $past(a)) begin // Falling edge detection
            rise <= 0;
            down <= 1;
        end else begin
            rise <= 0;
            down <= 0;
        end
    end
end

endmodule