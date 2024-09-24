
module TopModule (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);

    // Initializing the outputs to default values
    initial begin
        shut_off_computer = 0;
        keep_driving = 0;
    end

    always @(*) begin
        // Logic for shut_off_computer
        if (cpu_overheated) 
            shut_off_computer = 1;
        else 
            shut_off_computer = 0; // Ensure it gets reset when not overheated
    end

    always @(*) begin
        // Logic for keep_driving
        if (~arrived) 
            keep_driving = ~gas_tank_empty; // Continue driving if not arrived and gas tank is not empty
        else 
            keep_driving = 0; // If arrived, ensure keep_driving is reset
    end

endmodule