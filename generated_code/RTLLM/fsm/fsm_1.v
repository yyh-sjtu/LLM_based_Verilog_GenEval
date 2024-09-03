
module fsm (
    input wire CLK,
    input wire RST,
    input wire IN,
    output reg MATCH
);

// Define states for the FSM
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

// Define registers for FSM state and current input
reg [1:0] state_reg, state_next;
reg last_IN;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state_reg <= S0;
        MATCH <= 0;
    end
    else begin
        state_reg <= state_next;
    end
end

always @(*) begin
    state_next = state_reg;
    case(state_reg)
        S0: begin
            if (IN) begin
                state_next = S1;
                last_IN = 1;
            end
        end
        S1: begin
            if (!IN) begin
                state_next = S0;
            end
            else begin
                last_IN = 1;
            end
        end
        S2: begin
            if (IN) begin
                state_next = S3;
                last_IN = 1;
            end
        end
        S3: begin
            if (!IN) begin
                state_next = S2;
            end
            else if (last_IN) begin
                MATCH <= 1;
            end
            last_IN = 1;
        end
    endcase
end

endmodule