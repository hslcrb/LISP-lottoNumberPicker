# PolyLotto: 유기적 다중 언어 로또 생태계 계획서

본 프로젝트는 서로 다른 5가지 언어가 각자의 강점을 발휘하며 하나의 유기체처럼 동작하는 전문 로또 분석 및 생성 시스템을 구축합니다.

## User Review Required

> [!IMPORTANT]
> **유기적 통합 방식**: Lisp이 전체 시스템의 '두뇌' 역할을 하며, 다른 언어로 작성된 모듈들을 적시에 호출하고 데이터를 중계합니다.
> **상호운용 데이터**: 모든 모듈은 표준화된 JSON 및 XML 형식을 통해 데이터를 주고받아 언어 간 장벽을 허뭅니다.

## Proposed Changes

### [Architecture] 언어별 특성화 및 역할 분담

1.  **Lisp (Orchestrator - 'Brain')**: 
    - 사용자 인터페이스(CLI/대화형) 관리.
    - 타 언어 모듈 호출 및 실행 흐름 제어.
    - JSON/XML 파싱 및 데이터 라우팅.

2.  **C (Random Core - 'Heart')**:
    - 하드웨어 수준의 고속 난수 생성 엔진.
    - 가장 기초적인 데이터 스트림 제공.

3.  **C++ (Logic Engine - 'Body')**:
    - 고정수/제외수 필터링 및 복잡한 비즈니스 로직.
    - JSON 및 XML 구조 생성 라이브러리 역할.

4.  **FORTRAN (Analyzer - 'Mind')**:
    - 생성된 번호들에 대한 고도의 통계 분석 (평균, 표준편차, 대역별 빈도 등).
    - 수치 해석적 관점에서의 데이터 검증.

5.  **COBOL (Reporter - 'Voice')**:
    - 분석된 데이터를 바탕으로 정교한 비즈니스 스타일의 XML 리포트 및 출력 결과 생성.
    - 전통적인 보고서 양식의 텍스트 출력.

### [Data Format] 상호운용성 표준
- **JSON**: 모듈 간 데이터 전송의 기본 규격.
- **XML**: 보관 및 보고용 표준 규격.
- 모든 모듈은 `--format [json|xml|text]` 옵션을 지원합니다.

### [Structure] 디렉토리 재구조화
```
src/
├── orchestrator/ (Lisp)
├── core/         (C)
├── engine/       (C++)
├── stats/        (FORTRAN)
└── reporter/     (COBOL)
bin/ (컴파일된 바이너리)
include/ (C/C++ 헤더)
```

## Implementation Roadmap

1.  **1단계**: 디렉토리 구조 생성 및 `Makefile` 초기화.
2.  **2단계**: C 코어 및 C++ 엔진 구현 (기초 생성 및 포맷터).
3.  **3단계**: FORTRAN 통계 모듈 및 COBOL 리포터 구현.
4.  **4단계**: Lisp 오케스트레이터를 통한 유기적 연결 완료.

## Verification Plan
- `make all` 실행 시 오류 없이 전 언어 바이너리 생성.
- 통합 실행 시 `C(생성) -> C++(필터) -> FORTRAN(분석) -> COBOL(출력)` 흐름이 JSON/XML을 매개로 정상 작동하는지 확인.
