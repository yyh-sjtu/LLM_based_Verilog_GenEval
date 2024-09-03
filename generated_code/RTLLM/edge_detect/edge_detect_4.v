
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

reg a_d1;
reg a_d2;

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rise <= 0;
        down <= 0;
        a_d1 <= 0;
        a_d2 <= 0;
    end else begin
        a_d1 <= a;
        a_d2 <= a_d1;
        
        if (a_d2 && !a_d1) begin // Rising edge detected
            rise <= 1;
            down <= 0;
        end else if (!a_d2 && a_d1) begin // Falling edge detected
            rise <= 0;
            down <= 1;
        end else begin
            rise <= 0;
            down <= 0;
        end
    end
end

endmodule