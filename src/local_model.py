from tqdm import tqdm
import torch
from transformers import AutoModelForSeq2SeqLM, AutoTokenizer, AutoModel
from human_eval.data import write_jsonl
import json

import os
os.environ["TOKENIZERS_PARALLELISM"] = "false"

### GLOBAL SETTINGS
# os.environ["CUDA_VISIBLE_DEVICES"] = '4'
device = torch.device("cuda:1" if torch.cuda.is_available() else "cpu")
# print(f"device: {device}")

DESCRIPTION_INSTRUCTION = """Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.\n\n
### Instruction:\nGenerate a simple yet accurate functional description for the given Verilog code.\n\n### Input:\n"""

GENERATION_INSTRUCTION = """Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.\n\n
### Instruction:\nBased on the prompt, output the verilog code.\n\n### Input:\n"""

INSTRUCTION = "\n\n### Response:"


class codet5():
    def __init__(self,
                 instruction = 'generation',
                 model ='/data1/yliu22/lcm/rtl/github_run/saved_models/instruct_codet5p_220m_bimodal_all_8_21_3/final_checkpoint',
                 tokenizer='Salesforce/codet5p-220m-bimodal',
                 temperature=0.8,
                 N=5,
                 max_len=2048,
                 decoding_style='sampling',
                 num_seqs_per_iter=1,
                 num_beams=4
                 ) -> None:
        self.instruction = instruction
        self.model_path = model
        self.tokenizer = tokenizer
        self.temperature = temperature
        self.N = N
        self.max_len = max_len
        self.decoding_style = decoding_style
        self.num_seqs_per_iter = num_seqs_per_iter
        self.num_beams = num_beams



        self.tokenizer = AutoTokenizer.from_pretrained(self.tokenizer)
        if '220m' in self.model_path:
            self.model = AutoModel.from_pretrained(self.model_path, trust_remote_code=True)
        if '6b' in self.model_path:
            self.model = AutoModelForSeq2SeqLM.from_pretrained(self.model_path, 
                                                        torch_dtype=torch.float16, 
                                                        trust_remote_code=True,
                                                        low_cpu_mem_usage=True)
        self.model.eval()
        self.model.to(device)
        self.prompt_to_decoder = True if any([size in self.model_path for size in ['2b', '6b', '16b']]) else False

    def completion_create(self, prompt):

        if self.instruction == 'generation':
            _input = prompt
            prompt = GENERATION_INSTRUCTION + _input + INSTRUCTION
        elif self.instruction == 'description':
            _input = prompt
            prompt = DESCRIPTION_INSTRUCTION + _input + INSTRUCTION
        prompt = prompt.replace('    ', '\t')
        tokens = self.tokenizer.tokenize(prompt)
        num_tokens = len(tokens)

        assert(num_tokens <= 2048)
        prompt_batch = [prompt]
        prompt_batch_decoder = [prompt]
        completion_seqs = []

        encoding = self.tokenizer(prompt_batch, return_tensors="pt", truncation=True, max_length=self.max_len).to(device)
        encoding_decoder = self.tokenizer(prompt_batch_decoder, return_tensors="pt", truncation=True,
                                    max_length=self.max_len).to(device)
        
        if self.decoding_style == 'sampling':
            loops = int(self.N / self.num_seqs_per_iter)
        else:
            loops = 1
        # leave argument controls whether the progress bar remains on the screen after the iteration is complete
        for _ in tqdm(range(loops), total=loops, leave=False, ncols=0):

            with torch.no_grad():
                if self.decoding_style == 'sampling':
                    if self.prompt_to_decoder:
                        gen_tokens = self.model.generate(**encoding,
                                                    decoder_input_ids=encoding_decoder['input_ids'],
                                                    do_sample=True, # when set to True, the model will use sampling for generation instead of greedy decoding
                                                    temperature=self.temperature,
                                                    max_length=self.max_len,
                                                    num_return_sequences=self.num_seqs_per_iter,
                                                    decoder_start_token_id=self.tokenizer.pad_token_id,
                                                    eos_token_id=self.tokenizer.eos_token_id,
                                                    num_beams=self.num_beams,
                                                    # max_new_tokens=2048,
                                                    top_p=0.95) # implements nucleus sampling, a technique where the model considers only the top p cumulative probability mass of the predicted tokens
                    else:
                        gen_tokens = self.model.generate(**encoding,
                                                    do_sample=True,
                                                    temperature=self.temperature,
                                                    max_length=self.max_len,
                                                    num_return_sequences=self.num_seqs_per_iter,
                                                    eos_token_id=self.tokenizer.eos_token_id,
                                                    num_beams=self.num_beams,
                                                    # max_new_tokens=2048,
                                                    top_p=0.95)
                        
            if gen_tokens is not None:
                if self.prompt_to_decoder:
                    gen_tokens = gen_tokens[:, encoding_decoder['input_ids'].shape[-1] + 1:]
                gen_seqs = self.tokenizer.batch_decode(gen_tokens, skip_special_tokens=True)
            else:
                gen_seqs = None

            if gen_seqs is not None:
                for seq_idx, gen_seq in enumerate(gen_seqs):
                    completion_seq = gen_seq
                    completion_seq = completion_seq.replace('\t', '    ')
                    
        return completion_seq

# codet5_model = codet5()

if __name__ == '__main__':
    prompt = """
Please act as a professional verilog designer.

Implement a module to achieve serial input data accumulation output, input is 8bit data. The valid_in will be set to 1 before the first data comes in. Whenever the module receives 4 input data, the data_out outputs 4 received data accumulation results and sets the valid_out to be 1 (will last only 1 cycle).

"""
    model = codet5()
    # print(prompt)
    print(model.completion_create(prompt))