
module TopModule (
    input clk,
    input reset,
    input w,
    output reg z
);

// State encoding
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// State register
reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// State table
always @* begin
    case (state)
        A: begin
            next_state = w ? B : A;
            z = 0;
        end
        B: begin
            next_state = w ? C : D;
            z = 0;
        end
        C: begin
            next_state = w ? E : D;
            z = 0;
        end
        D: begin
            next_state = w ? F : A;
            z = 0;
        end
        E: begin
            next_state = w ? E : D;
            z = 1;
        end
        F: begin
            next_state = w ? C : D;
            z = 1;
        end
    endcase
end

endmodule