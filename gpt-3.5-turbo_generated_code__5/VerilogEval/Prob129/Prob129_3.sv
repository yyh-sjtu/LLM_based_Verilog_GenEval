
module TopModule (
    input  clk,
    input  aresetn,
    input  x,
    output z
);

    reg [2:0] state, next_state;
    reg z_reg;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    always @(state or x) begin
        next_state = state;
        z_reg = 1'b0;

        case (state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (x)
                    next_state = S2;
                else
                    next_state = S0;
            end

            S2: begin
                if (x)
                    next_state = S1;
                else begin
                    next_state = S0;
                    z_reg = 1'b1;
                end
            end
        endcase
    end

    assign z = z_reg;

endmodule