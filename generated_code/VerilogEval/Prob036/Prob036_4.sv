
module TopModule (
    input wire ring,
    input wire vibrate_mode,
    output reg ringer,
    output reg motor
);
    
    always @(*) begin
        // Default outputs
        ringer = 0;
        motor = 0;

        // Check if there's an incoming call
        if (ring) begin
            // If vibrate mode is active, turn on the motor
            if (vibrate_mode) begin
                motor = 1;
            end
            // If not in vibrate mode, turn on the ringer
            else begin
                ringer = 1;
            end
        end
    end

endmodule