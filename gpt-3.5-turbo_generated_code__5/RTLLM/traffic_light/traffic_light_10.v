module traffic_light (
  input rst_n,
  input clk,
  input pass_request,
  output reg [7:0] clock,
  output reg red,
  output reg yellow,
  output reg green
);

// Parameters
parameter idle = 2'b00;
parameter s1_red = 2'b01;
parameter s2_yellow = 2'b10;
parameter s3_green = 2'b11;

// Registers and wires
reg [7:0] cnt;
reg [1:0] state;
reg p_red, p_yellow, p_green;

// State transition logic
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state <= idle;
  end else begin
    case (state)
      idle: state <= s1_red;
      s1_red: state <= (cnt == 3) ? s3_green : s1_red;
      s2_yellow: state <= (cnt == 3) ? s1_red : s2_yellow;
      s3_green: state <= (cnt == 3) ? s2_yellow : s3_green;
      default: state <= idle;
    endcase
  end
end

// Counting logic
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    cnt <= 10;
  end else begin
    case (state)
      s1_red: cnt <= (pass_request && (cnt > 10)) ? 10 : cnt - 1;
      s2_yellow: cnt <= (cnt == 0) ? 5 : cnt - 1;
      s3_green: cnt <= (cnt == 0) ? 60 : cnt - 1;
      default: cnt <= cnt;
    endcase
  end
end

// Output assignment
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    p_red <= 0;
    p_yellow <= 0;
    p_green <= 0;
  end else begin
    p_red <= red;
    p_yellow <= yellow;
    p_green <= green;
  end
end

assign clock = cnt;
assign red = (state != s3_green);
assign yellow = (state == s2_yellow);
assign green = (state == s3_green);

endmodule

