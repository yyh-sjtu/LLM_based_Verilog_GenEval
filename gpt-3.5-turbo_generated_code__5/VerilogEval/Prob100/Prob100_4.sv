
module TopModule (
  input  wire in,
  input  wire [1:0] state,
  output wire [1:0] next_state,
  output wire out
);

  assign out = (state == 2'b11); // Output logic based on state

  always @* begin
    case(state) // State transition logic based on current state and input
      2'b00:
        if(in == 1'b0)
          next_state = 2'b00;
        else if(in == 1'b1)
          next_state = 2'b01;
      2'b01:
        if(in == 1'b0)
          next_state = 2'b10;
        else if(in == 1'b1)
          next_state = 2'b01;
      2'b10:
        if(in == 1'b0)
          next_state = 2'b00;
        else if(in == 1'b1)
          next_state = 2'b11;
      2'b11:
        if(in == 1'b0)
          next_state = 2'b10;
        else if(in == 1'b1)
          next_state = 2'b01;
    endcase
  end

endmodule