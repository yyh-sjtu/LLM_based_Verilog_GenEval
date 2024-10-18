
module TopModule (
    input  wire    clk,
    input  wire    reset,
    input  wire    data,
    output wire    start_shifting
);
    reg [3:0] state;

    // State definitions
    parameter IDLE      = 2'b00;
    parameter SEARCHING = 2'b01;
    parameter FOUND     = 2'b10;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (data) begin
                        state <= SEARCHING;
                    end
                end
                SEARCHING: begin
                    if (data == 1) begin
                        state <= FOUND;
                    end else if (data == 0) begin
                        state <= IDLE;
                    end
                end
                FOUND: begin
                    state <= FOUND;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

    assign start_shifting = (state == FOUND);

endmodule