
module TopModule (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);
  reg [3:0] state;
  reg [7:0] shift_reg;
  reg [2:0] bit_count;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      shift_reg <= 0;
      bit_count <= 0;
      done <= 0;
      out_byte <= 0;
    end else begin
      case (state)
        0: begin // wait for start bit
          if (in == 0) begin
            state <= 1; // receive first data bit
            bit_count <= 0;
          end
        end
        1: begin // receive data bits
          shift_reg[bit_count] <= in;
          if (bit_count == 7) begin
            state <= 2; // wait for stop bit
          end else begin
            bit_count <= bit_count + 1;
          end
        end
        2: begin // wait for stop bit
          if (in == 1) begin
            state <= 0;
            done <= 1;
            out_byte <= shift_reg;
          end
        end
        default: begin
          state <= 0;
          shift_reg <= 0;
          bit_count <= 0;
          done <= 0;
          out_byte <= 0;
        end
      endcase
    end
  end
endmodule