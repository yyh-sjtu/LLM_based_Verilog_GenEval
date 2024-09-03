
module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

    // State variables
    reg [3:0] state;

    // Next state and output logic
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            state <= 4'b0000;
            MATCH <= 0;
        end
        else begin
            case (state)
                4'b0000: begin
                    if (IN) state <= 4'b0001;
                    else state <= 4'b0000;
                end
                4'b0001: begin
                    if (!IN) state <= 4'b0010;
                    else state <= 4'b0001;
                end
                4'b0010: begin
                    if (!IN) state <= 4'b0011;
                    else state <= 4'b0000;
                end
                4'b0011: begin
                    if (IN) state <= 4'b0100;
                    else state <= 4'b0000;
                end
                4'b0100: begin
                    if (IN) begin
                        MATCH <= 1;
                        state <= 4'b0000;
                    end
                    else state <= 4'b0101;
                end
                4'b0101: begin
                    if (!IN) state <= 4'b0110;
                    else state <= 4'b0000;
                end
                4'b0110: begin
                    if (!IN) state <= 4'b0111;
                    else state <= 4'b0000;
                end
                4'b0111: begin
                    if (IN) state <= 4'b0100;
                    else state <= 4'b0000;
                end
                default: state <= 4'b0000;
            endcase
        end
    end

endmodule