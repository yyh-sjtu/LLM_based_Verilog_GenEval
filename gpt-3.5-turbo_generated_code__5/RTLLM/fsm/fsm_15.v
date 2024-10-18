module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

reg [4:0] state;

parameter S0 = 5'b00000;
parameter S1 = 5'b00001;
parameter S2 = 5'b00010;
parameter S3 = 5'b00011;
parameter S4 = 5'b00100;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state <= S0;
        MATCH <= 0;
    end
    else begin
        case (state)
            S0: begin
                if (IN)
                    state <= S1;
            end
            S1: begin
                if (!IN)
                    state <= S2;
            end
            S2: begin
                if (!IN)
                    state <= S3;
            end
            S3: begin
                if (IN)
                    state <= S4;
            end
            S4: begin
                if (IN)
                    MATCH <= 1;
            end
        endcase
    end
end

endmodule

