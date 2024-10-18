
module TopModule (
    input [2:0] y,
    input w,
    output reg Y1
);

reg [2:0] next_state;

always @* begin
    case(y)
        3'b000: begin
            if(w == 1'b0) begin
                next_state = 3'b001; // A --> B
            end else begin
                next_state = 3'b000; // A --> A
            end
        end
        
        3'b001: begin
            if(w == 1'b0) begin
                next_state = 3'b010; // B --> C
            end else begin
                next_state = 3'b011; // B --> D
            end
        end
        
        3'b010: begin
            if(w == 1'b0) begin
                next_state = 3'b100; // C --> E
            end else begin
                next_state = 3'b011; // C --> D
            end
        end
        
        3'b011: begin
            if(w == 1'b0) begin
                next_state = 3'b110; // D --> F
            end else begin
                next_state = 3'b000; // D --> A
            end
        end
        
        3'b100: begin
            if(w == 1'b0) begin
                next_state = 3'b100; // E --> E
            end else begin
                next_state = 3'b011; // E --> D
            end
        end
        
        3'b110: begin
            if(w == 1'b0) begin
                next_state = 3'b010; // F --> C
            end else begin
                next_state = 3'b011; // F --> D
            end
        end
        
        default: begin
            next_state = 3'b000; // Default state is A
        end
    endcase
end

always @(posedge clk) begin
    y <= next_state;
    Y1 <= y[1];
end
    
endmodule