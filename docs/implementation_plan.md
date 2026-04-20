# CLI 로또 번호 추첨기 기능 확장 계획

기존의 단순한 로또 번호 생성기에서 사용자가 요청한 모든 편의 기능과 시각적 효과를 포함한 종합 CLI 도구로 업그레이드합니다.

## User Review Required

> [!IMPORTANT]
> **ANSI 색상 지원**: 터미널 환경에 따라 색상이 깨져 보일 수 있습니다. 표준 ANSI 지원 터미널(Linux Bash/Zsh 등)을 기준으로 구현합니다.
> **인수 파싱 방식**: 외부 라이브러리 없이 순수 Lisp으로만 구현하기 위해 명령줄 인수를 `--옵션 값` 형태로 직접 파싱하는 로직을 추가합니다.

## Proposed Changes

### [Component Name] 로또 핵심 로직 및 인터페이스 확장

#### [MODIFY] [lotto.lisp](file:///home/rheehoselenovo2/개발프로젝트/lottonumberpicker/lotto.lisp)

1.  **변수 및 상수 정의**:
    - ANSI 색상 코드 상수 정의 (번호 대역별 색상).
    - 기본 설정값 (뽑을 개수, 파일 저장 여부 등).

2.  **핵심 생성 함수 (`generate-lotto-advanced`)**:
    - `fixed-nums`: 반드시 포함할 숫자 목록 처리.
    - `exclude-nums`: 추첨에서 제외할 숫자 목록 처리.
    - 유효성 검사 (고정수 + 추첨수 <= 6 인지 등).

3.  **시각적 출력 함수 (`print-lotto-fancy`)**:
    - 번호 대역에 따른 ANSI 색상 적용 로직.
    - `1-10(노랑), 11-20(파랑), 21-30(빨강), 31-40(회색), 41-45(초록)`.

4.  **파일 저장 기능**:
    - `--save <파일명>` 인수가 있을 경우 결과를 텍스트 파일로 출력하는 스트림 처리.

5.  **대화형 모드 (`interactive-mode`)**:
    - 실행 인수가 없을 경우 `read-line` 등을 통해 게임 수, 고정수 등을 사용자에게 직접 물어보는 로직.

6.  **당첨 시뮬레이션 (`simulation-mode`)**:
    - `--simulate "1 2 3 4 5 6"` 와 같이 당첨 번호를 입력받아 현재 뽑은 번호들의 등수를 매겨주는 기능.

7.  **명령줄 인수 파서 개편**:
    - `-c`, `--count`: 게임 수.
    - `-f`, `--fixed`: 고정수 (쉼표 구분).
    - `-e`, `--exclude`: 제외수 (쉼표 구분).
    - `-s`, `--save`: 파일 저장 경로.
    - `-i`, `--interactive`: 강제 대화형 모드.
    - `--simulate`: 당첨 확인 모드.

## Verification Plan

### Automated Tests
- `./lotto.lisp --count 5` 실행 시 5게임 출력 확인.
- `./lotto.lisp --fixed "1,2" --exclude "3,4"` 실행 시 조건 충족 확인.
- `./lotto.lisp --save lotto.txt` 실행 후 파일 생성 및 내용 확인.

### Manual Verification
- 터미널에서 번호 대역별로 색깔이 올바르게 나오는지 눈으로 확인.
- 인수를 하나도 주지 않았을 때 대화형 메시지가 뜨는지 확인.
