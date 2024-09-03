module abro( 
    input clk,
    input reset,
    input a,
    input b,
    output reg z );

    parameter IDLE = 2'b00,
              SA = 2'b01,
              SB = 2'b10,
              SAB = 2'b11;

    reg [1:0] cur_state, next_state;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cur_state <= IDLE;
            z <= 0;
        end else begin
            cur_state <= next_state;
            case(cur_state)
                IDLE: begin
                    if(a && b) next_state <= SAB;
                    else if(a) next_state <= SA;
                    else if(b) next_state <= SB;
                    else next_state <= IDLE;
                end
                SA: begin
                    if(b && a) next_state <= SAB;
                    else if(!a) next_state <= IDLE;
                    else next_state <= SA;
                end
                SB: begin
                    if(a && b) next_state <= SAB;
                    else if(!b) next_state <= IDLE;
                    else next_state <= SB;
                end
                SAB: begin
                    next_state <= IDLE;
                    z <= 1;
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule

