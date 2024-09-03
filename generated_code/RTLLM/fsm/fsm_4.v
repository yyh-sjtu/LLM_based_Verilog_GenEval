
module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] state;
reg [4:0] input_buffer;

always @ (posedge CLK, posedge RST)
begin
    if(RST)
    begin
        state <= S0;
        MATCH <= 0;
        input_buffer <= 5'b00000;
    end
    else
    begin
        case(state)
            S0:
            begin
                input_buffer <= {input_buffer[3:0], IN};
                if(input_buffer == 5'b10011)
                    state <= S1;
                else
                    state <= S0;
            end
                
            S1:
            begin
                if(IN) 
                    MATCH <= 1;
                state <= S2;
            end
            
            S2:
            begin
                input_buffer <= {input_buffer[3:0], IN};
                if(input_buffer == 5'b10011)
                    state <= S3;
                else
                    state <= S2;
            end
            
            S3:
            begin
                if(IN) 
                    MATCH <= 1;
                state <= S2;
            end
        endcase
    end
end

endmodule