module lemming (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // walking left
        end else begin
            case (state)
                2'b00: begin // walking left state
                    if (bump_right && bump_left) begin
                        state <= 2'b01; // switch directions
                    end else if (bump_right) begin
                        state <= 2'b01; // switch directions
                    end else if (~bump_left) begin
                        state <= 2'b01; // switch directions
                    end else begin
                        state <= 2'b00; // continue walking left
                    end
                end
                
                2'b01: begin // walking right state
                    if (bump_right && bump_left) begin
                        state <= 2'b00; // switch directions
                    end else if (bump_left) begin
                        state <= 2'b00; // switch directions
                    end else if (~bump_right) begin
                        state <= 2'b00; // switch directions
                    end else begin
                        state <= 2'b01; // continue walking right
                    end
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    
endmodule

module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    lemming dut (
        .clk(clk),
        .areset(areset),
        .bump_left(bump_left),
        .bump_right(bump_right),
        .walk_left(walk_left),
        .walk_right(walk_right)
    );
    
endmodule

