
module TopModule(
    input wire in,
    input wire [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    // Default values
    next_state = 10'b0000000000;
    out1 = 0;
    out2 = 0;

    if (state[0]) begin // S0
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[1] = (in == 1) ? 1 : 0;
    end else if (state[1]) begin // S1
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[2] = (in == 1) ? 1 : 0;
    end else if (state[2]) begin // S2
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[3] = (in == 1) ? 1 : 0;
    end else if (state[3]) begin // S3
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[4] = (in == 1) ? 1 : 0;
    end else if (state[4]) begin // S4
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[5] = (in == 1) ? 1 : 0;
    end else if (state[5]) begin // S5
        next_state[8] = (in == 0) ? 1 : 0;
        next_state[6] = (in == 1) ? 1 : 0;
    end else if (state[6]) begin // S6
        next_state[9] = (in == 0) ? 1 : 0;
        next_state[7] = (in == 1) ? 1 : 0;
    end else if (state[7]) begin // S7
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[7] = (in == 1) ? 1 : 0;
        out2 = 1; // S7 output
    end else if (state[8]) begin // S8
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[1] = (in == 1) ? 1 : 0;
        out1 = 1; // S8 output
    end else if (state[9]) begin // S9
        next_state[0] = (in == 0) ? 1 : 0;
        next_state[1] = (in == 1) ? 1 : 0;
        out1 = 1; // S9 output
        out2 = 1; // S9 output
    end
end

endmodule