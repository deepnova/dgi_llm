
#source /usr/local/Ascend/ascend-toolkit/set_env.sh
#
#set -x
#
#export HF_ENDPOINT=https://hf-mirror.com
#export ASCEND_RT_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"
#export model_path="/data2/model_infer_dev/ascend/qwen3/llm/dgi_llm/llm/Qwen3-0.6B/model.safetensors"
#
##python dgi_llm/distributed/model.py
#python dgi_llm/llm/model.py

#pip install torch_npu, transformers -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
#source /usr/local/Ascend/atb-models/set_env.sh; \
#source /usr/local/Ascend/nnal/atb/set_env.sh; \

container=dgi-dev-deploy-0
container=dgi-dev-v2-4-deploy-0
model_path=/data2/model_infer_dev/ascend/qwen3/llm/
run_script="dgi_llm/llm/test_qwen3_0_6b.py"
run_script="dgi_llm/distributed/model.py"

docker exec $container bash -c "source /usr/local/Ascend/ascend-toolkit/set_env.sh;\
export ASCEND_RT_VISIBLE_DEVICES=0,1;\
export HF_ENDPOINT=https://hf-mirror.com;\
export weights_file=/data2/model_infer_dev/ascend/qwen3/llm/Qwen3-0.6B/model.safetensors;\
cd /data2/model_infer_dev/ascend/qwen3/llm/ && python $run_script"
