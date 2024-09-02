////Testbench
module carry_select_adder_16bit_tb;
reg [15:0] a,b;
reg cin;
wire [15:0] sum;
wire cout;

  carry_select_adder_16bit uut(.a(a), .b(b),.cin(cin),.sum(sum),.cout(cout));

initial begin
  a=0; b=0; cin=0;
  #10 a=16'd0; b=16'd0; cin=1'd1;
  if (sum != 16'd1) $error("Test failed for a=0, b=0, cin=1");
  #10 a=16'd14; b=16'd1; cin=1'd1;
  if (sum != 16'd16) $error("Test failed for a=14, b=1, cin=1");
  #10 a=16'd5; b=16'd0; cin=1'd0;
  if (sum != 16'd5) $error("Test failed for a=5, b=0, cin=0");
  #10 a=16'd999; b=16'd0; cin=1'd1;
  if (sum != 16'd1000) $error("Test failed for a=999, b=0, cin=1");
  $display("All tests passed");
end

initial
  $monitor( "A=%d, B=%d, Cin= %d, Sum=%d, Cout=%d", a,b,cin,sum,cout);
endmodule