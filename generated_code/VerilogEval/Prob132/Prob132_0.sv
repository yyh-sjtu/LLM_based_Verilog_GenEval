
module TopModule (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);

    always @(*) begin
        // Reset shut_off_computer if the CPU is not overheated
        if (cpu_overheated) begin
            shut_off_computer = 1;
        end else begin
            shut_off_computer = 0;  // Ensure it is set to 0 when not overheating
        end
    end

    always @(*) begin
        // Reset keep_driving to a known state
        if (~arrived) begin
            keep_driving = ~gas_tank_empty;  // Driving if gas tank is not empty
        end else begin
            keep_driving = 0;  // Ensure it is set to 0 when arrived
        end
    end

endmodule