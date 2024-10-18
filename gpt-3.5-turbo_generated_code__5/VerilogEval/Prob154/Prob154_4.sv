
module TopModule(
  input  clk,
  input  reset,
  input  [7:0] in,
  output reg [23:0] out_bytes,
  output reg done
);
  
  reg [1:0] state;
  reg [7:0] byte1;
  reg [7:0] byte2;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;
      out_bytes <= 24'b0;
      done <= 0;
    end
    else begin
      case (state)
        2'b00: begin // Idle State
          if (in[3]) begin
            byte1 <= in;
            state <= 2'b01;
          end
        end
        2'b01: begin // Next Byte State
          byte2 <= in;
          state <= 2'b10;
        end
        2'b10: begin // Done State
          if (!in[3]) begin
            state <= 2'b00;
            done <= 1;
          end
          else begin
            out_bytes[23:16] <= byte1;
            out_bytes[15:8] <= byte2;
            out_bytes[7:0] <= in;
          end
        end
      endcase
    end
  end

endmodule