
module TopModule(
  input [15:0] scancode,
  output left,
  output down,
  output right,
  output up
);
  
  // Assigning default values to the outputs
  assign left = 1'b0;
  assign down = 1'b0;
  assign right = 1'b0;
  assign up = 1'b0;
  
  // Mapping scancodes to arrow keys
  always @(*)
    case(scancode[15:0])
      16'he06b: left = 1'b1;
      16'he072: down = 1'b1;
      16'he074: right = 1'b1;
      16'he075: up = 1'b1;
      default: // Anything else
        begin
          left = 1'b0;
          down = 1'b0;
          right = 1'b0;
          up = 1'b0;
        end
    endcase

endmodule