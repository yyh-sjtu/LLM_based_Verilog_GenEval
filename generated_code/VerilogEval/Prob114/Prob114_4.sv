
module TopModule (
    input  [7:0] code,  // 8-bit input code
    output reg [3:0] out, // 4-bit output for recognized key
    output reg valid // 1-bit output indicating a valid detection
);

// Define the keyboard scancodes for keys 0 through 9
localparam SCAN_0  = 8'h45;
localparam SCAN_1  = 8'h16;
localparam SCAN_2  = 8'h1E;
localparam SCAN_3  = 8'h26;
localparam SCAN_4  = 8'h25;
localparam SCAN_5  = 8'h2E;
localparam SCAN_6  = 8'h36;
localparam SCAN_7  = 8'h3D;
localparam SCAN_8  = 8'h3E;
localparam SCAN_9  = 8'h46;

always @* begin
    // Default states
    out = 4'b0000; // Default to 0
    valid = 1'b0;  // Default to invalid
    
    // Check for valid input codes
    case (code)
        SCAN_0: begin
            out = 4'b0000; // Output '0'
            valid = 1'b1;
        end
        SCAN_1: begin
            out = 4'b0001; // Output '1'
            valid = 1'b1;
        end
        SCAN_2: begin
            out = 4'b0010; // Output '2'
            valid = 1'b1;
        end
        SCAN_3: begin
            out = 4'b0011; // Output '3'
            valid = 1'b1;
        end
        SCAN_4: begin
            out = 4'b0100; // Output '4'
            valid = 1'b1;
        end
        SCAN_5: begin
            out = 4'b0101; // Output '5'
            valid = 1'b1;
        end
        SCAN_6: begin
            out = 4'b0110; // Output '6'
            valid = 1'b1;
        end
        SCAN_7: begin
            out = 4'b0111; // Output '7'
            valid = 1'b1;
        end
        SCAN_8: begin
            out = 4'b1000; // Output '8'
            valid = 1'b1;
        end
        SCAN_9: begin
            out = 4'b1001; // Output '9'
            valid = 1'b1;
        end
        default: begin
            out = 4'b0000; // Default to 0
            valid = 1'b0;  // Invalid case
        end
    endcase
end

endmodule