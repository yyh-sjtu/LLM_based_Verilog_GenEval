
module TopModule (
    input [2:0] y,
    input w,
    output reg Y1
);

reg [2:0] next_state;

always @(*) begin
    case(y)
        3'b000: begin
            if(w == 0)
                next_state = 3'b001;
            else if(w == 1)
                next_state = 3'b000;
        end
        3'b001: begin
            if(w == 0)
                next_state = 3'b010;
            else if(w == 1)
                next_state = 3'b011;
        end
        3'b010: begin
            if(w == 0)
                next_state = 3'b100;
            else if(w == 1)
                next_state = 3'b011;
        end
        3'b011: begin
            if(w == 0)
                next_state = 3'b100;
            else if(w == 1)
                next_state = 3'b000;
        end
        3'b100: begin
            if(w == 0)
                next_state = 3'b100;
            else if(w == 1)
                next_state = 3'b011;
        end
        3'b101: begin
            if(w == 0)
                next_state = 3'b100;
            else if(w == 1)
                next_state = 3'b011;
        end
    endcase
end

always @(posedge CLK) begin
    y <= next_state;
end

assign Y1 = y[1];

endmodule