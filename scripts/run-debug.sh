#!/bin/bash

source /usr/local/Ascend/ascend-toolkit/set_env.sh
set -x

export ASCEND_RT_VISIBLE_DEVICES=0,1
#TODO remove HF_ENDPOINT
export HF_ENDPOINT=https://hf-mirror.com
export weights_file=/data2/model_infer_dev/ascend/qwen3/llm/Qwen3-0.6B/model.safetensors
export OMP_NUM_THREADS=1

if [ "$1" = "d" ]; then
  torchrun --nproc_per_node=2 --nnodes=1 dgi_llm/distributed/model.py
else
  python dgi_llm/llm/test.py
fi

rm -fr kernel_meta fusion_result.json
