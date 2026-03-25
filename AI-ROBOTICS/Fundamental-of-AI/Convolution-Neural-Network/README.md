# 🏛️ Korean Landmark Image Classification using CNN
**PyTorch 기반의 CNN 및 VGG-Net을 활용한 한국 주요 랜드마크 이미지 분류 프로젝트**

이 프로젝트는 Kaggle 환경에서 제공된 한국 랜드마크 데이터셋을 활용하여, 이미지 데이터를 인식하고 해당 랜드마크(인천대교, 광화문, 불국사 등)를 분류하는 모델을 학습시킨 프로젝트입니다.

---

## 1. 📋 프로젝트 개요 (Overview)
* **목적**: 딥러닝 컴퓨터 비전 기술을 활용하여 다중 클래스(Multi-class) 이미지 분류 모델 구축.
* **데이터셋**: 한국의 다양한 건조물 및 랜드마크 이미지 (인천대교, SKView, B-Tower, G-Tower 등).
* **핵심 기술**: 
    * **PyTorch**: 딥러닝 모델 설계 및 학습 파이프라인 구축.
    * **CNN / VGG-Net**: 고도화된 특징 추출을 위한 신경망 구조 채택.
    * **Transfer Learning**: 사전 학습된 모델을 활용한 학습 효율 극대화.

## 2. 🛠️ 주요 구현 내용 (Implementation Details)
### 1) 데이터 전처리 및 로더 (Data Pipeline)
* **Custom Dataset**: `Dataset` 클래스를 정의하여 이미지 경로와 라벨(CSV)을 매핑하고 실시간으로 데이터를 로드함.
* **Augmentation**: 모델의 일반화 성능을 높이기 위해 이미지 크기 조정 및 정규화(Normalization) 적용.

### 2) 모델 아키텍처 (Model Architecture)
* **CNN Baseline**: 합성곱 계층을 쌓아 이미지의 공간적 특징을 추출하는 베이스라인 모델 구축.
* **VGG-Net**: 깊은 층을 가진 VGG 네트워크 구조를 적용하여 정교한 피처(Feature) 추출 및 성능 개선.

### 3) 학습 및 평가 (Training & Evaluation)
* **Loss Function**: 다중 분류에 적합한 `CrossEntropyLoss` 사용.
* **Optimizer**: `Adam` 최적화 알고리즘을 사용하여 가중치 업데이트.
* **GPU Acceleration**: Kaggle의 GPU 환경을 활용하여 대규모 이미지 데이터 학습 가속화.

## 3. 📈 학습 결과 (Results)
* **Label Mapping**: 숫자 형태의 예측값을 실제 클래스 이름(ID -> Name)으로 변환하여 최종 결과 생성.
* **Output**: 테스트 데이터에 대한 예측을 수행하고 결과를 `submit.csv` 형태로 저장.

## 4. 🚀 주요 역량 (Key Skills)
* **Computer Vision**: CNN의 동작 원리와 이미지 데이터 처리 프로세스 숙달.
* **Framework Proficiency**: PyTorch를 활용한 커스텀 데이터셋 핸들링 및 모델 아키텍처 설계.
* **Cloud Computing**: Kaggle GPU 환경을 통한 효율적인 딥러닝 모델 트레이닝 경험.

---
**세종대학교 AI로봇학과**
**이용신 (21011324)**
