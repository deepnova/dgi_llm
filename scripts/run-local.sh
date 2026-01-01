
source /usr/local/Ascend/ascend-toolkit/set_env.sh

set -x

export HF_ENDPOINT=https://hf-mirror.com
export ASCEND_RT_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"
export model_path="/data2/model_infer_dev/ascend/qwen3/llm/dgi_llm/llm/Qwen3-0.6B/model.safetensors"

#python dgi_llm/distributed/model.py
python dgi_llm/llm/model.py
