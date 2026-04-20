# 🧬 PolyLotto: 유기적 다중 언어 로또 생태계

PolyLotto는 컴퓨터 공학의 역사를 관통하는 5가지 서로 다른 언어(C, C++, Lisp, FORTRAN, COBOL)가 각자의 강점을 발휘하며 하나의 유기체처럼 소통하는 전문 로또 분석 및 생성 소프트웨어 스위트입니다.

---

## 🏗️ 시스템 아키텍처 (Architecture)

본 프로젝트는 언어별 특성화와 유기적 통합을 핵심 가치로 설계되었습니다.

| 언어 | 역할 | 비유 | 상세 설명 |
| :--- | :--- | :--- | :--- |
| **Lisp** | **Orchestrator** | **두뇌 (Brain)** | 시스템 제어, 모듈 조율, 대화형 UI 처리 |
| **C** | **Core** | **심장 (Heart)** | 고속 난수 생성 엔진 및 기초 데이터 공급 |
| **C++** | **Engine** | **몸통 (Body)** | 데이터 필터링 로직 및 JSON/XML 포맷터 |
| **FORTRAN** | **Analyzer** | **이성 (Mind)** | 수치 해석 및 통계 분석 (평균, 빈도 등) |
| **COBOL** | **Reporter** | **목소리 (Voice)** | 비즈니스 스타일의 공식 보고서(XML/Text) 생성 |

---

## 🚀 시작하기 (Getting Started)

### 사전 요구 사항
시스템에 다음 컴파일러들이 설치되어 있어야 합니다:
- `sbcl` (Common Lisp)
- `gcc` / `g++` (C / C++)
- `gfortran` (FORTRAN)
- `cobc` (GnuCOBOL)
- `make` (Build Tool)

### 설치 및 빌드
```bash
# 저장소 복제 후 폴더 진입
git clone <repository_url>
cd lottonumberpicker

# 모든 모듈 컴파일
make all
```

---

## 🛠️ 사용 방법 (Usage)

루트 폴더의 `lotto` 명령어를 사용하여 시스템을 구동합니다.

### 기본 실행
```bash
# 5게임 생성 및 분석 리포트 출력
./lotto -c 5
```

### 다양한 데이터 포맷 출력
```bash
# JSON 형식으로 결과 출력
./lotto -c 10 --json

# XML 형식으로 결과 출력
./lotto -c 5 --xml
```

### 대화형 모드
```bash
# 사용자 입력을 통한 단계별 설정
./lotto -i
```

---

## 📂 프로젝트 구조 (Project Structure)
- `src/orchestrator/`: Lisp 메인 제어 로직
- `src/core/`: C 기반 고속 난수 생성기
- `src/engine/`: C++ 비즈니스 로직 및 포맷터
- `src/stats/`: FORTRAN 기반 통계 분석 모듈
- `src/reporter/`: COBOL 기반 결과 리포터
- `bin/`: 컴파일된 실행 파일 저장 경로
- `include/`: 공용 헤더 파일

---

## 📜 라이선스
이 프로젝트는 교육 및 재미를 목적으로 제작되었습니다. 자유롭게 사용하고 기여해 주세요! 🍀
