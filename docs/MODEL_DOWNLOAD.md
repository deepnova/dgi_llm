# 模型权重下载指南

本文档说明如何下载 Qwen3-0.6B 模型权重用于本地运行。

## 方法一：使用 ModelScope 下载（推荐）

ModelScope 是国内的模型托管平台，下载速度较快且稳定。

### 1. 安装 ModelScope

```bash
uv pip install modelscope
```

或使用 pip：
```bash
pip install modelscope
```

### 2. 下载模型

在项目根目录执行以下 Python 代码：

```bash
cd /Users/will/github/deepnova/dgi_llm
python -c "
from modelscope import snapshot_download
model_dir = snapshot_download('Qwen/Qwen3-0.6B', cache_dir='models')
print(f'模型下载到: {model_dir}')
"
```

或者创建一个 Python 脚本：

```python
from modelscope import snapshot_download

# 下载模型到 models 目录
model_dir = snapshot_download(
    'Qwen/Qwen3-0.6B',
    cache_dir='models'
)

print(f'模型下载到: {model_dir}')
```

### 3. 下载内容

下载完成后，模型文件将保存在 `models/Qwen/Qwen3-0.6B/` 目录下，包含以下文件：

- `model.safetensors` - 模型权重文件（约 1.4GB）
- `tokenizer.json` - 分词器配置
- `config.json` - 模型配置
- `generation_config.json` - 生成配置
- `vocab.json` - 词汇表
- `merges.txt` - BPE merge 规则
- 其他配置文件

## 方法二：使用 HuggingFace Hub 下载

如果网络环境允许，也可以使用 HuggingFace Hub 下载。

### 1. 安装 huggingface_hub

```bash
uv pip install huggingface_hub
```

### 2. 下载模型

```bash
huggingface-cli download Qwen/Qwen3-0.6B \
    model.safetensors \
    tokenizer.json \
    config.json \
    generation_config.json \
    vocab.json \
    merges.txt \
    --local-dir models/Qwen/Qwen3-0.6B
```

或使用 Python API：

```python
from huggingface_hub import snapshot_download

model_dir = snapshot_download(
    repo_id="Qwen/Qwen3-0.6B",
    local_dir="models/Qwen/Qwen3-0.6B"
)
```

## 方法三：手动下载

如果自动下载失败，可以手动下载：

1. 访问 ModelScope: https://modelscope.cn/models/Qwen/Qwen3-0.6B
2. 或访问 HuggingFace: https://huggingface.co/Qwen/Qwen3-0.6B
3. 下载所需文件到 `models/Qwen/Qwen3-0.6B/` 目录

## 验证下载

下载完成后，验证文件是否完整：

```bash
ls -lh models/Qwen/Qwen3-0.6B/
```

应该看到类似输出：

```
total 2982520
-rw-r--r--  11343 LICENSE
-rw-r--r--  13965 README.md
-rw-r--r--    726 config.json
-rw-r--r--     73 configuration.json
-rw-r--r--    239 generation_config.json
-rw-r--r--   1.6M merges.txt
-rw-r--r--   1.4G model.safetensors
-rw-r--r--    11M tokenizer.json
-rw-r--r--   9732 tokenizer_config.json
-rw-r--r--   2.6M vocab.json
```

## 配置运行脚本

模型下载完成后，运行脚本会自动使用正确的路径：

```bash
bash scripts/run-local-mac.sh
```

脚本中已配置：
```bash
export weights_file="$PWD/models/Qwen/Qwen3-0.6B/model.safetensors"
```

## 常见问题

### Q: 下载速度慢或失败怎么办？

A:
1. 使用 ModelScope（国内镜像）而不是 HuggingFace
2. 检查网络连接
3. 如果下载中断，重新运行命令会自动续传

### Q: 磁盘空间不足？

A: Qwen3-0.6B 模型大约需要 1.5GB 空间，确保有足够的磁盘空间。

### Q: 如何下载其他尺寸的模型？

A: 修改下载命令中的模型名称，例如：
- `Qwen/Qwen3-1.8B` - 1.8B 参数版本
- `Qwen/Qwen3-4B` - 4B 参数版本
- `Qwen/Qwen3-7B` - 7B 参数版本

注意：更大的模型需要更多内存和计算资源。

## 下一步

模型下载完成后，参考 [README.md](../README.md) 运行测试。