module fsm(
    input IN,
    input CLK,
    input RST,
    output reg MATCH
);

reg [4:0] state;
reg [4:0] matched;
reg [1:0] index;

parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;
parameter S4 = 4;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state <= S0;
        matched <= 0;
        index <= 0;
        MATCH <= 0;
    end else begin
        case(state)
            S0: begin
                if (IN == 1) begin
                    state <= S1;
                    matched <= 1;
                    index <= 0;
                end else begin
                    state <= S0;
                    matched <= 0;
                    index <= 0;
                end
            end
            S1: begin
                if (IN == 0) begin
                    state <= S2;
                    matched <= 1;
                    index <= 0;
                end else begin
                    state <= S1;
                    matched <= 0;
                    index <= 0;
                end
            end
            S2: begin
                if (IN == 0) begin
                    state <= S3;
                    matched <= 1;
                    index <= 0;
                end else begin
                    state <= S0;
                    matched <= 1;
                    index <= 0;
                end
            end
            S3: begin
                if (IN == 1) begin
                    state <= S4;
                    matched <= 1;
                    index <= 0;
                end else begin
                    state <= S0;
                    matched <= 0;
                    index <= 0;
                end
            end
            S4: begin
                if (IN == 1) begin
                    state <= S1;
                    matched <= 1;
                    index <= index + 1;
                end else if (IN == 0) begin
                    if (index == 4 || index == 8) begin
                        state <= S4;
                    end else begin
                        state <= S3;
                    end
                    matched <= 0;
                    index <= index + 1;
                end
            end
        endcase
    end
end


always @(posedge CLK) begin
    if (state == S4 && (index == 4 || index == 8)) begin
        MATCH <= matched;
    end
end

endmodule

