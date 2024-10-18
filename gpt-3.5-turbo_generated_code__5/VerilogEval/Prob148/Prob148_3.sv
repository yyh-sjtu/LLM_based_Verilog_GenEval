
module TopModule(
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        A: begin
            if (r == 3'b000) begin
                next_state = A;
            end else if (r[0]) begin
                next_state = B;
            end else if (r[1]) begin
                next_state = C;
            end else if (r == 3'b000) begin
                next_state = D;
            end
        end
        B: begin
            if (r[0]) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        C: begin
            if (r[1]) begin
                next_state = C;
            end else begin
                next_state = A;
            end
        end
        D: begin
            if (r == 3'b000) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
    endcase
end

always @(*) begin
    case(state)
        A: begin
            g = 3'b000;
        end
        B: begin
            g = 3'b001;
        end
        C: begin
            g = 3'b010;
        end
        D: begin
            g = 3'b100;
        end
    endcase
end

endmodule