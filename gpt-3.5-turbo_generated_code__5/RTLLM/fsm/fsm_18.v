module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

reg [4:0] state;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state <= 0;
        MATCH <= 0;
    end 
    else begin
        case (state)
            0: begin
                if (IN == 1) 
                    state <= 1;
                else 
                    state <= 0;
            end
            1: begin
                if (IN == 0) 
                    state <= 2;
                else 
                    state <= 0;
            end
            2: begin
                if (IN == 0) 
                    state <= 3;
                else 
                    state <= 0;
            end
            3: begin
                if (IN == 1) 
                    state <= 4;
                else 
                    state <= 0;
            end
            4: begin
                if (IN == 1) begin
                    state <= 0;
                    MATCH <= 1;
                end 
                else 
                    state <= 0;
            end
        endcase
    end
end

endmodule

