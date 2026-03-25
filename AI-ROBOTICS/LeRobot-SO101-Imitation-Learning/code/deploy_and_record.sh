# !/bin/bash
# 학습된 Policy를 실제 로봇에 적용하여 자율 동작 수행 및 기록
lerobot-record \
    --robot.type=so101_follower \
    --robot.port=/dev/ttyACM1 \
    --robot.id=follower_arm \
    --teleop.type=so101_leader \
    --teleop.port=/dev/ttyACM0 \
    --teleop.id=leader_arm \
    --robot.cameras="{ camera1: {type: opencv, index_or_path: 0, width: 640, height: 480, fps: 30, fourcc: 'MJPG'}, camera2: {type: opencv, index_or_path: 1, width: 640, height: 480, fps: 30, fourcc: 'MJPG'}}" \
    --dataset.repo_id=${HF_USER}/eval_mydataset \
    --dataset.num_episodes=10 \
    --dataset.single_task="Move wet tissue from left to right" \
    --display_data=true \
    --policy.path=${HF_USER}/my_smolvla  # 본인이 학습시킨 모델 경로
