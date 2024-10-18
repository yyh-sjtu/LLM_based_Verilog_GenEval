module hdlc_framing (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err
);
	reg [4:0] count;
	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 0;
			state <= 0;
		end
		else begin
			case (state)
				0: begin // Idle state
					if (in == 1)
						state <= 1;
					else
						state <= 0;
				end
				1: begin // Checking for 5 consecutive 1s
					if (in == 1) begin
						if (count < 5)
							count <= count + 1;
						else if (count == 5) begin
							count <= 0;
							state <= 2;
						end
					end
					else begin
						count <= 0;
						state <= 0;
					end
				end
				2: begin // Checking for 6th consecutive 1 and 7 or more consecutive 1s
					if (in == 1) begin
						if (count < 6) begin
							count <= count + 1;
							state <= 2;
						end
						else if (count == 6) begin
							count <= 0;
							state <= 3;
						end
						else if (count > 6) begin
							count <= 0;
							state <= 4;
						end
					end
					else begin
						flag <= 1;
						state <= 0;
					end
				end
				3: begin // Error state (7 or more consecutive 1s)
					err <= 1;
					state <= 0;
				end
				4: begin // Discarding a bit
					disc <= 1;
					state <= 0;
				end
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			disc <= 0;
		else
			disc <= 0;
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			flag <= 0;
		else
			flag <= 0;
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			err <= 0;
		else
			err <= 0;
	end
endmodule

module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  wire disc_temp, flag_temp, err_temp;

  hdlc_framing hdlc (
    .clk(clk),
    .reset(reset),
    .in(in),
    .disc(disc_temp),
    .flag(flag_temp),
    .err(err_temp)
  );

  // Delay output signals by one clock cycle
  always @(posedge clk or posedge reset) begin
    if (reset)
    begin
      disc <= 0;
      flag <= 0;
      err <= 0;
    end
    else begin
      disc <= disc_temp;
      flag <= flag_temp;
      err <= err_temp;
    end
  end
endmodule

