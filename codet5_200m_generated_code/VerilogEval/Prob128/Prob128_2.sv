module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output done
);
    reg [3:0] byte_counter;
    reg [3:0] counter_reg;
    reg [2:0] state;
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            byte_counter <= 0;
        else
            byte_counter <= byte_counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    reg [1:0] byte_counter_reg;
    reg [2:0] counter_reg;
    reg done_reg;
    always @(posedge clk)
    begin
        if (reset)
            done_reg <= 0;
        else
            done_reg <= done_reg;
    end
    always @(posedge clk)
    begin
        if (reset)
            byte_counter_reg <= 0;
        else
            byte_counter_reg <= byte_counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            byte_counter_reg <= 0;
        else
            byte_counter_reg <= byte_counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            byte_counter_reg <= 0;
        else
            byte_counter_reg <= byte_counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    always @(posedge clk)
    begin
        if (reset)
            counter_reg <= 0;
        else
            counter_reg <= counter_reg + 1'b1;
    end
    assign done = (counter_reg == 3'd0);
endmodule

