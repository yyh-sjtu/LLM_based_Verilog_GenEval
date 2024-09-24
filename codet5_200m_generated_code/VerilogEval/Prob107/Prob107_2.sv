module TopModule (
    input clk,
    input reset,
    input in,
    output out
);
    reg [1:0] state;
    initial begin
        state = 0;
    end
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
        end
        else begin
            case (state)
                0:    begin
                    state <= 1;
                    out <= 1'b1;
            end
                1:    begin
                    state <= 0;
                    out <= 1'b0;
            end
                2:    begin
                    state <= 1;
                    out <= 1'b0;
            end
                3:    begin
                    state <= 2;
                    out <= 1'b1;
            end
                default:    begin
                    state <= state + 1;
                end
        endcase
    end
endmodule

