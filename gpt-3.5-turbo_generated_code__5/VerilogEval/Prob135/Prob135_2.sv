
module TopModule (
    input [2:0] y,
    input w,
    output reg Y1
);

reg [2:0] next_state;

always @(*) begin
    case(y)
        3'b000: begin // State A
            if(w) begin
                next_state = 3'b000; // Stay in state A
            end else begin
                next_state = 3'b001; // Move to state B
            end
        end
        3'b001: begin // State B
            if(w) begin
                next_state = 3'b100; // Move to state D
            end else begin
                next_state = 3'b010; // Move to state C
            end
        end
        3'b010: begin // State C
            if(w) begin
                next_state = 3'b011; // Move to state D
            end else begin
                next_state = 3'b100; // Move to state E
            end
        end
        3'b011: begin // State D
            if(w) begin
                next_state = 3'b000; // Move to state A
            end else begin
                next_state = 3'b101; // Move to state F
            end
        end
        3'b100: begin // State E
            if(w) begin
                next_state = 3'b011; // Move to state D
            end else begin
                next_state = 3'b100; // Stay in state E
            end
        end
        3'b101: begin // State F
            if(w) begin
                next_state = 3'b010; // Move to state C
            end else begin
                next_state = 3'b011; // Move to state D
            end
        end
    endcase
end

always @(posedge clk) begin
    y <= next_state;
end

assign Y1 = y[1];

endmodule