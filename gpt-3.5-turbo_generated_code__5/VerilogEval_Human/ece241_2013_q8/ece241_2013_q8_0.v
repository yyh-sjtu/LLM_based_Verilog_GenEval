module fsm (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define states
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// Define state register
reg [1:0] state, next_state;

// Define output logic
always @(state or x) begin
    case(state)
        S0: begin
            if(x == 1'b1) begin
                next_state = S1;
            end else begin
                next_state = S0;
            end
        end
        S1: begin
            if(x == 1'b0) begin
                next_state = S0;
            end else begin
                next_state = S2;
            end
        end
        S2: begin
            next_state = S0;
        end
        default: next_state = S0;
    endcase
end

// State transition logic
always @(posedge clk or negedge aresetn) begin
    if(~aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

// Output logic
always @(state) begin
    if(state == S2) begin
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule

