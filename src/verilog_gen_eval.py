# LM_based_Verilog_GenEval: A comprehensive generation and evaluation framework for LLM based Verilog code generation
# Author: Yunhao Zhou

from tqdm import tqdm
import os
import argparse
from LLM_caller import llm_call
from extractor import verilog_extractor
from glob import glob
from verilog_syntax_function_eval import evaluate
from datetime import datetime

os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

benchmark_list = [
    "RTLLM",
    "VGen",
    "VerilogEval"
]

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_name", type=str, default="gpt-3.5-turbo")
    parser.add_argument("--benchmark", type=str, default="RTLLM")
    parser.add_argument("--api_key", type=str, default="sk")
    parser.add_argument("--base_url", type=str, default="")
    parser.add_argument("--pass_at_n", type=int, default=5)  # pass@5
    parser.add_argument("--temp_outputfile", type=str, default="temp_output/test.vvp")
    parser.add_argument("--correctness_file", type=str, default=f"correctness/correctness_file{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt")
    parser.add_argument("--gen_only", action='store_true', help="If set, only generate code without evaluation")
    parser.add_argument("--eval_only", action='store_true', help="If set, only run evaluation without generating code")
    
        
    args = parser.parse_args()
    
    if args.gen_only and args.eval_only:
        raise ValueError("Cannot set both gen_only and eval_only")
    
    if not os.path.exists(os.path.dirname(args.temp_outputfile)):
        os.mkdir(os.path.dirname(args.temp_outputfile))
        
    if not os.path.exists(os.path.dirname(args.correctness_file)):
        os.mkdir(os.path.dirname(args.correctness_file))
    
    return args

def get_file_content(file_path):
    with open(file_path, "r") as f:
        content = f.read()
    return content

def write_file(content, file_path):
    with open(file_path, "w") as f:
        f.write(content)
        
def append_file(content, file_path):
    with open(file_path, "a") as f:
        f.write(content)

def test_on_benchmark(args):
    
    def get_prompt_file(design_dir, prompt_pattern):
        return glob(os.path.join(design_dir, prompt_pattern))[0]
    
    def get_testbench_file(design_dir, tb_pattern):
        return glob(os.path.join(design_dir, tb_pattern))[0]
    
    benchmarks = []
    if args.benchmark in benchmark_list:
        benchmarks.append(args.benchmark)
    elif args.benchmark == "all":
        benchmarks = benchmark_list
    else:
        raise ValueError("Invalid benchmark")
    
    file_patterns = {
        "RTLLM": {"prompt_pattern": "design_description.txt",
                  "testbench_pattern": "testbench.v"},
        "VGen": {"prompt_pattern": "prompt*", 
                 "testbench_pattern": "tb_*"},
        "VerilogEval": {"prompt_pattern": "*prompt.txt", 
                        "testbench_pattern": "*test.sv"}
    }
    
    for benchmark in benchmarks:
        
        prompt_pattern = file_patterns[benchmark]["prompt_pattern"]
        testbench_pattern = file_patterns[benchmark]["testbench_pattern"]
        
        if benchmark == "VGen":
            prompt_type = input("please choose prompt_type(1/2/3): ")
            if not (prompt_type == "1" or prompt_type == "2" or prompt_type == "3"):
                raise ValueError("Invalid prompt_type for VGen")
            prompt_pattern = prompt_pattern.replace("prompt", "prompt" + prompt_type)

        print(f"Start testing benchmark: {benchmark}")
        if not args.eval_only:
            
            base_dir = f"benchmark/{benchmark}"
            design_dir_list = glob(os.path.join(base_dir, "*"))
            
            print(f"Start generating Verilog code for {benchmark}")
            for design_dir in tqdm(design_dir_list):
                prompt = get_file_content(get_prompt_file(design_dir, prompt_pattern))
                
                if benchmark == "VGen":
                    prompt = "Please act as a professional verilog designer. \n Implement the following module.\n" + prompt
                
                design_name = os.path.basename(design_dir)
                generated_design_dir = os.path.join("generated_code", benchmark, design_name)
                os.makedirs(generated_design_dir, exist_ok=True)

                for i in range(args.pass_at_n):
                    text = llm_call(args.model_name, prompt, args.api_key, args.base_url)
                    verilog_code = verilog_extractor(text)
                    write_file(text, os.path.join(generated_design_dir, f"{design_name}_{i}.txt"))
                    write_file(verilog_code, os.path.join(generated_design_dir, 
                        f"{design_name}_{i}.v" if not benchmark == "VerilogEval" else f"{design_name}_{i}.sv"))
                
        if not args.gen_only:
            print(f"Start evaluating Verilog code for {benchmark}")
            append_file(f"Evaluation results of {benchmark}:\n", args.correctness_file)
            if not os.path.exists(os.path.join("generated_code", benchmark)):
                print(f"Please generate the Verilog code of benchmard {benchmark} first!")
                
            generated_design_dir_list = glob(os.path.join("generated_code", benchmark, "*"))
            generated_design_dir_list.sort()
            for generated_design_dir in tqdm(generated_design_dir_list):
                design_name = os.path.basename(generated_design_dir)
                generated_design_file_list = glob(os.path.join(generated_design_dir, "*.v" if not benchmark == "VerilogEval" else f"*.sv"))
                
                correct_count = 0
                total_tests = 0
                for generated_design_file in generated_design_file_list:
                    testbench = get_testbench_file(generated_design_dir.replace("generated_code", "benchmark"), testbench_pattern)
                    if evaluate(benchmark, generated_design_file, testbench, args.temp_outputfile):
                        correct_count += 1
                    total_tests += 1
                
                if total_tests > 0:
                    correctness_rate = (correct_count / total_tests) * 100
                    append_file(f"{design_name}: {correctness_rate}% correct\n", args.correctness_file)
            
            append_file(f"{'-'*20}\n", args.correctness_file)
        
def test_RTLLM(args):
    prompt_file = "design_description.txt"
    testbench_file = "testbench.v"
    base_dir = "benchmark/RTLLM"
    benchmark = os.path.basename(base_dir)
    
    design_dir_list = glob(os.path.join(base_dir, "*"))
    
    for design_dir in tqdm(design_dir_list):
        prompt = get_file_content(os.path.join(design_dir, prompt_file))
        
        design_name = os.path.basename(design_dir)
        generated_design_dir = os.path.join("generated_code", benchmark, design_name)
        os.makedirs(generated_design_dir, exist_ok=True)
        
        for i in range(args.pass_at_n):
            text = llm_call(args.model_name, prompt, args.api_key, args.base_url)
            verilog_code = verilog_extractor(text)
            write_file(text, os.path.join(generated_design_dir, f"{design_name}_{i}.txt"))
            write_file(verilog_code, os.path.join(generated_design_dir, f"{design_name}_{i}.v"))
            
def test_VGen(args):
    def get_prompt_file(design_dir, prompt_pattern):
        return glob(os.path.join(design_dir, prompt_pattern))[0]
    
    def get_testbench_file(design_dir, tb_pattern):
        return glob(os.path.join(design_dir, tb_pattern))[0]
        
        
    prompt_type = input("Please choose prompt_type(1/2/3): ")
    if not (prompt_type == "1" or prompt_type == "2" or prompt_type == "3"):
        raise ValueError("Invalid prompt_type for VGen")
    
    prompt_pattern = f"prompt{prompt_type}_*"
    testbench_pattern = "tb_*"
    base_dir = "benchmark/VGen"
    benchmark = os.path.basename(base_dir)
    
    design_dir_list = glob(os.path.join(base_dir, "*"))
    
    for design_dir in tqdm(design_dir_list):
        prompt_file = get_prompt_file(design_dir, prompt_pattern)
        prompt = get_file_content(os.path.join(design_dir, prompt_file))
        
        design_name = os.path.basename(design_dir)
        generated_design_dir = os.path.join("generated_code", design_name)
        os.makedirs(generated_design_dir, benchmark, exist_ok=True)
        
        for i in range(args.pass_at_n):
            text = llm_call(args.model_name, prompt, args.api_key, args.base_url)
            verilog_code = verilog_extractor(text)
            write_file(text, os.path.join(generated_design_dir, f"{design_name}_{i}.txt"))
            write_file(verilog_code, os.path.join(generated_design_dir, f"{design_name}_{i}.v"))
            
def test_VerilogEval(args):
    def get_prompt_file(design_dir, prompt_pattern):
        return glob(os.path.join(design_dir, prompt_pattern))[0]
    
    def get_testbench_file(design_dir, tb_pattern):
        return glob(os.path.join(design_dir, tb_pattern))[0]
    
    prompt_pattern = "*prompt.txt"
    testbench_pattern = "*test.sv"
    base_dir = "benchmark/VerilogEval"
    benchmark = os.path.basename(base_dir)
    
    design_dir_list = glob(os.path.join(base_dir, "*"))
    
    for design_dir in tqdm(design_dir_list):
        design_name = os.path.basename(design_dir)
        prompt_file = get_prompt_file(design_dir, prompt_pattern)
        
        prompt = get_file_content(os.path.join(design_dir, prompt_file))
        
        generated_design_dir = os.path.join("generated_code", design_name)
        os.makedirs(generated_design_dir, benchmark, exist_ok=True)
        
        for i in range(args.pass_at_n):
            text = llm_call(args.model_name, prompt, args.api_key, args.base_url)
            verilog_code = verilog_extractor(text)
            write_file(text, os.path.join(generated_design_dir, f"{design_name}_{i}.txt"))
            write_file(verilog_code, os.path.join(generated_design_dir, f"{design_name}_{i}.v"))
    
    
benchmark = {
    "RTLLM": test_RTLLM,
    "VGen": test_VGen,
    "VerilogEval": test_VerilogEval
}

# if __name__ == "__main__":
#     args = get_args()
#     if args.benchmark in benchmark:
#         benchmark[args.benchmark](args)
#     elif args.benchmark == "all":
#         print("all benchmark")
#     else:
#         print("Invalid benchmark name")

if __name__ == "__main__":
    args = get_args()
    test_on_benchmark(args)
    

