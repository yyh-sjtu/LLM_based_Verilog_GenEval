
module TopModule (
  input  wire clk,
  input  wire reset,
  input  wire data,
  output wire start_shifting
);
  
  // States
  reg [1:0] state;
  parameter IDLE = 2'b00;
  parameter S0   = 2'b01;
  parameter S1   = 2'b10;
  parameter DONE = 2'b11;
  
  // Next-state and output logic
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      start_shifting <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data) state <= S0;
        end
        S0: begin
          if (data) state <= S0;
          else state <= S1;
        end
        S1: begin
          if (data) state <= DONE;
          else state <= S0;
        end
        DONE: begin
          state <= IDLE;
        end
      endcase
      start_shifting <= (state == DONE);
    end
  end
endmodule