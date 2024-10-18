
module TopModule (
  input  clk,
  input  reset,
  input  [7:0] in,
  output reg [23:0] out_bytes,
  output reg done
);

  // State definitions
  localparam IDLE = 2'b00;
  localparam WAIT_BYTE1 = 2'b01;
  localparam WAIT_BYTE2 = 2'b10;

  reg [1:0] state;
  reg [7:0] byte1;
  reg [7:0] byte2;
  reg [7:0] byte3;

  assign out_bytes = {byte1, byte2, byte3};

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      done <= 0;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
    end
    else begin
      case(state)
        IDLE:
          if (in[3] == 1) begin
            byte1 <= in;
            state <= WAIT_BYTE1;
          end
        WAIT_BYTE1:
          begin
            byte2 <= in;
            state <= WAIT_BYTE2;
          end
        WAIT_BYTE2:
          begin
            byte3 <= in;
            state <= IDLE;
            done <= 1;
          end
      endcase
    end
  end

endmodule