
module TopModule (
    input wire x,
    input wire [2:0] y,
    output reg Y0,
    output reg z
);
    // Next state logic based on the current state and input x
    always @* begin
        // Default values
        Y0 = 0;
        z = 0;

        case (y)
            3'b000: begin
                if (x) begin
                    Y0 = 0; // Next state is 000
                    z = 0;  // Output z = 0
                end else begin
                    Y0 = 1; // Next state is 001
                    z = 0;  // Output z = 0
                end
            end

            3'b001: begin
                if (x) begin
                    Y0 = 0; // Next state is 100
                    z = 0;  // Output z = 0
                end else begin
                    Y0 = 1; // Next state is 001
                    z = 0;  // Output z = 0
                end
            end

            3'b010: begin
                if (x) begin
                    Y0 = 1; // Next state is 001
                    z = 0;  // Output z = 0
                end else begin
                    Y0 = 0; // Next state is 010
                    z = 0;  // Output z = 0
                end
            end

            3'b011: begin
                if (x) begin
                    Y0 = 0; // Next state is 010
                    z = 1;  // Output z = 1
                end else begin
                    Y0 = 1; // Next state is 001
                    z = 1;  // Output z = 1
                end
            end

            3'b100: begin
                if (x) begin
                    Y0 = 0; // Next state is 100
                    z = 1;  // Output z = 1
                end else begin
                    Y0 = 1; // Next state is 011
                    z = 1;  // Output z = 1
                end
            end

            default: begin
                Y0 = 0;
                z = 0;  // Default case
            end
        endcase
    end

endmodule