
module edge_detect (
    input       wire        clk,
    input       wire        rst_n,
    input       wire        a,
    output reg  rise,
    output reg  down
    );
    
    reg         a_prev;

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rise <= 0;
            down <= 0;
        end
        else begin
            if (a && ~a_prev) begin // Rising edge detected
                rise <= 1;
                down <= 0;
            end
            else if (~a && a_prev) begin // Falling edge detected
                rise <= 0;
                down <= 1;
            end
            else begin 
                rise <= 0;
                down <= 0;
            end
        end
        a_prev <= a;
    end
endmodule