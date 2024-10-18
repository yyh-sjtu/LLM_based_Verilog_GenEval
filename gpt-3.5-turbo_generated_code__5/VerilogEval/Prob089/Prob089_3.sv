
module TopModule (
  input  clk,
  input  areset,
  input  x,
  output z
);

  reg [3:0] state;
  reg [3:0] next_state;
  reg        reset_internal;
  reg        cnt;
  reg        invert;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 4'b0000;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    case (state)
      4'b0000: begin
        if (x == 1'b1) begin
          next_state = 4'b0001;
        end else begin
          next_state = 4'b0000;
        end
      end
      4'b0001: begin
        next_state = 4'b0010;
      end
      4'b0010: begin
        next_state = 4'b0011;
      end
      4'b0011: begin
        if (cnt < 4'b1001) begin
          next_state = 4'b0011;
        end else begin
          next_state = 4'b0100;
        end
      end
      4'b0100: begin
        if (cnt < 4'b1010) begin
          next_state = 4'b0100;
        end else if (cnt == 4'b1010) begin
          next_state = 4'b0101;
        end else begin
          next_state = 4'b0100;
        end
      end
      4'b0101: begin
        next_state = 4'b0110;
      end
      4'b0110: begin
        if (cnt < 4'b1100) begin
          next_state = 4'b0110;
        end else begin
          next_state = 4'b0111;
        end
      end
      4'b0111: begin
        next_state = 4'b0111;
      end
    endcase
  end

  always @(posedge clk) begin
    if (areset) begin
      reset_internal <= 1'b1;
      cnt <= 4'b0000;
      invert <= 1'b0;
    end else begin
      reset_internal <= 1'b0;
      cnt <= cnt + 1'b1;
      case (state)
        4'b0000: begin
          invert <= 1'b0;
        end
        4'b0001: begin
          invert <= ~x;
        end
        4'b0010: begin
          invert <= 1'b0;
        end
        4'b0011: begin
          invert <= 1'b1;
        end
        4'b0100: begin
          invert <= 1'b1;
        end
        4'b0101: begin
          invert <= 1'b0;
        end
        4'b0110: begin
          invert <= 1'b0;
        end
        4'b0111: begin
          invert <= 1'b0;
        end
      endcase
    end
  end

  assign z = invert;

endmodule