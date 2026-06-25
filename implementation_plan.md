# 구글 앱스 스크립트 평가 시스템 연동 계획서

사용자님께서 제공해주신 구글 앱스 스크립트 웹앱 URL을 분석한 결과, **자율주행 주행 궤적 이미지 분석 알고리즘(`analyzePixels`)** 및 **구글 시트 연동 기능(`saveData`)**이 이미 웹앱 내부에 완벽히 구현되어 작동 중인 것을 확인했습니다.

로컬 웹 프로그램([evaluation.html](file:///c:/Users/user/Desktop/autonomous-test-main%20%281%29/autonomous-test-main/evaluation.html))과 이 시스템을 매끄럽게 연결하기 위한 두 가지 방안을 제안해 드립니다.

---

## Proposed Changes

### [방법 1] 🚀 (강력 추천) 구글 웹앱 iframe 임베딩 & 현대적 디자인 래핑
구글 앱스 스크립트 전용 통신 규격인 `google.script.run`은 구글 서버 환경에서 실행되는 HTML 내에서만 안정적으로 작동합니다. 로컬 HTML 파일에서 직접 구글 API를 호출하려 하면 보안(CORS) 오류가 발생할 수 있습니다. 

따라서 [evaluation.html](file:///c:/Users/user/Desktop/autonomous-test-main%20%281%29/autonomous-test-main/evaluation.html) 내부에 웹앱 주소를 반응형 `<iframe>`으로 삽입하고, 전체적인 웹 UI 디자인을 고급스러운 카드 형태로 감싸서 로컬 앱처럼 일체감 있게 만드는 방법입니다.

* **장점**: 
  - CORS 보안 오류 원천 차단
  - 기존 구글 시트 연동 로직(`saveData`, `resetAllRecords`) 수정 없이 100% 즉시 동작
  - 순위표(리더보드) 확인 및 전체 초기화 버튼 기능도 그대로 동작
* **작업 대상**: 
  - [evaluation.html](file:///c:/Users/user/Desktop/autonomous-test-main%20%281%29/autonomous-test-main/evaluation.html)의 마크업을 세련된 카드 레이아웃으로 변경하고, 중앙에 웹앱을 띄우는 반응형 iframe 탑재.

---

### [방법 2] 🛠️ 채점 엔진 로직 로컬 이식 및 REST API 연동
구글 웹앱의 HTML/JS 소스코드(픽셀 분석 알고리즘)를 로컬 [evaluation.html](file:///c:/Users/user/Desktop/autonomous-test-main%20%281%29/autonomous-test-main/evaluation.html) 파일로 완전히 복사해 오고, 구글 시트 저장은 브라우저 `fetch()` API를 통해 API 호출 방식으로 처리하는 방법입니다.

* **단점 및 제약**:
  - 구글 앱스 스크립트 쪽에 `doPost(e)`가 정의되어 있어야 데이터 저장이 가능합니다.
  - 브라우저의 CORS(교차 출처 리소스 공유) 제한으로 인해 별도의 리디렉션 처리나 앱스 스크립트 헤더 수정이 필요할 수 있습니다.
  - 유지보수가 다소 복잡해집니다.

---

## Open Questions

> [!IMPORTANT]
> **방법 1(추천 - iframe 임베딩)**로 진행할 경우, 가장 빠르고 에러 없이 구글 시트 저장과 랭킹판 기능을 완벽하게 붙일 수 있습니다. 이 방식으로 진행해도 괜찮으실까요? 
> 동의해 주신다면 바로 코드를 적용하겠습니다. 다른 의견이 있으시다면 언제든 말씀해 주세요!

---

## Verification Plan

### 수동 검증
1. 로컬 [evaluation.html](file:///c:/Users/user/Desktop/autonomous-test-main%20%281%29/autonomous-test-main/evaluation.html)에 접속하여 렌더링 확인.
2. 차량 번호 선택 및 테스트 이미지(또는 아무 이미지)를 업로드하여 채점 및 구글 시트 기록 여부 테스트.
3. 리더보드 링크가 작동하는지 확인.
