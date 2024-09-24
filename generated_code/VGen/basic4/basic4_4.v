module mux( 
input [4:0] a, b,
input sel,
output [4:0] out );
    
    assign out = sel ? b : a; // Using ternary operator to select either b or a based on sel input
    
endmodule

