
module TopModule (
    input x,
    input [2:0] y,
    output Y0,
    output z
);

    reg [2:0] next_state;
    reg [2:0] present_state;

    assign Y0 = next_state[0];

    always @ (x or y) begin
        case (present_state)
            3'b000:
                begin
                    if (x)
                        next_state = 3'b001;
                    else
                        next_state = 3'b000;
                    z = 1'b0;
                end
            3'b001:
                begin
                    if (x)
                        next_state = 3'b100;
                    else
                        next_state = 3'b001;
                    z = 1'b0;
                end
            3'b010:
                begin
                    if (x)
                        next_state = 3'b001;
                    else
                        next_state = 3'b010;
                    z = 1'b0;
                end
            3'b011:
                begin
                    if (x)
                        next_state = 3'b010;
                    else
                        next_state = 3'b001;
                    z = 1'b1;
                end
            3'b100:
                begin
                    if (x)
                        next_state = 3'b100;
                    else
                        next_state = 3'b011;
                    z = 1'b1;
                end
        endcase
    end

    always @(posedge clk) begin
        present_state <= next_state;
    end

endmodule