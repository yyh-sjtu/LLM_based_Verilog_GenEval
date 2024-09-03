import re

def verilog_extractor(text):
    begin = text.find("```verilog\n")
    end = text.find("\n```")
    verilog = ""
    
    while begin != -1 and end != -1:
        verilog += text[begin + 10:end]
        begin = text.find("```verilog\n", end)
        end = text.find("\n```", begin)
        
    if not "module" in verilog:
        pattern = r'module\s+[^\(]+\(.*?\);.*?endmodule'
        verilog_code_extracted = re.findall(pattern, text, re.DOTALL)
        for module in verilog_code_extracted:
            verilog += (module + '\n\n')
        
    return verilog

if __name__ == "__main__":
    text = """
```
module radix2_div (
    input wire clk,
    input wire rst,
    input wire sign,
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    input wire opn_valid,
    output wire res_valid,
    output wire [15:0] result
);

    reg [8:0] SR;
    reg [8:0] NEG_DIVISOR;
    reg [3:0] cnt;
    reg [3:0] start_cnt;

    always @(posedge clk) begin
        if (rst) begin
            SR <= 9'b0;
            NEG_DIVISOR <= 9'b0;
            cnt <= 4'b0;
            start_cnt <= 4'b0;
            res_valid <= 1'b0;
        end else if (opn_valid && !res_valid) begin
            SR <= {1'b0, sign ? -dividend : dividend, 1'b0};
            NEG_DIVISOR <= {1'b0, -divisor, 1'b0};
            cnt <= 4'b1;
            start_cnt <= 4'b1;
        end else if (start_cnt) begin
            if (cnt == 4'b1000) begin
                cnt <= 4'b0;
                start_cnt <= 4'b0;
                res_valid <= 1'b1;
                result <= {SR[8:1], SR[0]};
            end else begin
                cnt <= cnt + 1;
                SR <= SR - {1'b0, NEG_DIVISOR[8:1]} + (SR[8] ? 1'b1 : 1'b0);
                SR <= {SR[8:1], SR[0]};
            end
        end else begin
            res_valid <= 1'b0;
        end
    end

endmodule
```
    """
    print(verilog_extractor(text))