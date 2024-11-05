import sys
import json
import argparse
from openai import OpenAI
import os
from glob import glob
from tqdm import tqdm


INSTRUCTION_REWRITE = '''
Given the following instruction, help me rewrite it into another format. 
Specifically, the original format is more like a simple specification for a certain design, while the revised format is a simple description along with a defined module head written in Verilog.
Two example inputs and the corresponding outputs are given below:
Example 1
Input: 
"Please act as a professional verilog designer.

Implement the design of unsigned 16bit multiplier based on shifting and adding opration. 
Module name:  
    multi_16bit               
Input ports:
    input clk;       
    input rst_n;      
    input start;      // Chip enable signal. 
    input [15:0] ain; 
    input [15:0] bin;
Output ports:
    output [31:0] yout; // Product output with a data width of 32 bits.
    output done;      // Chip output flag signal. Defined as 1 indicates multiplication operation completion."

Output:
"Description: The module `adder_32bit` implements an unsigned 16bit multiplier based on shifting and adding opration. 
Verilog code:
module multi_16bit (
	input clk,
	input rst_n,
	input start,
	input [15:0] ain,
	input [15:0] bin,
	output [31:0] yout,
	output done
);"

Example 2
Input: 
"Please act as a professional verilog designer.

Implement a module of a carry lookahead 32 bit adder based on CLAs.
Module name:  
    adder_32bit               
Input ports:
    input [32:1] A,
    input [32:1] B
Output ports:
    output [32:1] S,
    output C32"

Output:
"Description: The module `adder_32bit` implements a module of a carry lookahead 32 bit adder based on CLAs.
Verilog code:
module adder_32bit (
	input [32:1] A,
	input[32:1] B,
	output [32:1] S,
	output C32
);"

Note that the output should strictly follow the format: 
"Description: The module {module name} implements ...
Verilog code:
module {module name} (...);"
And you should not add additional information. 
Also, ensure all comments are removed from the Verilog code.
The given instruction is: 
'''


CODET5P_INSTRUCTION = """Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.\n\n
### Instruction:\nBased on the functional description and defined module head, complete the Verilog code. 
Note that you should return the codes only without including additional information. And you should include the module head in the generated codes for completeness.\n
### Input:\n{input}\n\n### Response:"""

file_patterns = {
    "RTLLM": {"prompt_pattern": "design_description.txt",
                "testbench_pattern": "testbench.v"},
    "VGen": {"prompt_pattern": "prompt*", 
                "testbench_pattern": "tb_*"},
    "VerilogEval": {"prompt_pattern": "*prompt.txt", 
                    "testbench_pattern": "*test.sv"},
    "VerilogEval_Human": {"prompt_pattern": "description.txt", 
                            "testbench_pattern": "testbench.sv"},
    "VerilogEval_Machine": {"prompt_pattern": "description.txt", 
                            "testbench_pattern": "testbench.sv"}
}
import re
def verilog_code(text):
    pattern = r'module\s+[^\(\s]+\s*(?:#\s*\(.*\)){0,1}\s*\(.*?\);'

    verilog_code = re.findall(pattern, text, re.DOTALL)[0]
    return f"Verilog code: \n{verilog_code}\n"

def description(text):
    lines = text.split("\n")
    for line in lines:
        if "Description" in line:
            return f"\n{line}\n"


def query_gpt(prompt, model="gpt-4-turbo"):
    client = OpenAI(
        api_key="sk-*******************",
        base_url="*******************"
    )
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ],
        max_tokens=2048,
    )
    return response.choices[0].message.content

def gpt_translate():
    source_benchmarkdir = "benchmark"
    target_benchmarkdir = "benchmark_translated"
    benchmark_list = glob(os.path.join(source_benchmarkdir, "*"))
    for benchmark in benchmark_list:
        print(f"benchmark: {benchmark}")
        design_list = glob(os.path.join(benchmark, "*"))
        for design in tqdm(design_list):
            prompt_path = glob(os.path.join(design, file_patterns[os.path.basename(benchmark)]["prompt_pattern"]))[0]
            with open(prompt_path, 'r') as f:
                prompt = f.read()
            prompt = query_gpt(INSTRUCTION_REWRITE + prompt)
            try:
                prompt = description(prompt) + verilog_code(prompt)
            except:
                print(f"error prompt: \n{prompt}\n")

            prompt = CODET5P_INSTRUCTION.format_map({'input': prompt})
            target_prompt_path = glob(os.path.join(design.replace(source_benchmarkdir, target_benchmarkdir), file_patterns[os.path.basename(benchmark)]["prompt_pattern"]))[0]
            if target_benchmarkdir in target_prompt_path:
                with open(target_prompt_path, 'w') as f:
                    f.write(prompt)

if __name__ == "__main__":
    gpt_translate()

# if __name__ == "__main__":

#     parser = argparse.ArgumentParser()
#     parser.add_argument('--model', type=str, default="gpt-4-turbo")
#     args = parser.parse_args()

#     with open("./revised_instruction_cleaned.json", 'r') as f:
#         data = json.load(f)

#     output = []
#     for i in range(len(data)):
#         print(f"Processing {i + 1} / {len(data)}")
#         instruction = CODET5P_INSTRUCTION.format_map({'input': data[i]['codet5p_instruction']})
#         gpt_code = query_gpt(prompt=instruction, model=args.model)
#         output.append({
#             "id": data[i]["id"],
#             "design": data[i]["design"],
#             "description": data[i]["description"],
#             "codet5p_instruction": data[i]['codet5p_instruction'],
#             "gpt_code": gpt_code
#         })

#         with open(f"tmp_{args.model}.json", 'w') as f:
#             json.dump(output, f, indent=4)
    
#     with open(f"codet5p_instruction_gpt_code_{args.model}.json", 'w') as f:
#         json.dump(output, f, indent=4)

    # ### use gpt to generate revised instructions
    # output = []
    # for i in range(len(data)):
    #     print(f"Processing {i + 1} / {len(data)}")
    #     des = data[i]['description']
    #     revised = query_gpt(prompt=INSTRUCTION_REWRITE+des, model=args.model)
    #     output.append({
    #         "id": i + 1,
    #         "design": data[i]["design"],
    #         "description": data[i]["description"],
    #         "codet5p_instruction": revised
    #     })

    #     with open("tmp.json", 'w') as f:
    #         json.dump(output, f, indent=4)

    # with open(f"revised_instruction.json", 'w') as f:
    #     json.dump(output, f, indent=4)

    

    # ### use gpt to generate codes as baselines
    # output = []
    # for i in range(len(data)):
    #     print(f"Processing {i + 1} / {len(data)}")
    #     des = data[i]['description']
    #     gpt_code = query_gpt(prompt=des, model=args.model)
    #     output.append({
    #         "id": i + 1,
    #         "design": data[i]["design"],
    #         "description": data[i]["description"],
    #         "gpt_code": gpt_code
    #     })

    #     with open("tmp.json", 'w') as f:
    #         json.dump(output, f, indent=4)

    # with open(f"gpt_code_{args.model}.json", 'w') as f:
    #     json.dump(output, f, indent=4)
    