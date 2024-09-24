module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output done
);
    reg [3:0] state;
    reg [3:0] message;
    reg [7:0] byte_stream;
    reg [3:0] byte_index;
    reg byte_ready;
    reg byte_received;
    reg byte_received_ready;
    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            state <= 2'b00;
            message <= 3'b001;
            byte_stream <= 8'b0010;
            byte_index <= 3'b000;
            byte_ready <= 1'b0;
        end
        else begin
            state <= state + 1'b1;
            message <= {message[3:0], message[7:1]};
            byte_stream <= {byte_stream[3:0], byte_stream[7:1]};
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_ready <= 1'b0;
        else begin
            byte_ready <= 1'b0;
            byte_ready <= 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b001;
        else begin
            byte_index <= byte_index + 1'b1;
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
        end
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            byte_index <= 3'b000;
        else begin
            byte_index <= byte_index + 1'b1;
        end
    end
    assign done = (byte_ready & byte_index[3]) | (byte_ready & byte_index[2]) | (byte_index[1] & byte_index[0]);
endmodule

