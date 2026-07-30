# KSEE 기능 문서

이 문서는 현재 소스코드 구현을 기준으로 작성한 한국효소공학연구회(KSEE) 웹사이트의 기능 설명서, 순서도, 기능명세서다. 구현되지 않았거나 화면에서만 확인되는 정책은 추정하지 않았다.

## 시스템 개요

- 기술 구성: Java 8, Spring MVC 5, Spring Security, JSP, MyBatis, MySQL, Maven WAR
- 사용자 역할: 비회원, 로그인 회원(`ROLE_USER`), 관리자(`ROLE_ADMIN`)
- 언어: 한국어/영어 로케일을 사용하며 게시물·팝업·행사 상세 콘텐츠는 언어별로 조회한다.
- 핵심 데이터: 회원, 게시글, 댓글, 파일, 이미지, 팝업, 학술대회, 학술대회 상세, 참가신청, 소개 페이지 콘텐츠

## 문서 목록

| 문서 | 범위 |
|---|---|
| [01-architecture.md](01-architecture.md) | 시스템 구성, 역할, 공통 처리 |
| [02-public-content.md](02-public-content.md) | 메인·소개·검색·정적 안내 |
| [03-member.md](03-member.md) | 가입·인증·계정 복구·회원정보 |
| [04-symposium-application.md](04-symposium-application.md) | 학술대회와 참가신청 |
| [05-board-comment.md](05-board-comment.md) | 게시판과 댓글 |
| [06-file-image.md](06-file-image.md) | 파일·이미지 업로드와 제공 |
| [07-admin.md](07-admin.md) | 관리자 운영 기능 |
| [08-route-catalog.md](08-route-catalog.md) | 주요 URL/메서드 목록 |
| [09-chatbot.md](09-chatbot.md) | 기능 문서 RAG 챗봇과 API 키 설정 |

## 공통 표기

- `GET`: 페이지 표시 또는 데이터 제공
- `POST`: 생성·수정·삭제 처리(대부분 JSON `result` 반환)
- 권한은 `Spring Security` 설정과 컨트롤러의 로그인/관리자 검사를 함께 기준으로 한다.
- `/admin/**`는 보안 설정상 관리자 역할이 필요하다.
