module TopModule (
    input cpu_overheated,
    output reg shut_off_computer,
    input arrived,
    input gas_tank_empty,
    output reg keep_driving
);
    always @(posedge cpu_overheated) begin
        if (arrived) begin
            shut_off_computer <= 1'b1;
            keep_driving <= 1'b0;
        end
        else begin
            shut_off_computer <= 1'b0;
            keep_driving <= 1'b0;
        end
    end
endmodule

