
module TopModule (
    input  wire clk,
    input  wire areset,
    input  wire train_valid,
    input  wire train_taken,
    output wire [1:0] state
);

    reg [1:0] counter;

    always @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01;
        else if (train_valid) begin
            if (train_taken) begin
                if (counter < 2'b11)
                    counter <= counter + 1;
            end else begin
                if (counter > 2'b00)
                    counter <= counter - 1;
            end
        end
    end

    assign state = counter;

endmodule