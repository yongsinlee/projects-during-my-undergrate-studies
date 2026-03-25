# !/bin/bash
# 1. 가상환경 생성 및 활성화
conda create -y -n lerobot python=3.10
conda activate lerobot

# 2. 필수 라이브러리 및 LeRobot SDK 설치
conda install ffmpeg -c conda-forge -y
git clone --branch v0.4.3 --single-branch https://github.com/huggingface/lerobot.git
cd lerobot

pip install -e .
pip install lerobot
pip install -e ".[feetech]"  # Feetech 모터 제어 라이브러리
pip install -e ".[smolvla]"  # SmolVLA 관련 라이브러리

# 3. 시스템 의존성 패키지 설치
sudo apt-get update
sudo apt-get install -y cmake build-essential python3-dev pkg-config \
    libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev \
    libswscale-dev libswresample-dev libavfilter-dev
