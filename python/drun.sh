#!/usr/bin/env bash

set -x

image=swr.cn-south-1.myhuaweicloud.com/ascendhub/cann:8.2.rc1-910b-ubuntu22.04-py3.11
image=mindie:2.1.RC1-800I-A2-py311-openeuler24.03-lts
image=dgi-dev:v2-4
#image={{ image }}
container_base=dgi-dev
container=${container_base}-deploy-0

env_file="deploy-0.env"
port=9198
shm_size=64GB

docker stop $container && docker rm $container

docker run --name ${container} -t \
  --entrypoint bash \
  --env-file ${env_file} \
  -p ${port}:${port} \
  --network=host \
  --privileged=true \
  --device=/dev/davinci_manager \
  --device=/dev/hisi_hdc \
  --device=/dev/devmm_svm \
  -v /usr/local/dcmi:/usr/local/dcmi \
  -v /usr/local/bin/npu-smi:/usr/local/bin/npu-smi \
  -v /usr/local/Ascend/driver/lib64/common:/usr/local/Ascend/driver/lib64/common \
  -v /usr/local/Ascend/driver/lib64/driver:/usr/local/Ascend/driver/lib64/driver \
  -v /usr/local/Ascend/driver/version.info:/usr/local/Ascend/driver/version.info \
  -v /etc/ascend_install.info:/etc/ascend_install.info \
  -v /etc/vnpu.cfg:/etc/vnpu.cfg \
  -v /usr/local/sbin:/usr/local/sbin \
  -v /usr/share/zoneinfo/Asia/Shanghai:/etc/localtime \
  -v /data1/:/data1/ \
  -v /data2/:/data2/ \
  -w /root \
  -u root \
  --ulimit msgqueue=-1 \
  --shm-size=${shm_size} \
  ${image}
