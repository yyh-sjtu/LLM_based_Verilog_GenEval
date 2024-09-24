
module TopModule (
    input  [7:0] in,  // 8-bit input
    output reg [2:0] pos // 3-bit output
);

    always @* begin
        // Initialize pos to 3'b000 (zero)
        pos = 3'b000;

        // Check the input vector for the least significant 1-bit
        if (in[0]) begin
            pos = 3'd0; // Position 0
        end else if (in[1]) begin
            pos = 3'd1; // Position 1
        end else if (in[2]) begin
            pos = 3'd2; // Position 2
        end else if (in[3]) begin
            pos = 3'd3; // Position 3
        end else if (in[4]) begin
            pos = 3'd4; // Position 4
        end else if (in[5]) begin
            pos = 3'd5; // Position 5
        end else if (in[6]) begin
            pos = 3'd6; // Position 6
        end else if (in[7]) begin
            pos = 3'd7; // Position 7
        end
        // If no input bits are high, pos will remain 000 as initialized
    end

endmodule
module testbench;
    reg [7:0] test_in;
    wire [2:0] test_pos;

    TopModule uut (
        .in(test_in),
        .pos(test_pos)
    );

    initial begin
        // Test cases
        test_in = 8'b00000000;  // Expected output: 3'b000
        #10;
        
        test_in = 8'b00000001;  // Expected output: 3'b000
        #10;

        test_in = 8'b00000100;  // Expected output: 3'b010
        #10;

        test_in = 8'b10010000;  // Expected output: 3'b100
        #10;

        test_in = 8'b11000000;  // Expected output: 3'b000
        #10;

        $stop;
    end
endmodule