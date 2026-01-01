# Scripts Documentation

This directory contains utility scripts for running and managing the DeepNova LLM project.

## Available Scripts

### docker-start.sh
Starts a Docker container with Ascend NPU support for development.

**Usage:**
```bash
bash scripts/docker-start.sh
```

**Features:**
- Uses `dgi-dev:v2-4` image (configurable)
- Mounts Ascend drivers and necessary devices
- Exposes port 9198
- Loads environment from `config/deploy-0.env`
- Configures 64GB shared memory

### run-local.sh
Runs the model locally using the Ascend toolkit installed on the host system.

**Usage:**
```bash
bash scripts/run-local.sh
```

**Requirements:**
- Ascend toolkit must be installed at `/usr/local/Ascend/ascend-toolkit/`
- All 8 NPU devices (0-7) will be used

**Environment:**
- Sets `HF_ENDPOINT` for Hugging Face mirror
- Configures `ASCEND_RT_VISIBLE_DEVICES` for device selection
- Sets `model_path` to model weights location

### run-debug.sh
Runs the model in debug mode with verbose output and limited devices.

**Usage:**
```bash
# Single-device mode
bash scripts/run-debug.sh

# Distributed mode (2 devices)
bash scripts/run-debug.sh d
```

**Features:**
- Enables bash debug mode (`set -x`)
- Uses only 2 NPU devices (0,1)
- Sets `OMP_NUM_THREADS=1` for debugging
- Automatically cleans up `kernel_meta` and `fusion_result.json` after execution

### run-docker.sh
Executes model code inside a running Docker container.

**Usage:**
```bash
bash scripts/run-docker.sh
```

**Configuration:**
- Container name: `dgi-dev-v2-4-deploy-0` (configurable in script)
- Model path: `/data2/model_infer_dev/ascend/qwen3/llm/`
- Runs distributed model by default

**Note:** Requires the Docker container to be running (use `docker-start.sh` first).

## Common Workflows

### Development Setup
```bash
# 1. Start Docker container
bash scripts/docker-start.sh

# 2. Run code in container
bash scripts/run-docker.sh
```

### Local Testing
```bash
# Quick local test
bash scripts/run-local.sh

# Debug mode
bash scripts/run-debug.sh
```

### Distributed Testing
```bash
# 2-device distributed
bash scripts/run-debug.sh d
```

## Environment Variables

All scripts respect the following environment variables:

- `HF_ENDPOINT`: Hugging Face endpoint (default: https://hf-mirror.com)
- `ASCEND_RT_VISIBLE_DEVICES`: NPU devices to use
- `model_path` / `weights_file`: Path to model weights
- `OMP_NUM_THREADS`: OpenMP thread configuration

See `config/.env.example` for complete list.

## Troubleshooting

### Script fails to find Ascend toolkit
Ensure the toolkit is installed:
```bash
ls /usr/local/Ascend/ascend-toolkit/set_env.sh
```

### Docker container not found
Start the container first:
```bash
bash scripts/docker-start.sh
```

### Permission denied
Make scripts executable:
```bash
chmod +x scripts/*.sh
```
