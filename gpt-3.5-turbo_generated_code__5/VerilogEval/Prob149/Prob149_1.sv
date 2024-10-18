
module TopModule(
  input clk,
  input reset,
  input [2:0] s,
  output fr2,
  output fr1,
  output fr0,
  output dfr
);

  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      state <= 2'b11; // Initialize to high water level state
    else begin
      case(state)
        2'b00: begin
          // Above s[2]
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          fr0 <= 1'b0;
          dfr <= 1'b0;
          if(s[2] == 1'b0)
            state <= 2'b01;
        end
        2'b01: begin
          // Between s[2] and s[1]
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          fr0 <= 1'b1;
          dfr <= 1'b0;
          if(s[1] == 1'b0)
            state <= 2'b10;
          else if(s[2] == 1'b1)
            state <= 2'b00;
        end
        2'b10: begin
          // Between s[1] and s[0]
          fr2 <= 1'b0;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b0;
          if(s[0] == 1'b0)
            state <= 2'b11;
          else if(s[1] == 1'b1)
            state <= 2'b01;
        end
        2'b11: begin
          // Below s[0]
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b1;
          if(s[0] == 1'b1)
            state <= 2'b10;
        end
      endcase
    end
  end

endmodule