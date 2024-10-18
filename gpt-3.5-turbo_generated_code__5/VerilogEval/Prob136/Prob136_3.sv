
module TopModule(
    input clk,
    input reset,
    input w,
    output reg z
);

enum [2:0] states = {A, B, C, D, E, F};

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        A: begin
            if (w == 0) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (w == 0) begin
                next_state = C;
            end else begin
                next_state = D;
            end
        end
        C: begin
            if (w == 0) begin
                next_state = E;
            end else begin
                next_state = D;
            end
        end
        D: begin
            if (w == 0) begin
                next_state = F;
            end else begin
                next_state = A;
            end
        end
        E: begin
            if (w == 0) begin
                next_state = E;
            end else begin
                next_state = D;
            end
        end
        F: begin
            if (w == 0) begin
                next_state = C;
            end else begin
                next_state = D;
            end
        end
    endcase
end

always @(state) begin
    case (state)
        A, B, C, D: begin
            z = 0;
        end
        E, F: begin
            z = 1;
        end
    endcase
end

endmodule