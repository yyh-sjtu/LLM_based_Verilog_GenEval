
module TopModule (
    input clk,
    input areset,
    input x,
    output reg z
);
    reg [2:0] state;
    reg x_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 3'b000;
        else begin
            case (state)
                3'b000: begin  // Idle state, waiting for reset release
                    if (!areset)
                        state <= 3'b001;
                end
                3'b001: begin  // Conversion state
                    x_reg <= x;
                    state <= 3'b010;
                end
                3'b010: begin  // Complement calculation state
                    z <= ~x_reg;
                    state <= 3'b011;
                end
                3'b011: begin  // Done state
                    state <= 3'b011;
                end
            endcase
        end
    end

endmodule