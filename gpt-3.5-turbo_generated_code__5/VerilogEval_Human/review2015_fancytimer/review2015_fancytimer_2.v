module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
  
  reg [3:0] delay;
  reg [2:0] state;
  reg [2:0] next_state;
  reg [15:0] shift_register;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counting <= 0;
      done <= 0;
      state <= 0;
    end
    else begin
      case (state)
        
        0: begin // Searching for start sequence
          if (data === 4'b1101) begin
            shift_register <= {shift_register[11:0], data};
            next_state <= 1;
          end
          else begin
            shift_register <= {shift_register[11:0], data};
            next_state <= 0;
          end
        end
        
        1: begin // Shifting in next 4 bits
          shift_register <= {shift_register[11:0], data};
          next_state <= 2;
        end
        
        2: begin // Start counting
          delay <= shift_register[11:8];
          counting <= 1;
          next_state <= 3;
        end
        
        3: begin // Countdown
          if (counting) begin
            count <= delay;
            delay <= delay - 1;
            if (delay === 0) begin
              counting <= 0;
              done <= 1;
              next_state <= 4;
            end
          end
          else begin
            next_state <= 0;
          end
        end
        
        4: begin // Wait for ack
          if (ack) begin
            done <= 0;
            next_state <= 0;
          end
        end
        
      endcase
      state <= next_state;
    end
  end
  
endmodule

