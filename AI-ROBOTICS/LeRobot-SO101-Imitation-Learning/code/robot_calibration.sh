# !/bin/bash
# 1. 포트 찾기 및 권한 부여
lerobot-find-port
sudo chmod 666 /dev/ttyACM0
sudo chmod 666 /dev/ttyACM1

# 2. 카메라 인덱스 확인 (OpenCV)
lerobot-find-cameras opencv

# 3. Follower 로봇 (실제 구동축) 캘리브레이션
lerobot-calibrate \
    --robot.type=so101_follower \
    --robot.port=/dev/ttyACM1 \
    --robot.id=follower_arm

# 4. Leader 로봇 (조작용) 캘리브레이션
lerobot-calibrate \
    --teleop.type=so101_leader \
    --teleop.port=/dev/ttyACM0 \
    --teleop.id=leader_arm
