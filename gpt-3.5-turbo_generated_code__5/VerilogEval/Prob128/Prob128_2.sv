
module TopModule (
  input clk,
  input reset,
  input [7:0] in,
  output done
);

  reg [2:0] state;
  reg [2:0] next_state;
  reg [2:0] count;
  reg done_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      count <= 3'b000;
      done_reg <= 1'b0;
    end
    else begin
      state <= next_state;
      count <= count + 1'b1;
      done_reg <= 1'b0;
    end
  end

  always @(state, count, in) begin
    case (state)
      3'b000: begin // Idle state
        if (in[3] == 1'b1) begin
          next_state = 3'b001; // Start of a message
          count = 3'b001; // Reset counter
        end
        else begin
          next_state = 3'b000; // Stay in idle state
          count = 3'b000; // Reset counter
        end
      end
      
      3'b001: begin // Receiving first byte
        if (count == 3'b010) begin
          if (in[3] == 1'b0) // Incorrect message boundary
            next_state = 3'b000; // Return to idle state
          else
            next_state = 3'b010; // Proceed to second byte
        end
      end
      
      3'b010: begin // Receiving second byte
        if (count == 3'b100) begin
          if (in[3] == 1'b0) // Incorrect message boundary
            next_state = 3'b000; // Return to idle state
          else
            next_state = 3'b011; // Proceed to third byte
        end
      end
      
      3'b011: begin // Receiving third byte
        if (count == 3'b110) begin
          if (in[3] == 1'b0) // Incorrect message boundary
            next_state = 3'b000; // Return to idle state
          else begin
            next_state = 3'b000; // Return to idle state
            done_reg = 1'b1; // Message received successfully
          end
        end
      end
    endcase
  end

  assign done = done_reg;

endmodule