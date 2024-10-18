
module TopModule (
    input clk,
    input areset,
    input j,
    input k,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 0;
        else
        begin
            case (state)
                0: if (j) state <= 1;
                   else state <= 0;
                1: if (k) state <= 0;
                   else state <= 1;
            endcase
        end
    end

    always @(state)
    begin
        case (state)
            0: out <= 0;
            1: out <= 1;
        endcase
    end

endmodule