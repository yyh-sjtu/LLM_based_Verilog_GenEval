
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

// Synchronize signals with the clock
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        // Reset signals to 0
        rise <= 0;
        down <= 0;
    end else if (a & ~$past(a)) begin
        // Rising edge detected
        rise <= 1;
        down <= 0;
    end else if (~a & $past(a)) begin
        // Falling edge detected
        rise <= 0;
        down <= 1;
    end else begin
        // No edge detected
        rise <= 0;
        down <= 0;
    end
end

endmodule