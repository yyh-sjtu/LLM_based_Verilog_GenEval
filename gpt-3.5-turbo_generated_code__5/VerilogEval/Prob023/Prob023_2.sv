
module TopModule(
  input wire [99:0] in,
  output wire [99:0] out
);
  
  // Internal wires
  wire [99:0] reversed_in;
  
  // Assign statements
  assign reversed_in = {in[99], in[98], in[97], in[96], in[95], in[94], in[93], in[92], in[91], in[90], in[89], in[88], in[87], in[86], in[85], in[84], in[83], in[82], in[81], in[80], in[79], in[78], in[77], in[76], in[75], in[74], in[73], in[72], in[71], in[70], in[69], in[68], in[67], in[66], in[65], in[64], in[63], in[62], in[61], in[60], in[59], in[58], in[57], in[56], in[55], in[54], in[53], in[52], in[51], in[50], in[49], in[48], in[47], in[46], in[45], in[44], in[43], in[42], in[41], in[40], in[39], in[38], in[37], in[36], in[35], in[34], in[33], in[32], in[31], in[30], in[29], in[28], in[27], in[26], in[25], in[24], in[23], in[22], in[21], in[20], in[19], in[18], in[17], in[16], in[15], in[14], in[13], in[12], in[11], in[10], in[9], in[8], in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};
  assign out = reversed_in;
  
endmodule