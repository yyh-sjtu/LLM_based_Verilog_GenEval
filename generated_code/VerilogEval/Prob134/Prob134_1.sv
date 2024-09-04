
module TopModule(
    input x,
    input [2:0] y,
    output Y0,
    output z
);

reg [2:0] next_state_x0;
reg [2:0] next_state_x1;

always @(*)
begin
    case(y)
        3'b000: begin
            next_state_x0 = 3'b000;
            next_state_x1 = 3'b001;
            z = 1'b0;
        end
        3'b001: begin
            next_state_x0 = 3'b001;
            next_state_x1 = 3'b100;
            z = 1'b0;
        end
        3'b010: begin
            next_state_x0 = 3'b010;
            next_state_x1 = 3'b001;
            z = 1'b0;
        end
        3'b011: begin
            next_state_x0 = 3'b001;
            next_state_x1 = 3'b010;
            z = 1'b1;
        end
        3'b100: begin
            next_state_x0 = 3'b011;
            next_state_x1 = 3'b100;
            z = 1'b1;
        end
    endcase
end

assign Y0 = next_state_x1[0];
    
endmodule