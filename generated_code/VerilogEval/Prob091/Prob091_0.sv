
module TopModule (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

// State transition logic
always @* begin
    case(y)
        6'b000001: begin // State A
            if(w)
                y = 6'b000010; // Transition to State B
            else
                y = 6'b000001; // Remain in State A
        end
        6'b000010: begin // State B
            if(w)
                y = 6'b000100; // Transition to State C
            else
                y = 6'b001000; // Transition to State D
        end
        6'b000100: begin // State C
            if(w)
                y = 6'b010000; // Transition to State E
            else
                y = 6'b001000; // Transition to State D
        end
        6'b001000: begin // State D
            if(w)
                y = 6'b100000; // Transition to State F
            else
                y = 6'b000001; // Transition to State A
        end
        6'b010000: begin // State E
            if(w)
                y = 6'b010000; // Remain in State E
            else
                y = 6'b001000; // Transition to State D
        end
        6'b100000: begin // State F
            if(w)
                y = 6'b000100; // Transition to State C
            else
                y = 6'b001000; // Transition to State D
        end
    endcase
end

// Output signals
always @(posedge clk) begin
    Y1 <= y[1]; // Output Y1 is the input of state flip-flop y[1]
    Y3 <= y[3]; // Output Y3 is the input of state flip-flop y[3]
end

endmodule