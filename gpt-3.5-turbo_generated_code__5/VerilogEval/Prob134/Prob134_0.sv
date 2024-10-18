
module TopModule(
  input x,
  input [2:0] y,
  output Y0,
  output z
);

  reg [2:0] next_state;
  wire [2:0] present_state;

  assign present_state = y;

  always @(present_state or x) begin
    case(present_state)
      3'b000: begin
                if(x == 1'b0)
                  next_state = 3'b001;
                else
                  next_state = 3'b000;
              end

      3'b001: begin
                if(x == 1'b0)
                  next_state = 3'b100;
                else
                  next_state = 3'b001;
              end

      3'b010: begin
                if(x == 1'b0)
                  next_state = 3'b001;
                else
                  next_state = 3'b010;
              end

      3'b011: begin
                if(x == 1'b0)
                  next_state = 3'b010;
                else
                  next_state = 3'b001;
              end

      3'b100: begin
                if(x == 1'b0)
                  next_state = 3'b100;
                else
                  next_state = 3'b011;
              end

      default: next_state = 3'b000;
    endcase
  end

  assign Y0 = next_state[0];
  assign z = (next_state == 3'b011) || (next_state == 3'b100);

endmodule