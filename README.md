# 🧬 PolyLotto: 유기적 다중 언어 로또 생태계

PolyLotto는 컴퓨터 공학의 역사를 관통하는 5가지 서로 다른 언어(C, C++, Lisp, FORTRAN, COBOL)가 각자의 강점을 발휘하며 하나의 유기체처럼 소통하는 전문 로또 분석 및 생성 소프트웨어 스위트입니다.

이제 터미널을 넘어 웹 브라우저에서도 **제로 UI(CLI 전용)** 환경으로 PolyLotto의 강력한 기능을 경험할 수 있습니다.

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

## 🌐 PolyLotto Web (Zero-UI CLI Edition)

웹 버전은 일반적인 웹사이트의 틀을 완전히 벗어나, 브라우저 전체를 **가상 터미널**로 사용하여 실제 CLI 환경을 완벽하게 재현합니다.

- **기본 URL**: Vercel 배포 시 생성된 URL
- **특징**: 아무런 UI 요소 없이 오직 터미널 입력을 통해서만 동작하는 '미니멀리즘'의 극치
- **기술**: Next.js + xterm.js + WebAssembly (WASM) 기반 시뮬레이션

---

## 🚀 시작하기 (Getting Started)

### 사전 요구 사항
시스템에 다음 컴파일러들이 설치되어 있어야 합니다:
- `sbcl` (Common Lisp)
- `gcc` / `g++` (C / C++)
- `gfortran` (FORTRAN)
- `cobc` (GnuCOBOL)
- `emcc` (Emscripten - 웹 버전 빌드용)
- `make` 및 `node/npm`

### 로컬 빌드 및 실행
```bash
# 모든 모듈 컴파일
make all

# 로컬 실행
./lotto -c 5
```

### 웹 버전 로컬 개발
```bash
cd web
npm install
npm run dev
```

---

## 🛠️ 주요 명령어 (Commands)

로컬 터미널과 웹 터미널 모두 아래 명령어를 동일하게 사용합니다.

```bash
# 5게임 생성 및 분석 리포트 출력
lotto -c 5

# JSON 또는 XML 형식으로 결과 출력
lotto -c 10 --json
lotto -c 5 --xml

# 대화형 설정 모드
lotto -i
```

---

## 📂 프로젝트 구조 (Project Structure)
- `src/`: 언어별 소스 코드 (Core, Engine, Orchestrator, Reporter, Stats)
- `web/`: Next.js 기반 웹 터미널 프로젝트
- `bin/`: 컴파일된 실행 파일 저장 경로
- `include/`: 공용 헤더 파일
- `vercel.json`: Vercel 배포 설정 파일

---

## 📜 라이선스
이 프로젝트는 **MIT License**에 따라 자유롭게 사용할 수 있습니다. 🍀
