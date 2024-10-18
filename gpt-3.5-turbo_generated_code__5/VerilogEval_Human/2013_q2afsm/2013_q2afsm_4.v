module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    
    reg [3:1] state;
    
    // State assignments
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    
    // Outputs
    assign g[1] = (state == A && r[1]) || (state == B && r[1]);
    assign g[2] = (state == B && r[2]) || (state == C && r[2]);
    assign g[3] = (state == C && r[3]);
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (r[1]) begin
                        state <= B;
                    end else if (r[2]) begin
                        state <= C;
                    end else if (r[3]) begin
                        state <= D;
                    end
                end
                B: begin
                    if (r[1]) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                C: begin
                    if (r[2]) begin
                        state <= C;
                    end else begin
                        state <= A;
                    end
                end
                D: begin
                    if (r[1] || r[2] || r[3]) begin
                        state <= D;
                    end else begin
                        state <= A;
                    end
                end
            endcase
        end
    end
endmodule

