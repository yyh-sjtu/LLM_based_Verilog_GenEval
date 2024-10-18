
module TopModule(
    input [6:0] y,
    input w,
    output Y1,
    output Y3
);

    // State registers
    reg [6:0] currentState;
    reg [6:0] nextState;

    // Define state encodings
    localparam [6:0] A = 7'b000001;
    localparam [6:0] B = 7'b000010;
    localparam [6:0] C = 7'b000100;
    localparam [6:0] D = 7'b001000;
    localparam [6:0] E = 7'b010000;
    localparam [6:0] F = 7'b100000;

    // Define the next-state logic
    always @(y or w) begin
        case (currentState)
            A: begin
                nextState = w ? A : B;
            end
            B: begin
                nextState = w ? D : C;
            end
            C: begin
                nextState = w ? D : E;
            end
            D: begin
                nextState = w ? A : F;
            end
            E: begin
                nextState = w ? D : E;
            end
            F: begin
                nextState = w ? D : C;
            end
            default: begin
                nextState = A;
            end
        endcase
    end

    // Update current state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            currentState <= A;
        end else begin
            currentState <= nextState;
        end
    end

    // Output assignments
    assign Y1 = currentState[1];
    assign Y3 = currentState[3];

endmodule