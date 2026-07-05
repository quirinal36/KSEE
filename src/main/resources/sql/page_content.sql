-- ==========================================================================
-- 정적 페이지 콘텐츠 테이블 (챗봇 Phase 3)
-- 배포 시 이 스크립트를 한 번 실행하세요. 실행 전에는 각 페이지가 기존
-- i18n 메시지(properties)로 정상 렌더링되고, 챗봇으로 편집 후 저장되면
-- DB 값이 우선 사용됩니다.
-- ==========================================================================

CREATE TABLE IF NOT EXISTS page_content (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    content_key VARCHAR(100) NOT NULL UNIQUE,   -- 예: about.greet, about.history
    title       VARCHAR(200),                   -- 관리자용 표시 이름
    content     MEDIUMTEXT,                      -- 한국어 HTML
    content_en  MEDIUMTEXT,                      -- 영문 HTML (선택)
    udate       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- (선택) 초기값을 미리 넣고 싶다면 아래처럼 삽입할 수 있습니다.
-- 넣지 않아도 챗봇이 처음 편집할 때 자동으로 행이 생성됩니다.
-- INSERT INTO page_content (content_key, title, content)
-- VALUES ('about.greet', '학회장 인사말', '<p>여기에 인사말 HTML</p>');
