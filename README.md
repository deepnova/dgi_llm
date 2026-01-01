# DeepNova LLM

LLM inference platform built from the ground up, optimized for Ascend NPU hardware.

## Overview

DeepNova is a lightweight LLM inference server designed for efficient model deployment on Ascend NPU infrastructure. It provides both single-device and distributed inference capabilities.

## Project Structure

```
deepnova/
├── config/              # Configuration files
│   ├── .env.example    # Environment variable template
│   └── deploy-0.env    # Deployment configuration
├── scripts/            # Utility scripts
│   ├── docker-start.sh # Start Docker container
│   ├── run-local.sh    # Run locally with Ascend toolkit
│   ├── run-debug.sh    # Run in debug mode
│   └── run-docker.sh   # Run inside Docker container
├── dgi_llm/            # Core LLM library (submodule)
├── Makefile            # Common commands
└── README.md           # This file
```

## Prerequisites

- **Hardware**: Ascend NPU (910B or compatible)
- **Software**:
  - Ascend Toolkit (CANN 8.2.RC1 or later)
  - Docker (for containerized deployment)
  - Python 3.11+

## Quick Start

### 1. Environment Setup

Copy the example environment file and configure it:

```bash
cp config/.env.example config/.env
# Edit config/.env with your model paths
```

### 2. Run Options

#### Using Makefile (Recommended)

```bash
# Show all available commands
make help

# Start Docker container
make docker-start

# Run locally (requires Ascend toolkit installed)
make run-local

# Run in debug mode
make run-debug

# Run inside Docker
make run-docker

# Clean generated files
make clean
```

#### Manual Execution

```bash
# Start Docker container
bash scripts/docker-start.sh

# Run locally
bash scripts/run-local.sh

# Run in debug mode
bash scripts/run-debug.sh
```

## Configuration

### Environment Variables

Key environment variables (see `config/.env.example`):

- `HF_ENDPOINT`: Hugging Face mirror endpoint
- `ASCEND_RT_VISIBLE_DEVICES`: NPU devices to use (e.g., "0,1,2,3,4,5,6,7")
- `model_path`: Path to model weights file
- `weights_file`: Alternative weights file path
- `OMP_NUM_THREADS`: OpenMP thread count

### Docker Configuration

Docker settings are in `scripts/docker-start.sh`:

- **Image**: `dgi-dev:v2-4` (configurable)
- **Port**: 9198
- **Shared Memory**: 64GB
- **Devices**: Ascend NPU devices mounted

## Development

### Debug Mode

Run with debug flags and limited devices:

```bash
bash scripts/run-debug.sh      # Single-device mode
bash scripts/run-debug.sh d    # Distributed mode (2 devices)
```

### Distributed Training

Use `torchrun` for multi-device training:

```bash
torchrun --nproc_per_node=2 --nnodes=1 dgi_llm/distributed/model.py
```

## DGI LLM Library

The `dgi_llm/` directory contains the core inference library. See `dgi_llm/README.md` for details.

## Troubleshooting

### Common Issues

1. **NPU not detected**: Ensure Ascend toolkit is properly installed and sourced:
   ```bash
   source /usr/local/Ascend/ascend-toolkit/set_env.sh
   ```

2. **Docker permission denied**: Add user to docker group:
   ```bash
   sudo usermod -aG docker $USER
   ```

3. **Model loading fails**: Check model path in config and ensure files exist

## License

See `dgi_llm/LICENSE` for licensing information.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Support

For issues and questions, please open an issue on the project repository.
