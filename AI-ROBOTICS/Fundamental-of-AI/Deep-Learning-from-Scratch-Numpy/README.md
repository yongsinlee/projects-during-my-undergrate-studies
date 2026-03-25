# 🧠 Deep Learning from Scratch: Numpy-based Backpropagation
**PyTorch 없이 Numpy만으로 구현하는 신경망 역전파(Backpropagation) 엔진**

이 프로젝트는 현대 딥러닝 프레임워크의 자동 미분(Auto-Grad) 기능에 의존하지 않고, 직접 각 연산 노드의 순전파(Forward) 및 역전파(Backward) 로직을 수치적으로 구현하여 MNIST 필기체 숫자를 분류하는 2층 신경망(Two-Layer Net)을 구축한 프로젝트입니다.

---

## 1. 📋 프로젝트 개요 (Overview)
* **목적**: 딥러닝 학습의 핵심인 역전파 알고리즘과 연쇄 법칙(Chain Rule)의 수학적 원리를 코드로 직접 구현하여 이해도 심화.
* **핵심 내용**: 
    * 각 레이어(Affine, ReLU, Sigmoid, Softmax)의 로컬 그레디언트 도출 및 구현.
    * 계산 그래프(Computational Graph) 개념을 도입하여 복잡한 합성함수의 미분 수행.
    * MNIST 데이터셋을 활용한 실질적인 모델 학습 및 검증.

## 2. 🛠️ 구현된 연산 노드 (Implemented Layers)
모든 계층은 `forward()`와 `backward()` 메서드를 가진 독립적인 클래스로 설계되었습니다.

* **Add / Mul Layer**: 기본적인 산술 연산의 역전파 흐름 제어.
* **ReLU / Sigmoid**: 비선형 활성화 함수 및 마스킹(Masking)을 통한 그레디언트 차단 구현.
* **Affine Layer**: 행렬 곱 연산($X \cdot W + b$)과 벡터/행렬 미분 적용.
* **Softmax-with-Loss**: 출력층의 확률 변환 및 Cross Entropy Error를 결합한 효율적인 미분($p_i - y_i$) 구현.



## 3. 📉 학습 프로세스 및 결과 (Training & Results)
* **Architecture**: Input(784) -> Hidden(50) -> Output(10)
* **Optimization**: SGD (Stochastic Gradient Descent)
* **Dataset**: MNIST (60,000 Training / 10,000 Test)
* **Performance**: 10,000회 반복 학습(iters_num) 결과, 정확도(Accuracy)가 점진적으로 상승하며 학습이 정상적으로 수행됨을 검증.

## 4. 🚀 주요 학습 포인트 (Key Learning Points)
* **연쇄 법칙(Chain Rule)**: Upstream Gradient와 Local Gradient의 곱을 통해 Downstream Gradient를 전달하는 과정 체득.
* **데이터 배치(Mini-batch)**: 대용량 데이터셋에서 효율적인 학습을 위한 무작위 샘플링 및 행렬 연산 최적화.
* **객체 지향 설계**: `OrderedDict`를 활용하여 레이어 순서를 관리하고, 유연하게 신경망 구조를 확장할 수 있는 아키텍처 설계.

---
**세종대학교 AI로봇학과**
**이용신 (21011324)**
