
module TopModule (
  input clk,
  input reset,
  input [7:0] in,
  output reg done
);
  
  // Finite State Machine states  
  parameter IDLE = 0;
  parameter SEARCH_FOR_START = 1;
  parameter BYTE_1_RECEIVED = 2;
  parameter BYTE_2_RECEIVED = 3;
  parameter BYTE_3_RECEIVED = 4;
  
  reg [2:0] state;
  reg [7:0] byte1, byte2, byte3;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      done <= 0;
    end
    else begin
      case(state)
        IDLE:
          if (in[3] == 1)
            state <= SEARCH_FOR_START;
        
        SEARCH_FOR_START:
          if (in[3] == 1) begin
            byte1 <= in;
            state <= BYTE_1_RECEIVED;
          end
          
        BYTE_1_RECEIVED:
          byte2 <= in;
          state <= BYTE_2_RECEIVED;
        
        BYTE_2_RECEIVED:
          byte3 <= in;
          state <= BYTE_3_RECEIVED;
        
        BYTE_3_RECEIVED:
          state <= SEARCH_FOR_START;
          done <= 1;
      endcase
    end
  end

endmodule