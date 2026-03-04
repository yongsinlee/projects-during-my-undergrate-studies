# 🚜 Line-Follower-Auto-Rover
Raspberry Pi 4 & ROS Noetic 기반 비전 인식 자율 주행 로버

## 📝 1. 프로젝트 개요
해당 과목: 자율비행체시스템설계

목적: 단일 카메라를 이용한 실시간 라인 인식 및 MAVLink 프로토콜 기반 주행 제어 시스템 구현

핵심 기술: OpenCV 영상 처리, ROS Noetic 노드 통신, MAVLink 통신 프로토콜 통합

## 🛠 2. 주요 기술 스택
- Main Computing: Raspberry Pi 4 (Ubuntu 20.04, ROS Noetic)

- Sensor/Actuator: Pi Camera, L298N 모터 드라이버, RFD 915MHz 텔레메트리

- Protocol: MAVLink (Micro Air Vehicle Link)

- Software: OpenCV, Python, Mission Planner

## ⚙️ 3. 주요 구현 특징
3-1. OpenCV 기반 비전 경로 인식
- 이미지 전처리: HSV 색 공간 변환 및 이진화(Thresholding)를 통해 주행 라인 검출, 가우시안 블러로 노이즈 억제

- 오차 산출: 설정된 관심 영역(ROI)에서 라인 중심점을 계산, 로버 현재 위치와의 편차(Error)를 제어 신호로 변환

3-2. MAVLink 프로토콜 및 통신 아키텍처
- 메시지 전송: ROS에서 계산된 명령을 MAVLink 패킷으로 캡슐화하여 픽스호크에 전송

- GCS 연동: 미션 플래너(Mission Planner)를 통해 기체 상태(Heartbeat) 실시간 모니터링

## 📊 4. 실험 결과 및 한계점 분석
4-1. 주요 성과
- 카메라 기반 실시간 라인 인식 및 좌표 추출 알고리즘 구현 완료

- ROS 노드 통신 데이터가 MAVLink를 거쳐 모터 신호로 정상 출력됨을 확인

4-2. 한계점 및 실패 원인 분석
- 현상: 라인 인식 및 신호 출력은 정상이나, 기체 사행(Oscillation) 및 경로 이탈로 인해 안정적인 자율 주행 실패

- 원인 분석: 1. 제어 파라미터 미흡: 고정 게인값 사용으로 인한 관성 및 모터 응답 지연 극복 실패
            2. 가변 속도 제어 부재: 곡선 구간 및 큰 오차 발생 시 속도 감속 로직 부재로 인한 조향 한계 초과

## 💡 5. 향후 개선 과제
PID 최적화: 시스템 응답 특성에 맞는 정밀한 PID 게인 튜닝 및 안정성 확보

가변 속도 제어: 곡률 및 오차 크기에 따라 속도를 가변적으로 조정하는 알고리즘 추가

환경 확장: Raspberry Pi 5 및 ROS2 Humble 환경에서 LiDAR 연동을 통한 항법 고도화 예정
