module TopModule (
  input  clk,
  input  reset,
  input  data,
  output [3:0] count,
  output counting,
  output done,
  input  ack
);

  reg [2:0] state;
  reg [3:0] delay;
  reg [10:0] counter;
  reg [3:0] remaining;

  wire start;
  wire [3:0] count_reg;

  // Detect start sequence (1101)
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      delay <= 0;
      counter <= 0;
      remaining <= 0;
    end else begin
      case (state)
        0: begin
          if (data == 1'b1 && prev_data == 1'b1 && prev_prev_data == 1'b0 && prev_prev_prev_data == 1'b1) begin
            state <= 1;
          end
        end
        1: begin
          delay <= {data, prev_data, prev_prev_data, prev_prev_prev_data};
          state <= 2;
        end
        2: begin
          counting <= 1;
          state <= 3;
        end
        3: begin
          if (counter == (delay + 1) * 1000 - 1) begin
            counting <= 0;
            done <= 1;
            state <= 4;
          end
        end
        4: begin
          if (ack == 1'b1) begin
            done <= 0;
            state <= 0;
          end
        end
      endcase
    end

    prev_prev_prev_data <= prev_prev_data;
    prev_prev_data <= prev_data;
    prev_data <= data;
  end

  // Counter for tracking elapsed time
  always @(posedge clk) begin
    if (reset || state != 3) begin
      counter <= 0;
      remaining <= delay;
    end else begin
      if (counter == (delay + 1) * 1000 - 1) begin
        counter <= 0;
        remaining <= remaining - 1;
      end else begin
        counter <= counter + 1;
      end
    end
  end

  // Output port assignment
  assign count_reg = (state == 3) ? remaining : 4'bxxxx;
  assign count = count_reg;
  assign start = (state == 1);
  
endmodule

