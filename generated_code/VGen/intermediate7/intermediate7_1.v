module
always @(*) begin
    Out32 = 32'b0; // Initialize output to all zeros
    
    for(i=0; i<len_table; i=i+1) begin
        Out32[In32table[i]] = In32[i]; // Assign input bits to output based on permutation table
    end
end

endmodule

// Testbench code to verify the functionality of P_box module
module P_box_tb;
reg [31:0] In32;
wire [31:0] Out32;

P_box dut (
    .In32(In32),
    .Out32(Out32)
);

initial begin
    In32 = 32'b10101010101010101010101010101010; // Input data
    #10;
    $display("Input: %b", In32);
    $display("Output: %b", Out32);
    
    // Add more test cases here
    
    $finish;
end
endmodule

