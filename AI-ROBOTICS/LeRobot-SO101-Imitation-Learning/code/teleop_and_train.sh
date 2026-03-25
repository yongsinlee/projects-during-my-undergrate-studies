# !/bin/bash
# 1. 실시간 텔레오퍼레이션 테스트 (데이터 시각화 포함)
lerobot-teleoperate \
    --robot.type=so101_follower \
    --robot.port=/dev/ttyACM1 \
    --robot.id=follower_arm \
    --robot.cameras="{ camera1: {type: opencv, index_or_path: 0, width: 640, height: 480, fps: 30, fourcc: 'MJPG'}, camera2: {type: opencv, index_or_path: 1, width: 640, height: 480, fps: 30, fourcc: 'MJPG'}}" \
    --teleop.type=so101_leader \
    --teleop.port=/dev/ttyACM0 \
    --teleop.id=leader_arm \
    --display_data=true

# 2. Hugging Face 및 WandB 로그인
hf auth login
export HF_USER="본인의_유저네임"
pip install wandb
wandb login

# 3. SmolVLA 정책 기반 모델 학습 시작
lerobot-train \
    --policy.path=lerobot/smolvla_base \
    --dataset.repo_id=${HF_USER}/mydataset \
    --batch_size=128 \
    --steps=20000 \
    --output_dir=outputs/train/my_smolvla \
    --policy.repo_id=${HF_USER}/my_smolvla \
    --job_name=my_smolvla_training \
    --policy.device=cuda \
    --wandb.enable=true
