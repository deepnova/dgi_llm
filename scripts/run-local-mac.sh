#!/bin/bash

# Skip Ascend toolkit (not available on macOS)
# source /usr/local/Ascend/ascend-toolkit/set_env.sh

set -x

# Use HuggingFace mirror (optional)
export HF_ENDPOINT=https://hf-mirror.com

# Set model weights path to the downloaded model
export weights_file="$PWD/models/Qwen/Qwen3-0.6B/model.safetensors"

export OMP_NUM_THREADS=1

# Set PYTHONPATH to include the python/dgi_llm directory
export PYTHONPATH="$PWD/python/dgi_llm:$PYTHONPATH"

# Run the test from project root using uv (handles virtual environment automatically)
uv run python python/dgi_llm/llm/test.py

# Clean up generated files
rm -fr kernel_meta fusion_result.json