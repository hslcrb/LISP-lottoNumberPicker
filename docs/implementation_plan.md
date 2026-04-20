# PolyLotto Web: 하드코어 WASM 및 CLI 포팅 계획서

PolyLotto의 모든 모듈을 WASM으로 포팅하고, 웹에서도 터미널 환경을 그대로 느낄 수 있도록 UI가 전혀 없는 순수 CLI 지향형 Next.js 프로젝트를 구축합니다.

## User Review Required

> [!IMPORTANT]
> **모든 언어 WASM 포팅**: 
> - **C/C++**: `emcc`를 통해 직접 변환.
> - **COBOL**: `cobc -C`로 C 코드를 생성한 후 `emcc`로 컴파일하여 WASM화.
> - **FORTRAN**: 의존성 환경에 따라 `f2c` 또는 LLVM 브릿지를 통해 WASM 변환 시도.
> - **Lisp**: 시스템 두뇌인 Lisp 오케스트레이터의 로직은 WASM 모듈들을 제어하는 **TypeScript 기반 오케스트레이터**로 변환하여 브라우저에서 실행합니다. (SBCL 자체의 WASM 포팅은 성능 및 크기 문제로 브라우저에 부적합할 수 있음)
> **제로 UI (CLI 경험)**: `xterm.js`를 사용하여 브라우저 전체 화면을 검은 터미널로 덮습니다. 사용자는 실제 터미널을 쓰는 것과 동일한 경험을 하게 됩니다.

## Proposed Changes

### [Web] Next.js 터미널 환경 구축 (`/web`)
1.  **프로젝트 초기화**: `npx create-next-app@latest ./web` (App Router, Tailwind, TypeScript).
2.  **터미널 라이브러리**: `xterm.js` 및 관련 애드온 설치.
3.  **UI 제거**: 기본 `globals.css` 및 페이지 레이아웃을 수정하여 오직 터미널 창만 보이도록 설정.

### [WASM] 언어별 포팅 전략
1.  **`src/core` (C)**: `emcc src/core/main.c -o web/public/wasm/lotto-core.js -s WASM=1`.
2.  **`src/engine` (C++)**: `emcc src/engine/main.cpp -o web/public/wasm/lotto-engine.js -s WASM=1`.
3.  **`src/reporter` (COBOL)**: 
    - `cobc -C src/reporter/main.cbl` 로 C 파일 생성.
    - 생성된 C 파일을 `emcc`로 처리하여 WASM 및 JS 개발.
4.  **`src/stats` (FORTRAN)**: 환경 내 `gfortran`과 LLVM 브릿지를 사용하여 최대한 WASM으로 변환.

### [Deployment] Vercel 및 루트 설정
1.  **`vercel.json`**: `/web` 디렉토리를 빌드 대상으로 지정.
2.  **`.vercelignore`**: 불필요한 로컬 바이너리 및 소스 제외.

## Open Questions

- **명령어 입력 방식**: 터미널 UI에서 실제 쉘처럼 명령어를 입력받아 실행하게 할까요, 아니면 페이지 로드 시 바로 실행 결과를 보여줄까요? (CLI 환경 그대로라면 입력을 받는 방식이 더 적합해 보입니다.)
- **FORTRAN 제약**: 환경에 따라 FORTRAN의 WASM 변환이 매우 까다로울 수 있습니다. 변환이 어려울 경우 해당 모듈만 제외하거나 대체 로직을 적용해도 될까요?

## Verification Plan

### Automated Tests
- 각 모듈의 WASM 파일 생성 여부 확인.
- Next.js 빌드 성공 여부 확인.

### Manual Verification
- 웹 접속 시 검은 터미널 화면이 뜨는지 확인.
- 터미널에서 로또 명령어가 CLI와 동일하게 출력되는지 확인.
