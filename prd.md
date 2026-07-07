# KSEE 웹 플랫폼 재구축 PRD (Next.js + Supabase + Vercel)

> 한국효소공학연구회(KSEE, Korean Society for Enzyme Engineering) 공식 웹사이트를
> 기존 Java(Spring MVC + MyBatis + MySQL, Tomcat/WAR) 스택에서
> **Next.js + Supabase + Vercel** 스택으로 전면 재구축하기 위한 제품 요구사항 문서.
>
> 이 문서는 새 저장소/새 환경에서 프로젝트를 처음부터 시작할 수 있도록 작성되었다.
> 문서 버전: v1.0 · 최종수정: 2026-07

---

## 0. 요약 (TL;DR)

- **무엇을**: 학회 공개 포털(소개/게시판/심포지엄/참가접수/회원) + 관리자 백오피스 + AI 챗봇을 재구축.
- **왜**: Vercel 배포 및 현대적 개발/운영(서버리스, GitOps, AI 에이전트 연동)을 위해 JS 스택으로 전환.
- **핵심 스택**: Next.js(App Router, TypeScript) · Supabase(Postgres + Auth + Storage + RLS) · Vercel.
- **차별 기능**: (1) 방문자 안내 챗봇, (2) 관리자가 채팅으로 게시판/페이지를 편집, (3) (선택) Hermes 에이전트를 통한 코드/배포 자동화.
- **원칙**: 서버측 권한검증, 파라미터 바인딩/RLS로 인젝션 차단, 비밀은 환경변수, 최소권한.

---

## 1. 배경과 목표

### 1.1 배경
기존 사이트는 Java 8 + Spring 5 + MyBatis + MySQL 기반 WAR 앱으로 Tomcat에 배포된다.
유지보수(정적 페이지 수정 시 properties 편집 후 톰캣 재시작), 배포, 최신 기능 도입이 번거롭고,
보안 취약점(SQL Injection, 커밋된 비밀, CSRF off 등)이 다수 존재했다.

### 1.2 목표 (Goals)
1. 기존 기능 **동등 이상**으로 재현(feature parity)하되 구조를 현대화.
2. **Vercel 무중단 배포** + 미리보기(Preview) 환경.
3. **Supabase**로 DB/인증/스토리지 통합, **RLS**로 데이터 보안 강화.
4. **AI 챗봇**을 1급 기능으로 내장(방문자 안내 + 관리자 운영 도구).
5. **다국어(한/영)**, 반응형, 접근성 유지.
6. 비밀·자격증명은 전부 환경변수/시크릿으로 관리.

### 1.3 비목표 (Non-Goals)
- 기존 MySQL 데이터를 무손실 그대로 이관하는 것이 최우선은 아님(스키마 재설계 허용).
- 기존 JSP/디자인의 픽셀 단위 복제(리디자인 여지 허용).
- Hermes 코드-에이전트 연동은 **선택적 후속 단계**(9장). 코어 재구축의 필수는 아님.

---

## 2. 사용자와 역할 (Roles)

| 역할 | 기존값 | 설명 | 권한 |
|------|--------|------|------|
| 관리자 admin | ROLE_ADMIN(1) | 학회 운영진 | 전체 관리, 게시판/회원/심포지엄/페이지 편집, 챗봇 운영도구 |
| 학생 student | ROLE_STUDENT(2) | 학생 회원 | 로그인, 글/댓글 작성, 참가접수, 내정보 |
| 일반 general | ROLE_GENERAL(3) | 일반 회원 | 위와 동일 |
| 기업 company | ROLE_COMPANY(4) | 기업 회원 | 위와 동일 |
| 방문자 anon | - | 비로그인 | 공개 페이지 열람, 공개 게시판 읽기, 안내 챗봇, 참가접수(설정에 따라) |

> Supabase Auth의 사용자 메타데이터(`app_metadata.role`) 또는 별도 `profiles.role` 컬럼으로 역할 관리.
> 권한 판단은 **서버(RSC/Route Handler) + RLS**에서 이중으로. 클라이언트 값 신뢰 금지.

---

## 3. 기술 스택 & 아키텍처

### 3.1 스택
- **프론트/백엔드**: Next.js(App Router), React, TypeScript, Server Components + Route Handlers.
- **DB/인증/스토리지**: Supabase(PostgreSQL, Auth, Storage, Row Level Security, Edge Functions).
- **호스팅**: Vercel (프리뷰 배포, 크론, 환경변수).
- **스타일**: Tailwind CSS(권장) 또는 CSS Modules.
- **i18n**: `next-intl` 등(한국어 기본, 영어 지원).
- **리치 에디터**: TipTap 등 React WYSIWYG (기존 SmartEditor2 대체).
- **이메일**: Resend 또는 SendGrid.
- **캡차**: Cloudflare Turnstile 또는 Google reCAPTCHA v2/v3.
- **엑셀 내보내기**: `exceljs`(서버 Route Handler에서 생성).
- **AI**: Anthropic API(Claude) 또는 OpenRouter, Vercel AI SDK(스트리밍 + tool calling).
- **파일**: Supabase Storage 버킷(원본/썸네일).

### 3.2 아키텍처 개요
```
[브라우저]
   │  (SSR/RSC, REST/Server Actions, SSE 스트리밍)
   ▼
[Next.js on Vercel]
   ├─ 공개 페이지(RSC) ─ Supabase(RLS: 공개 읽기)
   ├─ 인증 ─ Supabase Auth (쿠키 세션)
   ├─ 게시판/심포지엄/회원 API(Route Handlers/Server Actions) ─ Supabase(RLS)
   ├─ 파일 업/다운로드 ─ Supabase Storage
   ├─ 챗봇 API(/api/chat) ─ LLM(Anthropic/OpenRouter) + 서버측 도구 실행(RLS)
   └─ (선택) 관리자 코드-운영 ─ Hermes gateway(미니PC) 커스텀 채널
```

### 3.3 렌더링 원칙
- 공개 콘텐츠는 가능하면 **RSC + 캐시/ISR**로 빠르게.
- 변경 작업은 **Server Actions/Route Handlers**에서 인증·검증 후 Supabase에 반영.
- 챗봇 응답은 **SSE 스트리밍**(Vercel AI SDK).

---

## 4. 사이트맵 / 정보구조

```
/                        홈(인트로, 공지/소식/자유게시판 최신, 배너, 팝업)
/about/greet             학회장 인사말        (편집 가능 페이지)
/about/history           연혁                (편집 가능 페이지)
/about/term              정관
/about/member            임원진
/company                 참여기업/기관
/links                   관련 링크
/group/notice            공지사항 (board type=notice)
/group/news              관련소식 (news)
/group/member            회원동정 (member)
/group/speaker           연사제안 (speaker)
/group/free              자유게시판 (free)
/group/{board}/view/{id} 글 상세
/group/{board}/write     글 작성 (권한 필요)
/group/{board}/edit/{id} 글 수정 (작성자/관리자)
/symposium/domestic      국내 심포지엄 목록/상세
/symposium/international  한중일 국제 심포지엄
/symposium/apply         참가 접수
/symposium/searchApply   접수 조회
/member/login /signup /findId /findPwd /myinfo /edit  회원 기능
/admin/**                관리자 백오피스 (ROLE_ADMIN)
```

---

## 5. 기능 요구사항 (모듈별)

### 5.1 공개 페이지
- 인사말, 연혁, 정관, 임원진, 참여기업, 링크.
- **편집 가능 페이지(인사말/연혁 등)**: DB(`page_content`)에 저장된 HTML을 렌더, 없으면 기본값. 관리자가 챗봇/백오피스로 수정(재배포 불필요). → 5.6 챗봇 Phase 3와 연동.
- 다국어: 한/영 콘텐츠 필드 분리(`content`, `content_en`).

### 5.2 게시판 (Boards)
- 게시판 종류: **notice(공지사항), news(관련소식), member(회원동정), speaker(연사제안), free(자유게시판)**.
- 기능: 목록(페이지네이션), 검색(제목/내용 LIKE), 상세(조회수 증가), 작성/수정/삭제, 첨부파일·이미지, 댓글(Reply), 다국어 제목(title/title_en).
- 권한:
  - 읽기: 공개(또는 게시판별 설정).
  - 쓰기: 게시판별로 다름(공지=관리자, 소식/회원동정/자유=로그인 회원, 연사제안=로그인).
  - 수정/삭제: 작성자 본인 또는 관리자.
- 이미지 업로드: 리치 에디터 내 이미지 → Supabase Storage + 썸네일.
- 홈 위젯: 공지 3건, 소식 5건, 자유게시판 5건 최신 노출.

### 5.3 심포지엄 & 참가접수
- 심포지엄 종류: **국내 / 한중일 국제**(`national`, `sympType`).
- 목록 + 상세(개요/인사말/프로그램/등록/장소/후원 등 **탭 구성**; `symposium_detail`에 탭별 콘텐츠).
- **참가 접수(Apply)**: 회원이 심포지엄에 신청. 필드: 이름, 이메일(email+domain), 소속분류(classification), 직급/레벨(level), 전화, 국가(national/nationalCustom), 회원유형(memberType), 발표자여부(isSpeaker). 중복 접수 방지.
- **접수 조회**: 이름/전화로 조회.
- 관리자: 접수자 목록/엑셀 내보내기, 심포지엄/상세 CRUD.

### 5.4 회원 / 인증 (Supabase Auth)
- 회원가입(캡차 검증), 로그인/로그아웃, 내정보 조회/수정, 회원탈퇴.
- 아이디 찾기(이름+전화), 비밀번호 재설정(이메일 토큰 링크).
- 프로필 필드: login/username/phone/email/domain/classification/level/address/addressDetail/telephone/role.
- 비밀번호: Supabase Auth가 관리(기존 BCrypt 대체). 자체 password 컬럼 저장 금지.
- 가입 직후 자동 로그인.
- 로그인 리다이렉트(referer/loginRedirect) 유지.

> **주의**: 기존은 `users` 테이블에 자체 비밀번호(BCrypt) 저장. 신규는 **Supabase Auth**를 진실원본으로 하고,
> 프로필 부가정보는 `profiles` 테이블(auth.users.id FK)에 저장한다.

### 5.5 관리자 백오피스 (`/admin`, ROLE_ADMIN)
- 회원 관리: 목록/검색/정렬/수정/삭제, 역할 변경.
- 단체 메일(SendGrid/Resend) 발송 + 발송결과(EmailResult) 기록.
- 회원 목록 **엑셀 내보내기**.
- 팝업 관리(홈 팝업: 제목/링크/이미지/노출기간/순서).
- 국내/국제 심포지엄 관리, 상세 탭 편집.
- 메뉴(Menus) 관리(선택).
- 편집 가능 페이지(인사말 등) 관리.

### 5.6 AI 챗봇 (핵심 신규 기능) — 3단계

챗봇은 화면 우측 하단 **플로팅 위젯**(공개) + 관리자 확장 기능으로 구성. LLM은 서버(Route Handler)를
통해서만 호출하고 **API 키는 서버에만** 둔다. 응답은 **SSE 스트리밍**. tool calling으로 실제 작업 수행.

**Phase 1 — 방문자 안내(모든 방문자)**
- 학회/심포지엄/참가접수/게시판/가입 안내 Q&A. 시스템 프롬프트에 KSEE 정보.
- 비로그인 IP 기준 rate limit, 입력 길이 제한.
- 스트리밍, XSS 안전 렌더링(텍스트만).

**Phase 2 — 관리자 게시판 운영 도구(function calling, ROLE_ADMIN)**
- 도구: `list_posts`, `get_post`, `create_post`, `update_post`, `delete_post`.
- **모든 변경성 도구는 서버측에서 관리자 권한 재확인 후 실행**(LLM/클라이언트 불신). RLS로도 이중 방어.
- 삭제는 `confirm` 필수 + 사용자 확인 후에만.

**Phase 3 — 정적 페이지 내용 편집(DB 기반, ROLE_ADMIN)**
- 도구: `list_pages`, `get_page`, `update_page`.
- 인사말/연혁 등 `page_content` 행을 편집(코드/재배포 없이 즉시 반영). 없으면 기본값 폴백.

> 도구 결과는 실제 DB 반영값을 모델에 되먹여, 모델이 결과(링크/성공여부)를 사용자에게 정직하게 전달.

### 5.7 파일/미디어
- 업로드: **확장자 화이트리스트**(이미지: jpg/jpeg/png/gif/bmp/webp; 문서: pdf/hwp/hwpx/doc(x)/xls(x)/ppt(x)/txt/csv/zip). 실행/스크립트 차단.
- 이미지 업로드 시 Content-Type이 `image/*`인지 확인 + 썸네일 생성.
- 저장: Supabase Storage(버킷: `board-files`, `board-images`, `popups`). 공개/비공개 정책은 버킷별 RLS.
- 다운로드: 원본 파일명(한글 포함) 보존.

### 5.8 다국어(i18n)
- 기본 한국어, `?lang=en` 또는 로케일 라우팅으로 영어.
- 콘텐츠: title/title_en, content/content_en 등 2필드 방식 유지.
- UI 문자열: 메시지 카탈로그(ko/en).

---

## 6. 데이터 모델 (Supabase / PostgreSQL)

> 기존 MySQL 스키마를 현대화(snake_case, FK, timestamptz, 적절 타입)한 **재설계안**.
> 인증은 Supabase `auth.users`를 사용하고, 앱 프로필은 `profiles`로 분리.

```sql
-- 역할 enum
create type user_role as enum ('admin','student','general','company');

-- 회원 프로필 (auth.users 1:1)
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  login text unique,
  username text not null,
  role user_role not null default 'general',
  phone text,
  email text,
  domain text,
  classification text,      -- 소속분류
  level text,               -- 직급/레벨
  address text,
  address_detail text,
  telephone text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 게시판 종류
create table board_types (
  id smallint primary key,          -- 1..5
  slug text unique not null,        -- notice/news/member/speaker/free
  name text not null,               -- 공지사항 등
  name_en text
);

-- 게시글
create table posts (
  id bigint generated always as identity primary key,
  board_type smallint not null references board_types(id),
  title text not null,
  title_en text,
  content text,                     -- HTML
  writer uuid references profiles(id),
  view_count int default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);
create index on posts (board_type, created_at desc);

-- 첨부파일
create table post_files (
  id bigint generated always as identity primary key,
  post_id bigint references posts(id) on delete cascade,
  name text not null,               -- 원본 파일명
  storage_path text not null,       -- Supabase Storage 경로
  size int,
  content_type text,
  uploader uuid references profiles(id),
  created_at timestamptz default now()
);

-- 이미지/사진
create table post_images (
  id bigint generated always as identity primary key,
  post_id bigint references posts(id) on delete cascade,
  name text,
  storage_path text not null,
  thumbnail_path text,
  size int,
  content_type text,
  ordering int default 0,
  uploader uuid references profiles(id),
  created_at timestamptz default now()
);

-- 댓글
create table replies (
  id bigint generated always as identity primary key,
  post_id bigint references posts(id) on delete cascade,
  content text not null,
  writer uuid references profiles(id),
  created_at timestamptz default now()
);

-- 심포지엄
create table symposiums (
  id bigint generated always as identity primary key,
  title text not null,
  title_en text,
  place text,
  place_en text,
  symp_type smallint,               -- 국내/국제 구분
  is_international boolean default false,
  national text,                    -- 국가 구분
  start_date date,
  finish_date date,
  apply_start timestamptz,
  apply_finish timestamptz,
  created_at timestamptz default now()
);

-- 심포지엄 상세(탭별 콘텐츠)
create table symposium_details (
  id bigint generated always as identity primary key,
  symposium_id bigint references symposiums(id) on delete cascade,
  tab_key text not null,            -- overview/greeting/program/register/venue/sponsor...
  title text,
  content text,                     -- HTML
  ordering int default 0
);

-- 참가 접수
create table applies (
  id bigint generated always as identity primary key,
  symposium_id bigint references symposiums(id) on delete cascade,
  username text not null,
  email text,
  domain text,
  telephone text,
  classification text,
  level text,
  member_type text,
  national text,
  national_custom text,
  is_speaker boolean default false,
  created_at timestamptz default now(),
  unique (symposium_id, username, telephone)   -- 중복 접수 방지(예시)
);

-- 팝업
create table popups (
  id bigint generated always as identity primary key,
  title text,
  link text,
  image_path text,
  start_date date,
  finish_date date,
  ordering int default 0,
  active boolean default true
);

-- 메뉴(선택)
create table menus (
  id int primary key,
  parent int default 0,
  title text,
  title_en text,
  url text,
  ordering int default 0
);

-- 편집 가능한 정적 페이지 콘텐츠
create table page_content (
  id bigint generated always as identity primary key,
  content_key text unique not null, -- about.greet, about.history ...
  title text,
  content text,                     -- 한국어 HTML
  content_en text,                  -- 영문 HTML
  updated_at timestamptz default now()
);

-- 메일 발송 결과
create table email_results (
  id bigint generated always as identity primary key,
  receiver text,
  status text,
  response text,
  created_at timestamptz default now()
);
```

> 비밀번호 재설정은 Supabase Auth의 매직링크/리셋 기능을 사용하므로 별도 토큰 테이블 불필요.

---

## 7. 보안 요구사항 (필수)

기존 앱에서 발견·수정한 취약점을 신규에서 **구조적으로** 방지한다.

1. **SQL Injection 불가**: Supabase 클라이언트/PostgREST의 파라미터 바인딩만 사용. 원시 문자열 SQL 금지.
2. **RLS(행 수준 보안) 필수**: 모든 테이블에 RLS 활성화.
   - 공개 읽기: posts/page_content/symposiums 등은 `select` 공개(또는 조건부).
   - 쓰기/수정/삭제: `auth.uid()` 기반 + 역할(admin) 체크 정책.
   - 예: 게시글 수정은 `writer = auth.uid() OR is_admin(auth.uid())`.
3. **서버측 권한 재검증**: 챗봇 도구/관리자 액션은 Route Handler/Server Action에서 세션·역할을 다시 확인.
4. **비밀은 환경변수/Vercel 시크릿**: LLM 키, 서비스 롤 키, SMTP 키 등. 클라이언트 노출 금지.
   - `SUPABASE_SERVICE_ROLE_KEY`는 **서버에서만**. 브라우저엔 `NEXT_PUBLIC_SUPABASE_ANON_KEY`만.
5. **파일 업로드 화이트리스트**(5.7) + Storage 버킷 정책.
6. **캡차**: 회원가입/문의 등 남용 가능 지점.
7. **rate limit**: 챗봇/인증/접수 엔드포인트.
8. **CSRF**: Server Actions는 기본 보호. 커스텀 변경 API는 SameSite 쿠키 + Origin 검증.
9. **XSS**: 사용자 HTML(게시글/페이지 콘텐츠)은 저장·렌더 시 **sanitize**(DOMPurify 등). 관리자 콘텐츠도 신뢰하되 최소 정화.
10. **감사 로그**: 관리자/챗봇의 변경 작업 로깅.

---

## 8. 기존 → 신규 매핑 & 마이그레이션

| 기존 | 신규 |
|------|------|
| Spring MVC Controller/JSP | Next.js RSC + Route Handlers + React |
| MyBatis + MySQL | Supabase(PostgreSQL) + supabase-js / RLS |
| Spring Security(BCrypt) | Supabase Auth |
| 로컬 파일시스템 업로드 | Supabase Storage |
| SmartEditor2 | TipTap(React WYSIWYG) |
| Spring MessageSource(properties) | next-intl 메시지 카탈로그 + `page_content`(DB) |
| POI 엑셀 | exceljs(서버) |
| SendGrid(파일키) | Resend/SendGrid(환경변수) |
| Tomcat/WAR | Vercel |

**데이터 이관 절차(선택)**
1. MySQL 덤프 → 변환 스크립트로 Postgres 스키마(6장)에 적재.
2. 회원: 기존 BCrypt 해시는 Supabase Auth로 직접 못 옮김 → **비밀번호 재설정 유도**(가입 이메일로 리셋 링크) 또는 마이그레이션 시 임시 비번+최초 로그인 리셋.
3. 첨부파일: 기존 업로드 디렉터리 → Supabase Storage 업로드(경로 매핑 테이블).
4. 게시판 타입/메뉴/심포지엄은 seed 스크립트로 초기화.

---

## 9. (선택) 관리자 코드-운영 자동화 — Hermes 연동

> 코어 재구축과 **분리된 후속 단계**. 방문자 경로와 절대 섞지 않는다.

- 미니PC에서 **Hermes Agent gateway** + `gh`/`supabase`/`vercel` CLI 구동.
- KSEE 관리자 콘솔을 **Hermes 커스텀 채널**로 연결(커스텀 platform 플러그인 또는 API Server/Webhook).
- 흐름: 관리자 채팅 → (서버 ROLE_ADMIN 검증) → Hermes가 소스 레포 수정 → `gh` push → Vercel 자동 배포.
- **보안 가드레일(필수)**:
  1. 공개 챗봇과 완전 분리, 관리자 전용.
  2. KSEE 서버 ↔ Hermes는 사설·토큰 인증 링크(미니PC 공개노출 금지).
  3. Hermes allowlist(`GATEWAY_ALLOWED_USERS`) 2차 방어.
  4. 배포/DB 변경 등 파괴적 작업은 Hermes **approvals(승인)** 단계.
- 역할 분담: **일상 데이터(게시글 등)=직접 DB 도구(즉시)** / **코드·구조 변경=Hermes+git+배포**.

---

## 10. 비기능 요구사항 (NFR)

- **성능**: 공개 페이지 LCP < 2.5s, RSC 캐시/ISR 활용.
- **가용성**: Vercel + Supabase 관리형. 배포 무중단, 프리뷰 환경.
- **접근성**: 시맨틱 마크업, 키보드 내비, 대비 준수.
- **SEO**: 메타/OG 태그, sitemap, 서버 렌더.
- **반응형**: 모바일/데스크톱.
- **관측성**: Vercel Analytics/Logs, 에러 추적(Sentry 등).
- **국제화**: ko/en.

---

## 11. 환경변수 (예시)

```
# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=          # 서버 전용

# LLM (챗봇)
OPENROUTER_API_KEY=                 # 또는 ANTHROPIC_API_KEY
CHATBOT_MODEL=google/gemini-2.0-flash-001   # 또는 claude-haiku-4-5
CHATBOT_RATELIMIT_PER_MIN=15

# 이메일
RESEND_API_KEY=                     # 또는 SENDGRID_API_KEY

# 캡차
TURNSTILE_SECRET_KEY=               # 또는 RECAPTCHA_SECRET_KEY
NEXT_PUBLIC_TURNSTILE_SITE_KEY=

# (선택) Hermes
HERMES_GATEWAY_URL=
HERMES_GATEWAY_TOKEN=
```

---

## 12. 마일스톤 / 단계 계획

| 단계 | 범위 | 산출물 |
|------|------|--------|
| M0 | 프로젝트 셋업 | Next.js+TS+Tailwind, Supabase 프로젝트, CI, 환경변수, 스키마(6장) 적용 |
| M1 | 인증·회원 | 가입/로그인/내정보/찾기, 프로필, RLS |
| M2 | 공개 페이지 | 홈/소개/연혁/정관/임원진/링크, i18n, page_content |
| M3 | 게시판 | 5종 게시판 CRUD, 첨부/이미지(Storage), 댓글, 검색, 홈 위젯 |
| M4 | 심포지엄·접수 | 목록/상세(탭)/접수/조회, 관리자 심포지엄 관리 |
| M5 | 관리자 백오피스 | 회원/팝업/메일/엑셀/페이지 관리 |
| M6 | 챗봇 Phase 1 | 안내 챗봇(스트리밍, rate limit) |
| M7 | 챗봇 Phase 2·3 | 관리자 게시판 도구 + 페이지 편집 도구 |
| M8 | (선택) Hermes | 관리자 코드-운영 채널, 가드레일 |
| M9 | 데이터 이관·런칭 | 마이그레이션, QA, 도메인 전환 |

---

## 13. 미해결/결정 필요 사항 (Open Questions)

1. 기존 데이터를 이관할 것인가(회원/게시글/심포지엄), 신규 시작할 것인가?
2. 인증 이메일/도메인 전략(기존 email+domain 분리 필드 유지 여부).
3. 리치 에디터 선택(TipTap 등)과 기존 SmartEditor 콘텐츠 호환.
4. 캡차/이메일 제공자 최종 선택.
5. 챗봇 LLM 제공자(Anthropic vs OpenRouter)와 기본 모델.
6. Hermes 연동을 이번 범위에 포함할지, 후속으로 뺄지.
7. 편집 가능 페이지 범위(인사말/연혁 외 확대 대상).

---

## 부록 A. 기존 앱 기능 인벤토리(참고)

- 컨트롤러: Home, About, Board, Group, Community, Symposium, Apply, Member, Admin,
  AdminMembers, AdminDomestic, AdminInternational, Popup, Reply, File, SmartEditor, Inc, Ksee(base).
- 게시판 타입 상수: notice=1, news=2, member=3, speaker=4, free=5, group=7(1~5 통합).
- 업로드 경로(기존): `{user.dir}/tomcat/webapps/repository/upload`.
- 이메일: 비밀번호 재설정 토큰 링크, 회원 단체메일(SendGrid), 발송결과 기록.
- 다국어: `messages_ko_KR.properties` / `messages_en_US.properties`, 콘텐츠는 spring:message 코드.
- 챗봇(현행 Java 버전): `ChatbotController`(SSE 프록시) + `ChatbotService`(OpenRouter 스트리밍/tool loop)
  + `ChatbotToolService`(게시판/페이지 도구) + `PageContentService`(DB 페이지). 신규에서 동일 개념을 Next.js로 이식.

## 부록 B. 보안 체크리스트(런칭 전)
- [ ] 모든 테이블 RLS on, 정책 리뷰
- [ ] 서비스 롤 키 서버 전용 확인
- [ ] 챗봇 도구 서버측 admin 재검증
- [ ] 업로드 화이트리스트 + 버킷 정책
- [ ] 캡차/rate limit 적용
- [ ] 사용자 HTML sanitize
- [ ] 비밀 전부 환경변수, 리포지토리에 키 없음
