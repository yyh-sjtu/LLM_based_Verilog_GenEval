module TopModule (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);
    reg [7:0] val;
    reg [7:0] val_next;
    reg [7:0] val_next_next;
    wire val_valid;
    assign val_valid = val_next_next[7];
    assign val_next = val_next_next_next;
    assign val_valid = val_next_next;
    reg [7:0] val_next;
    assign val_valid = val_next_next;
    wire [7:0] val_next_next;
    assign val_next_next = val;
    reg [1:0] state;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val <= 8'b0;
        end else begin
            val <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    assign val_next_next_next = val;
    wire val_valid = val_valid & ~val_valid;
    assign val_valid = val_valid & val_valid;
    assign val_next_next = val_valid & ~val_valid;
    assign val_next = val_valid? val_valid : val;
    wire [7:0] val_next_next = val_valid? val_next : val;
    reg [7:0] val_next_next;
    assign val_next_next = val_valid? val_next : val;
    reg [7:0] val_next_next_next;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    reg [3:0] val_next;
    reg [7:0] val_next_next_next;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next_next <= 8'b0;
        end else begin
            val_next_next <= val;
        end
    end
    assign val_next_next = val;
    assign val_next_next = val_valid? val_next : val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next_next <= 8'b0;
        end else begin
            val_next_next <= val;
        end
    end
    assign val_next_next_next = val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next_next <= val;
        end
    end
    assign val_next_next = val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next_next <= 8'b0;
        end else begin
            val_next_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next_next <= 8'b0;
        end else begin
            val_next_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    assign val_next_next = val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    reg [7:0] val_next;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    assign val_next_next = val;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            val_next <= 8'b0;
        end else begin
            val_next <= val;
        end
    end
    assign val_next_next = val;
    assign val_next_next = val;
    assign val_next_next = val_valid;
    assign val_next_next = val;
    assign val_next_next = val_valid;
    assign val_next = val;
endmodule

