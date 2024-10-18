
module TopModule (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

    // Define state encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    
    // Define state and next state variables
    reg [2:0] state, next_state;
    
    // State flip-flop process
    always @(posedge clk) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // State transition process
    always @* begin
        case(state)
            A: begin
                if (r == 3'b000) begin
                    next_state = A;
                end else if (r[0] == 1) begin
                    next_state = B;
                end else if (r[1] == 1) begin
                    next_state = C;
                end else begin
                    next_state = D;
                end
            end
            
            B: begin
                if (r[0] == 1) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            
            C: begin
                if (r[1] == 1) begin
                    next_state = C;
                end else begin
                    next_state = A;
                end
            end
            
            D: begin
                next_state = A;
            end
        endcase
    end

    // FSM outputs
    always @* begin
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
                g = 3'b000;
            end
       endcase
    end

endmodule