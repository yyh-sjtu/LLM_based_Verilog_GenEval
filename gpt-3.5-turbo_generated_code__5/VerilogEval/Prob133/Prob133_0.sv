
module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define states A and B
parameter A = 2'b00;
parameter B = 2'b01;

// Define state register
reg [1:0] state, next_state;

// Define counter to track w values
reg [2:0] w_counter;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
        w_counter <= 0;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        A: begin
            if (s == 1) begin
                next_state = B;
            end else begin
                next_state = A;
            end
            z <= 0; // Output z is always 0 in state A
        end
        B: begin
            case (w)
                1: w_counter <= w_counter + 1;
                0: w_counter <= w_counter;
            end
            if (w_counter == 2) begin
                z <= 1; // Output z is set to 1 if w = 1 in exactly two clock cycles
            end else begin
                z <= 0; // Output z is 0 otherwise
            end
            next_state = B;
        end
    endcase
end

endmodule