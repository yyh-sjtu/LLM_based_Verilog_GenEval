import os
from glob import glob
import sys
# ################## for RTLLM
# dir = "/home/yuli2/evaluation_zyh/RTLLM-main"
# target_dir = "/home/yuli2/evaluation_zyh/benchmark/RTLLM"
# case_list = glob(os.path.join(dir, '*'))
# case_list = [item for item in case_list if os.path.isdir(item) and not item.split('/')[-1].startswith('_')]
# for item in case_list:
#     os.system(f"cp -r {item} {target_dir}")
# ##################

# ################## for RTLLM
# dir = "/home/yuli2/evaluation_zyh/VGen-main/prompts-and-testbenches"
# target_dir = "/home/yuli2/evaluation_zyh/benchmark/VGen"
# case_list = glob(os.path.join(dir, '*'))
# case_list = [item for item in case_list if os.path.isdir(item) and not item.split('/')[-1].startswith('_')]
# for item in case_list:
#     os.system(f"cp -r {item} {target_dir}")
# ##################

################## for RTLLM
dir = "/home/yuli2/evaluation_zyh/verilog-eval-main/dataset_spec-to-rtl"
target_dir = "/home/yuli2/evaluation_zyh/benchmark/VerilogEval"
file_list = glob(os.path.join(dir, "*"))
for item in file_list:
    design_name = item.split("/")[-1].split("_")[0]
    design_dir = os.path.join(target_dir, design_name)
    if not os.path.exists(design_dir):
        os.mkdir(design_dir)
    os.system(f"cp {item} {design_dir}")

# dir = "/home/yuli2/evaluation_zyh/verilog-eval-main/benchmark"
# target_dir = "/home/yuli2/evaluation_zyh/benchmark/VerilogEval"
# case_list = glob(os.path.join(dir, '*'))
# case_list = [item for item in case_list if os.path.isdir(item) and not item.split('/')[-1].startswith('_')]
# for item in case_list:
#     os.system(f"cp -r {item} {target_dir}")
##################