# 🚁 Quadcopter Dynamics Modeling & Waypoint Navigation Control
**MATLAB/Simulink 기반 F450 쿼드콥터 동역학 모델링 및 자율 주행 제어 시스템 설계**

이 프로젝트는 DJI F450 쿼드콥터를 모델로 하여, 모터 동역학부터 공기역학, 6자유도 강체 동역학을 시뮬링크로 구현하고, 특정 좌표(Waypoint)를 차례로 주행하는 제어 시스템을 설계한 프로젝트입니다.

---

## 1. 📋 프로젝트 개요 (Overview)
* **목적**: 드론 시스템의 물리적 모델링을 통한 비행 안정성 확보 및 실시간 경로 주행 시뮬레이션.
* **핵심 기능**:
    * **Motor & Aero Dynamics**: 전압 입력에 따른 모터 회전수 및 추력/모멘트 생성 모델링.
    * **6-DOF Rigid Body Dynamics**: 바디 좌표계와 이너셜 좌표계 간 변환을 포함한 병진/회전 운동 구현.
    * **Waypoint Switching**: 도달 여부를 판단하여 다음 목적지로 목표치를 자동 전환하는 로직.
    * **Yaw-First Guidance**: 목적지 방향으로 Yaw를 먼저 선회한 후 Pitch 제어로 주행하는 유도 알고리즘.

## 2. 🛠️ 시스템 구성 (System Architecture)
### 1) 동적 모델링 (Dynamic Modeling)
* **Motor Dynamics**: 키르히호프 전압 법칙 및 뉴턴 제2법칙을 적용하여 전기적 입력과 기계적 출력 관계 모델링.
* **Aero Dynamics**: 4개 프로펠러의 회전 속도 조합을 통해 Roll, Pitch, Yaw 모멘트 도출.
* **Landing Detection**: 지면 부재로 인한 무한 하강을 방지하기 위해 고도와 추력을 감지하여 착륙을 판단하는 로직 추가.

### 2) 제어 및 유도 (Control & Guidance)
* **Position Controller**: 목표 위치(X, Y, Alt)와 현재 위치의 오차를 바탕으로 Desired Roll/Pitch 생성.
* **Attitude Controller**: 기체의 자세를 안정화하고 유도 신호를 추종하는 내부 루프 제어.
* **Stable/Heading Logic**: 자세가 안정되었을 때만 주행을 시작하거나, 선회 중에는 이동 신호를 제한하여 비행 안정성 극대화.

## 3. 📉 시뮬레이션 결과 (Simulation Results)
* **Waypoint Mission**: 충무관 → 순리 → 잠실유람선터미널 → Home → Landing 경로를 오버슈트 없이 정확하게 수렴.
* **Yaw-First Behavior**: 목적지 도달 전 미리 선회(Yaw)를 완료하고 Pitch 제어를 통해 효율적으로 전진하는 거동 확인.
* **Power Analysis**: DJI F450 기준 호버링 시 소비 전력(211.2W) 및 최대 비행 시간(21분) 계산 데이터 확보.

## 4. 🚀 주요 역량 (Key Skills)
* **MATLAB/Simulink**: 복잡한 시스템의 서브시스템화 및 매트랩 함수(fcn 블록) 연동.
* **Control Theory**: PID 제어기 설계 및 게인 튜닝을 통한 응답 특성 최적화.
* **Flight Dynamics**: 좌표계 변환(Euler Angle, Rotation Matrix) 및 항공기 운동 방정식 이해.

---
**세종대학교 우주항공공학과**
**이용신 (21011324)**
