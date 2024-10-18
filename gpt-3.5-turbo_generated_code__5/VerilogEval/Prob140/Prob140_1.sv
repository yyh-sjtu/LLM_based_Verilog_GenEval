
module TopModule (
  input  clk,
  input  reset,
  input  in,
  output disc,
  output flag,
  output err
);

  reg [2:0] state;
  reg [5:0] count;
  reg disc_next, flag_next, err_next;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000; // State behaves as though the previous input were 0
      count <= 6'b000000;
    end else begin
      case (state)
        3'b000: begin // Initial state
          if (in) begin
            state <= 3'b001;
            count <= 6'b000001;
          end
        end
        3'b001: begin // Detecting the first consecutive 1
          if (in) begin
            state <= 3'b010;
            count <= count + 1'b1;
          end else begin
            state <= 3'b000;
            count <= 6'b000000;
          end
        end
        3'b010: begin // Detecting consecutive 1s
          if (in) begin
            if (count == 6'b011110) begin
              state <= 3'b011;
              count <= count + 1'b1;
            end else begin
              state <= 3'b010;
              count <= count + 1'b1;
            end
          end else begin
            state <= 3'b000;
            count <= 6'b000000;
          end
        end
        3'b011: begin // Detecting flag or error
          if (in) begin
            if (count == 6'b011111) begin
              state <= 3'b100;
              count <= count + 1'b1;
            end else if (count >= 6'b100000) begin
              state <= 3'b101;
              count <= count + 1'b1;
            end else begin
              state <= 3'b001;
              count <= 6'b000001;
            end
          end else begin
            state <= 3'b000;
            count <= 6'b000000;
          end
        end
        3'b100: begin // Flag detected
          state <= 3'b000;
          count <= 6'b000000;
        end
        3'b101: begin // Error detected
          state <= 3'b000;
          count <= 6'b000000;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case (state)
      3'b001, 3'b010: begin
        disc_next <= 1'b1;
        flag_next <= 1'b0;
        err_next <= 1'b0;
      end
      3'b100: begin
        disc_next <= 1'b0;
        flag_next <= 1'b1;
        err_next <= 1'b0;
      end
      3'b101: begin
        disc_next <= 1'b0;
        flag_next <= 1'b0;
        err_next <= 1'b1;
      end
      default: begin
        disc_next <= 1'b0;
        flag_next <= 1'b0;
        err_next <= 1'b0;
      end
    endcase
  end

  assign disc = disc_next;
  assign flag = flag_next;
  assign err = err_next;

endmodule