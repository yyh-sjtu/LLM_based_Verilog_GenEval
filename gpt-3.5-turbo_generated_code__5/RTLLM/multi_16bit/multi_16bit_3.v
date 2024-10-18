module multi_16bit (
    input clk,
    input rst_n,
    input start,
    input [15:0] ain,
    input [15:0] bin,
    output reg [31:0] yout,
    output reg done
);

reg [4:0] i; // shift count register
reg done_r; // multiplication completion flag

reg [15:0] areg; // multiplicand register
reg [15:0] breg; // multiplier register
reg [31:0] yout_r; // product register

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i <= 0; // reset shift count register
    end else begin
        if (start && (i < 17)) begin
            i <= i + 1; // increment shift count register
        end else if (!start) begin
            i <= 0; // reset shift count register
        end
    end

    // multiplication completion flag generation
    if (!rst_n) begin
        done_r <= 1'b0; // reset multiplication completion flag
    end else begin
        if (i == 16) begin
            done_r <= 1'b1; // set multiplication completion flag
        end else if (i == 17) begin
            done_r <= 1'b0; // reset multiplication completion flag
        end
    end

    // shift and accumulate operation
    if (!rst_n) begin
        areg <= 16'b0; // reset multiplicand register
        breg <= 16'b0; // reset multiplier register
        yout_r <= 32'b0; // reset product register
    end else begin
        if (start) begin
            if (i == 0) begin
                areg <= ain; // store multiplicand
                breg <= bin; // store multiplier
            end else if ((i > 0) && (i < 17)) begin
                if (areg[i-1] == 1'b1) begin
                    yout_r <= yout_r + (breg << (i-1)); // accumulate shifted value of the multiplier
                end
            end
        end
    end
end

assign yout = yout_r; // assign product output

always @(posedge clk) begin
    done <= done_r; // assign multiplication completion flag
end

endmodule

