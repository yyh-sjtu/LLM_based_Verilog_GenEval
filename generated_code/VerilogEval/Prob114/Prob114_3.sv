
module TopModule (
    input wire [7:0] code,  // 8-bit input
    output reg [3:0] out,   // 4-bit output
    output reg valid        // 1-bit output
);

    // Parameters for scancodes for keys 0 through 9
    parameter CODE_0 = 8'h45; // Key '0'
    parameter CODE_1 = 8'h16; // Key '1'
    parameter CODE_2 = 8'h1E; // Key '2'
    parameter CODE_3 = 8'h26; // Key '3'
    parameter CODE_4 = 8'h25; // Key '4'
    parameter CODE_5 = 8'h2E; // Key '5'
    parameter CODE_6 = 8'h36; // Key '6'
    parameter CODE_7 = 8'h3D; // Key '7'
    parameter CODE_8 = 8'h3E; // Key '8'
    parameter CODE_9 = 8'h46; // Key '9'

    // Combinational logic
    always @(*) begin
        // Default outputs
        out = 4'b0000;
        valid = 1'b0;

        // Check the input codes and assign output
        case (code)
            CODE_0: begin
                out = 4'd0;
                valid = 1'b1;
            end
            CODE_1: begin
                out = 4'd1;
                valid = 1'b1;
            end
            CODE_2: begin
                out = 4'd2;
                valid = 1'b1;
            end
            CODE_3: begin
                out = 4'd3;
                valid = 1'b1;
            end
            CODE_4: begin
                out = 4'd4;
                valid = 1'b1;
            end
            CODE_5: begin
                out = 4'd5;
                valid = 1'b1;
            end
            CODE_6: begin
                out = 4'd6;
                valid = 1'b1;
            end
            CODE_7: begin
                out = 4'd7;
                valid = 1'b1;
            end
            CODE_8: begin
                out = 4'd8;
                valid = 1'b1;
            end
            CODE_9: begin
                out = 4'd9;
                valid = 1'b1;
            end
            default: begin
                // No action needed; out and valid remain default if not matched
            end
        endcase
    end

endmodule