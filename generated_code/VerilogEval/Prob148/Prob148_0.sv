
module TopModule (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// State definition
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Internal signals
reg [1:0] state;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (r[0]) state <= B;
                else if (r[1]) state <= C;
                else if (r[2]) state <= D;
            end
            B: begin
                if (r[0]) state <= B;
                else if (~r[0]) state <= A;
            end
            C: begin
                if (r[1]) state <= C;
                else if (~r[1]) state <= A;
            end
            D: begin
                if (r[0] || r[1] || r[2]) state <= D;
                else state <= A;
            end
        endcase
    end
end

// FSM outputs
always @(*) begin
    case (state)
        A: g = 3'b000;
        B: g = 3'b001;
        C: g = 3'b010;
        D: g = 3'b100;
    endcase
end

endmodule