module serial_two_comp (
    input wire clk,
    input wire areset,
    input wire x,
    output reg z
);

// State definitions
localparam S_IDLE = 2'b00;
localparam S_CONVERT = 2'b01;

// Registers
reg [1:0] state;
reg [31:0] number;
reg [31:0] complement;

// Combinational logic
always @(*) begin
    case(state)
        S_IDLE: begin
            if(!areset) begin
                state = S_IDLE;
                number = 0;
                complement = 0;
            end else begin
                state = S_CONVERT;
                number = {1'b0, number[31:1], x};
            end
        end
        S_CONVERT: begin
            if(!areset) begin
                state = S_IDLE;
                number = 0;
                complement = 0;
            end else begin
                state = S_CONVERT;
                number = {1'b0, number[31:1], x};
            end
        end
    endcase
end

// Sequential logic
always @(posedge clk or negedge areset) begin
    if(!areset) begin
        z <= 0;
    end else begin
        if(state == S_CONVERT) begin
            complement <= -number;
            z <= complement;
        end
    end
end

endmodule

