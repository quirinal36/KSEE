# 보안 설정 안내 (자격증명 관리)

이 프로젝트의 민감한 자격증명(DB 비밀번호, reCAPTCHA/SendGrid/OpenRouter 키)은
**환경변수로 주입**하는 것을 권장합니다. 코드는 아래 우선순위로 값을 해석합니다.

| 용도 | 환경변수(1순위) | 파일 폴백(2순위) |
|------|----------------|------------------|
| DB 드라이버 | `MYSQL_DRIVER` | `db.properties` `mysql.driver` |
| DB URL | `MYSQL_JDBC_URL` | `db.properties` `mysql.jdbcUrl` |
| DB 사용자 | `MYSQL_USERNAME` | `db.properties` `mysql.username` |
| DB 비밀번호 | `MYSQL_PASSWORD` | `db.properties` `mysql.password` |
| reCAPTCHA site key | `RECAPTCHA_SITE_KEY` | `recaptcha.properties` |
| reCAPTCHA secret key | `RECAPTCHA_SECRET_KEY` | `recaptcha.properties` |
| SendGrid API 키 | `SENDGRID_API_KEY` | `sendgrid.env` |
| OpenRouter API 키 | `OPENROUTER_API_KEY` | `chatbot.properties` |

## Tomcat 환경변수 설정 예시

`$CATALINA_BASE/bin/setenv.sh` (없으면 생성):

```sh
export MYSQL_JDBC_URL="jdbc:mysql://DB_HOST:3306/DB_NAME?useSSL=true&serverTimezone=UTC"
export MYSQL_USERNAME="이용자"
export MYSQL_PASSWORD="새로_재발급한_비밀번호"
export RECAPTCHA_SITE_KEY="..."
export RECAPTCHA_SECRET_KEY="..."
export SENDGRID_API_KEY="SG...."
export OPENROUTER_API_KEY="sk-or-...."
```

## ⚠️ 반드시 해야 할 일 (자격증명 재발급)

기존에 다음 파일들이 실제 키와 함께 Git 저장소에 커밋되어 **이미 노출**되었습니다.
저장소 접근 권한이 있었거나 히스토리를 본 사람은 이 값을 알 수 있으므로,
**모두 재발급(rotation)** 해야 합니다.

- `db.properties` — MySQL 비밀번호 변경
- `recaptcha.properties` — reCAPTCHA 키 재발급 (Google reCAPTCHA 콘솔)
- `sendgrid.env`, `sendgrid2.env` — SendGrid API 키 재발급 후 기존 키 폐기
- OpenRouter 키 — 재발급 (채팅으로 공유된 이력 있음)

재발급한 값은 위 환경변수로만 주입하고, 파일에는 남기지 마세요.

## DB 연결 TLS 인증서 검증 (MITM 방지)

현재 `db.properties` 의 접속 URL 은 `verifyServerCertificate=false` 로 서버
인증서를 **검증하지 않습니다.** 연결은 암호화되지만 중간자 공격(MITM)에
취약합니다.

권장 설정(환경변수 `MYSQL_JDBC_URL` 또는 `db.properties` 에 적용):

```
# 인증서까지 검증 (가장 안전). 서버 인증서/CA 를 JVM truststore 에 신뢰 등록 필요
jdbc:mysql://DB_HOST:3306/DB_NAME?sslMode=VERIFY_IDENTITY&serverTimezone=UTC

# 자체서명 등으로 검증이 어렵다면 최소 이 설정(암호화 O, 검증 X)
jdbc:mysql://DB_HOST:3306/DB_NAME?sslMode=REQUIRED&serverTimezone=UTC
```

⚠️ 이 변경은 DB 서버의 인증서 신뢰 설정에 따라 **연결이 끊길 수 있어**,
운영에서 인증서 준비를 마친 뒤 적용하세요. (그래서 코드/라이브 파일은
자동으로 바꾸지 않았습니다.)

## CSRF 보호 (미적용, 검토 필요)

`WebSecurityConfig` 에서 `csrf().disable()` 로 CSRF 보호가 꺼져 있습니다.
재활성화하면 게시판 작성/회원정보 수정/관리자 작업 등 모든 상태변경 요청과
다수의 AJAX 호출에 CSRF 토큰을 실어야 하므로, 폼·스크립트 전반을 함께
수정해야 합니다(침습적). 별도 작업으로 진행 권장.

## Git 히스토리 정리 (선택, 권장)

파일에서 값을 지워도 **과거 커밋 히스토리에는 남아 있습니다.**
완전 제거가 필요하면 `git filter-repo` 또는 BFG Repo-Cleaner 로 히스토리를
정리하세요. (강제 푸시가 필요한 파괴적 작업이므로 팀과 협의 후 진행)

## 현재 상태

- 코드에 환경변수 우선 지원이 추가되었습니다(파일 값 폴백 유지 → 기존 배포 무중단).
- 커밋된 실제 키 파일(`db.properties` 등)은 **아직 저장소에 남아 있습니다.**
  재발급 + 환경변수 설정을 마친 뒤, 파일에서 값을 비우거나 저장소에서 제거하세요
  (요청 시 이 작업을 도와드릴 수 있습니다).
