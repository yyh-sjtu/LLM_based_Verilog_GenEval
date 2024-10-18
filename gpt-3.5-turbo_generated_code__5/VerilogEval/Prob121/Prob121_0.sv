
module TopModule (
    input  clk,
    input  reset,
    input  x,
    output z
);

// State declaration
reg [2:0] present_state, next_state;

// Output declaration
reg z_output;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        present_state <= 3'b000;
    end else begin
        present_state <= next_state;
    end
end

// Output logic
always @* begin
    case(present_state)
        3'b000: begin
            next_state = x ? 3'b001 : 3'b000;
            z_output = 1'b0;
        end
        3'b001: begin
            next_state = x ? 3'b100 : 3'b001;
            z_output = 1'b0;
        end
        3'b010: begin
            next_state = x ? 3'b001 : 3'b010;
            z_output = 1'b0;
        end
        3'b011: begin
            next_state = x ? 3'b010 : 3'b001;
            z_output = 1'b1;
        end
        3'b100: begin
            next_state = x ? 3'b100 : 3'b011;
            z_output = 1'b1;
        end
    endcase
end

// Assign output
assign z = z_output;

endmodule