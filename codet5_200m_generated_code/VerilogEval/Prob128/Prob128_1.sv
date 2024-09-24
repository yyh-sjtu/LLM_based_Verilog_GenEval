module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output done
);
    reg [3:0] state, next_state;
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 0;
        else
            state <= next_state;
    end
    reg [7:0] msg;
    reg [3:0] count;
    reg [3:0] msg_start, msg_stop;
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_start <= 0;
        else
            msg_start <= msg_start + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            count <= 0;
        else
            count <= count + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_start <= 0;
        else
            msg_start <= msg_start + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_start <= 0;
        else
            msg_start <= msg_start + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_start <= 0;
        else
            msg_start <= msg_start + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            msg_stop <= 0;
        else
            msg_stop <= msg_stop + 1;
    end
    assign done = msg_stop > msg_start && msg_stop <= msg_stop - msg_start;
endmodule

