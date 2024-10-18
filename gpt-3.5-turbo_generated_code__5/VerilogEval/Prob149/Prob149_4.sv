
module TopModule (
  input clk,
  input reset,
  input [2:0] s,
  output fr2,
  output fr1,
  output fr0,
  output dfr
);
  
  reg [2:0] prev_s;
  
  // Synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      fr0 <= 1'b1;
      dfr <= 1'b1;
      prev_s <= 3'b0;
    end else begin
      prev_s <= s;
      
      // Determine the flow rates based on the water level and previous level
      case ({s[2], s[1], prev_s[2], prev_s[1]})
        4'b1110: begin // Above s[2]
          fr2 <= 1'b0;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b0;
        end
        4'b1100: begin // Between s[2] and s[1]
          fr2 <= 1'b1;
          fr1 <= 1'b0;
          fr0 <= 1'b1;
          dfr <= 1'b0;
        end
        4'b1000: begin // Between s[1] and s[0]
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          fr0 <= 1'b0;
          dfr <= 1'b0;
        end
        4'b0000: begin // Below s[0]
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b1;
        end
        default: begin // Default state, should never occur
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b1;
        end
      endcase
    end
  end
  
endmodule