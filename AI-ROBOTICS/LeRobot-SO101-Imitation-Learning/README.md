# 🤖 SO-101 Robot Arm Control with LeRobot
**Hugging Face LeRobot 플랫폼을 활용한 SO-101 로봇팔 모방 학습(Imitation Learning) 실습**

본 프로젝트는 오픈소스 로봇 학습 프레임워크인 **LeRobot**과 **SO-101** 로봇팔을 사용하여, 인간의 조작 데이터를 학습하고 로봇이 스스로 작업(Task)을 수행하도록 만드는 AI 로봇 제어 프로젝트입니다.

---

## 1. 📋 프로젝트 개요
* **목적**: 데이터 기반 로봇 제어 아키텍처 이해 및 실습.
* **플랫폼**: Hugging Face **LeRobot** (로봇 학습을 위한 엔드투엔드 프레임워크).
* **하드웨어**: SO-101 로봇팔 (Low-cost, High-performance 오픈소스 로봇암).
* **핵심 기술**: 
    * **Teleoperation**: 리더-팔로워 구조를 통한 고품질 시연(Demonstration) 데이터 수집.
    * **Imitation Learning**: 수집된 데이터를 바탕으로 로봇의 행동 정책(Policy) 학습.
    * **Evaluation**: 학습된 모델을 실제 로봇에 적재하여 작업 성공률 검증.

## 2. 🛠️ 주요 실습 과정 (Workflow)
### 1) 데이터 수집 (Data Collection)
* 사람이 직접 로봇을 조작하여 특정 태스크(예: 물체 옮기기)를 수행하는 시연 데이터를 녹화.
* 영상 데이터와 관절 각도(Joint States) 데이터를 동기화하여 데이터셋 구축.

### 2) 모델 학습 (Training)
* LeRobot에서 제공하는 최신 정책 모델(예: Diffusion Policy, ACT 등)을 활용.
* 수집된 시연 데이터를 입력으로 하여 주변 환경(Vision)에 따른 최적의 행동을 예측하도록 학습.

### 3) 추론 및 검증 (Inference)
* 학습된 가중치(Weights)를 로봇 제어기에 배포.
* 실시간 카메라 입력을 바탕으로 로봇이 학습된 동작을 자율적으로 재현하는지 확인.



## 3. 🚀 주요 학습 포인트
* **End-to-End Robotics**: 센서 입력부터 모터 출력까지 이어지는 딥러닝 기반 로봇 제어 파이프라인 숙달.
* **Dataset Management**: 로봇 학습을 위한 대용량 멀티모달(Vision + Telemetry) 데이터 관리 능력.
* **Hugging Face Ecosystem**: LeRobot 라이브러리를 활용한 모델 공유 및 협업 워크플로우 경험.

## 4. 🔗 참고 자료
* **LeRobot GitHub**: https://github.com/huggingface/lerobot
* **SO-101 Project**: https://github.com/AlexanderKoch-Koch/so-101

---
**세종대학교 AI로봇학과**
**이용신 (21011324)**
