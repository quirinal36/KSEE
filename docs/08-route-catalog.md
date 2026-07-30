# 8. 주요 URL 카탈로그

## 공개/회원

| Method | URL | 기능 |
|---|---|---|
| GET | `/` | 메인 |
| GET | `/search` | 통합 검색 |
| GET | `/about/{greet|history|term|member}` | 소개 콘텐츠 |
| GET/POST | `/member/signup` | 가입 화면/처리 |
| GET | `/member/get` | ID 중복 확인 |
| GET/POST | `/member/findId` | 아이디 찾기 |
| GET/POST | `/member/findPwd`, `/member/findPwd/submit` | 비밀번호 재설정 요청 |
| GET | `/member/validate/token`, `/member/newPwd` | 재설정 토큰/새 비밀번호 화면 |
| POST | `/member/newPwd/send[/{userId}]` | 비밀번호 변경 |
| GET | `/member/myinfo` | 내 정보 조회 |
| GET/POST | `/member/edit` | 회원정보 수정 화면/처리 |
| GET/POST | `/member/delete` | 탈퇴 화면/처리 |

## 학술대회/신청

| Method | URL | 기능 |
|---|---|---|
| GET | `/symposium/{where}` | 행사 목록 |
| GET | `/symposium/{where}/view/{id}[/{tab}]` | 행사 상세 |
| GET | `/symposium/apply/{id}` | 신청 화면 |
| POST | `/symposium/apply` | 신청 저장 |
| GET/POST | `/symposium/apply/search` | 신청 조회 |
| GET | `/symposium/apply/view/{id}`, `/symposium/apply/edit/{id}` | 신청 상세/수정 화면 |
| POST | `/symposium/apply/edit`, `/symposium/apply/delete` | 신청 변경/취소 |

## 게시판/파일

| Method | URL | 기능 |
|---|---|---|
| GET | `/group/{name}` | 게시판 목록 |
| GET | `/group/{name}/write`, `/view/{id}`, `/edit/{id}` | 작성/상세/수정 화면 |
| GET/POST | `/board/insertBoard`, `/board/editBoard`, `/board/delete/{id}` | 게시글 변경 |
| POST | `/reply/insert`, `/reply/update`, `/reply/delete` | 댓글 변경 |
| GET/POST | `/upload/file`, `/upload/image` | 업로드 |
| GET | `/upload/get/{id}`, `/picture/{id}`, `/thumbnail/{id}` | 파일/이미지 제공 |
| POST | `/docs/chat` | 기능 문서 RAG 챗봇 질문 처리 |

## 관리자

| Method | URL | 기능 |
|---|---|---|
| GET/POST | `/admin/members/*` | 회원 관리·메일·Excel |
| GET/POST | `/admin/{where}/*` | 행사·상세 콘텐츠 관리 |
| GET/POST | `/admin/apply/*` | 신청자 관리·다운로드 |
| GET/POST | `/admin/popup/*` | 팝업 관리 |
| GET/POST | `/admin/page/*` | 소개 페이지 콘텐츠 관리 |
