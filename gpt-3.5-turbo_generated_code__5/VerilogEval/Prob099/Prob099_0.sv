
module TopModule(
    input [6:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

reg [5:0] currentState;
reg [5:0] nextState;

// State machine logic
always @* begin
    case(currentState)
        6'b000001: nextState = w ? 6'b000001 : 6'b000010;
        6'b000010: nextState = w ? 6'b000100 : 6'b001000;
        6'b000100: nextState = w ? 6'b010000 : 6'b001000;
        6'b001000: nextState = w ? 6'b100000 : 6'b010000;
        6'b010000: nextState = w ? 6'b000100 : 6'b100000;
        6'b100000: nextState = w ? 6'b000010 : 6'b010000;
    endcase
end

always @* begin
    case(y[1])
        1'b0: Y2 = (currentState == 6'b000001 || currentState == 6'b000100 || currentState == 6'b001000 || currentState == 6'b100000) ? 1'b0 : 1'b1;
        1'b1: Y2 = (currentState == 6'b000010 || currentState == 6'b010000 || currentState == 6'b100000 || currentState == 6'b000100) ? 1'b1 : 1'b0;
    endcase

    case(y[3])
        1'b0: Y4 = (currentState == 6'b000001 || currentState == 6'b010000 || currentState == 6'b100000 || currentState == 6'b000010) ? 1'b0 : 1'b1;
        1'b1: Y4 = (currentState == 6'b000100 || currentState == 6'b001000 || currentState == 6'b010000 || currentState == 6'b100000) ? 1'b1 : 1'b0;
    endcase
end

always @(posedge clk or negedge reset) begin
    if(!reset) begin
        currentState <= 6'b000001;
    end else begin
        currentState <= nextState;
    end
end

endmodule