
module TopModule (
    input  clk,
    input  reset,
    input  [7:0] in,
    output [23:0] out_bytes,
    output done
);

  // Internal signals
  reg [2:0] state;
  reg [23:0] message;
  reg [7:0] byte_count;

  // FSM states
  parameter IDLE = 0;
  parameter BYTE1 = 1;
  parameter BYTE2 = 2;
  parameter BYTE3 = 3;
  parameter DONE = 4;

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      message <= 0;
      byte_count <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (in[3]) begin
            message[23:16] <= in;
            state <= BYTE1;
          end else begin
            message <= 0;
            byte_count <= 0;
            state <= IDLE;
          end
        end

        BYTE1: begin
          if (in[3]) begin
            message[15:8] <= in;
            state <= BYTE2;
          end else begin
            message <= 0;
            byte_count <= 0;
            state <= IDLE;
          end
        end

        BYTE2: begin
          if (in[3]) begin
            message[7:0] <= in;
            state <= BYTE3;
          end else begin
            message <= 0;
            byte_count <= 0;
            state <= IDLE;
          end
        end

        BYTE3: begin
          message <= {message[15:0], in};
          byte_count <= byte_count + 1;
          if (byte_count == 2) begin
            state <= DONE;
          end else begin
            state <= BYTE3;
          end
        end

        DONE: begin
          message <= 0;
          byte_count <= 0;
          state <= IDLE;
        end
      endcase
    end
  end

  // Output assignments
  assign out_bytes = message;
  assign done = (state == DONE);

endmodule