
module TopModule (
    input  wire x,
    input  wire [2:0] y,
    output reg  Y0,
    output reg  z
);

    // Next state logic based on present state y and input x
    always @(*) begin
        case (y)
            3'b000: begin
                if (x)
                    Y0 = 1'b0;  // Next state is 001
                else
                    Y0 = 1'b0;  // Next state is still 000
                z = 1'b0;    // Output z is 0
            end

            3'b001: begin
                if (x)
                    Y0 = 1'b1;  // Next state is 100
                else
                    Y0 = 1'b1;  // Next state is still 001
                z = 1'b0;    // Output z is 0
            end

            3'b010: begin
                if (x)
                    Y0 = 1'b1;  // Next state is 001
                else
                    Y0 = 1'b0;  // Next state is still 010
                z = 1'b0;    // Output z is 0
            end

            3'b011: begin
                if (x)
                    Y0 = 1'b0;  // Next state is 010
                else
                    Y0 = 1'b1;  // Next state is still 001
                z = 1'b1;    // Output z is 1
            end

            3'b100: begin
                if (x)
                    Y0 = 1'b0;  // Next state is still 100
                else
                    Y0 = 1'b1;  // Next state is 011
                z = 1'b1;    // Output z is 1
            end

            default: begin
                Y0 = 1'b0;  // Default case
                z = 1'b0;   // Default case
            end
        endcase
    end

endmodule