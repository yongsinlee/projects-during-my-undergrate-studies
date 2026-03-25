# 🤖 Piper Robot Arm Teleoperation & Environment Setup
**NVIDIA Jetson 기반 USB-to-CAN 드라이버 빌드 및 Master-Slave 제어 시스템 구축**

이 프로젝트는 Piper 로봇팔의 제어를 위해 NVIDIA Jetson 환경에서 커널 모듈 이슈를 해결하고, 로봇 러닝 데이터 수집을 위한 텔레오퍼레이션(Teleoperation) 환경을 구축한 과정을 담고 있습니다.

---

## 1. 📋 프로젝트 목표
* **환경 구축**: Piper 로봇팔 제어를 위한 Python SDK 설치 및 CAN 통신 환경 설정.
* **이슈 해결**: Jetson 커널 내 부재한 `gs_usb` 드라이버를 직접 빌드하여 하드웨어 인식 문제 해결.
* **제어 구현**: Master-Slave 구조의 실시간 텔레오퍼레이션 원리 파악 및 다중 CAN 매핑.

## 2. 🛠️ 기술적 해결 (Troubleshooting)
### Jetson 커널의 `gs_usb` 모듈 부재 문제 해결
* **문제 상황**: USB-to-CAN 모듈 연결 시 `Device not found` 및 `modprobe gs_usb` 실행 시 모듈 부재 오류 발생.
* **원인 분석**: 사용 중인 Jetson 리눅스 커널 버전에서 `gs_usb` 드라이버가 포함되지 않은 채 빌드됨을 확인.
* **해결 조치**: 
    * 커널 전체 리빌드 대신, 오픈소스 스크립트를 활용하여 **`gs_usb` 커널 모듈을 별도로 컴파일 및 빌드**.
    * 빌드된 모듈 적재 후 `ip link`를 통해 `can0` 인터페이스 활성화 및 로봇팔 통신 성공.

## 3. 🕹️ 텔레오퍼레이션 (Teleoperation) 구조
로봇 학습용 데이터 세트 구축을 위한 **Master-Slave (Leader-Follower)** 시스템을 설계하였습니다.

* **Master (Leader)**: 사용자가 직접 조작하여 관절 각도(Joint State) 데이터를 생성하는 로봇.
* **Slave (Follower)**: Master로부터 실시간 데이터를 수신하여 동일한 궤적을 추종하는 로봇.
* **구현 방식**: 다중 CAN 포트(`can0`, `can1`)를 활성화하고, 각 로봇 인스턴스에 포트를 매핑하여 실시간 동기화 제어 수행.

## 4. 🚀 핵심 역량
* **Embedded Linux**: 커널 모듈 컴파일 및 시스템 인터페이스(CAN) 최적화 능력.
* **Hardware Interfacing**: USB-to-CAN 모듈 및 SDK를 활용한 실제 로봇 하드웨어 제어 경험.
* **Robot Learning Setup**: 데이터 수집을 위한 하드웨어 아키텍처 설계 및 구축 역량.

---
**세종대학교 AI로봇학과**
**이용신 (21011324)**
