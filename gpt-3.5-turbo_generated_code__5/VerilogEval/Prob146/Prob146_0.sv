
module TopModule(
  input  wire clk,
  input  wire in,
  input  wire reset,
  output reg [7:0] out_byte,
  output reg done
);

// Define states for the finite state machine
localparam [2:0] IDLE  = 3'b000;
localparam [2:0] START = 3'b001;
localparam [2:0] DATA  = 3'b010;
localparam [2:0] STOP  = 3'b011;

// Define internal signals
reg [2:0] state;
reg [7:0] data_byte;
reg       start_bit_detected;
reg       stop_bit_detected;
reg       data_bit_counter;

// Sequential logic
always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    out_byte <= 0;
    done <= 0;
  end
  else begin

    // State transition logic
    case (state)
      IDLE: begin
        if (in == 0) begin
          state <= START;
          start_bit_detected <= 1;
          data_byte <= 0;
          data_bit_counter <= 0;
        end
        else begin
          state <= IDLE;
          start_bit_detected <= 0;
          done <= 0;
        end
      end
      
      START: begin
        state <= DATA;
      end
      
      DATA: begin
        if (data_bit_counter < 8) begin
          data_byte[data_bit_counter] <= in;
          data_bit_counter <= data_bit_counter + 1;
        end
        else begin
          state <= STOP;
        end
      end
      
      STOP: begin
        if (in == 1) begin
          stop_bit_detected <= 1;
          state <= IDLE;
          out_byte <= data_byte;
          done <= 1;
        end
        else begin
          stop_bit_detected <= 0;
          state <= STOP;
        end
      end
    endcase
  end
end

endmodule