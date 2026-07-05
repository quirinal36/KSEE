package www.ksee.kr.service;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import www.ksee.kr.dao.PageContentDAO;
import www.ksee.kr.vo.PageContent;

/**
 * DB 기반 정적 페이지 콘텐츠 서비스.
 *
 * <p>동작 원칙: 페이지에 대해 DB 행이 있으면 그 내용을, 없으면 기존 i18n 메시지
 * (properties)를 사용한다. 따라서 page_content 테이블이 아직 없거나 비어 있어도
 * 사이트는 기존과 동일하게 동작한다(안전한 점진적 도입).
 */
@Service
public class PageContentService {

	private static final Logger logger = LoggerFactory.getLogger(PageContentService.class);

	@Autowired
	private PageContentDAO dao;

	@Autowired
	private MessageSource messageSource;

	/** 편집 가능한 페이지 정보. */
	public static class PageInfo {
		public final String key;         // content_key
		public final String title;       // 관리자용 표시 이름
		public final String messageCode; // 기존 i18n 메시지 코드(기본 콘텐츠)
		public final String url;         // 페이지 경로

		public PageInfo(String key, String title, String messageCode, String url) {
			this.key = key;
			this.title = title;
			this.messageCode = messageCode;
			this.url = url;
		}
	}

	/** 챗봇으로 편집 가능한 페이지 레지스트리. 여기에 추가하면 편집 대상이 늘어난다. */
	private static final Map<String, PageInfo> REGISTRY = new LinkedHashMap<>();
	static {
		register(new PageInfo("about.greet", "학회장 인사말", "cont.greet_text", "/about/greet"));
		register(new PageInfo("about.history", "연혁", "cont.history_wrap", "/about/history"));
	}
	private static void register(PageInfo info) {
		REGISTRY.put(info.key, info);
	}

	public Collection<PageInfo> listPages() {
		return REGISTRY.values();
	}

	public PageInfo getInfo(String key) {
		return key == null ? null : REGISTRY.get(key);
	}

	public boolean isKnown(String key) {
		return getInfo(key) != null;
	}

	/**
	 * 페이지 렌더링용 콘텐츠. DB 행이 있으면 로케일에 맞는 값을, 없으면 null 을 반환한다.
	 * (null 이면 JSP 가 기존 spring:message 로 폴백한다.)
	 * 어떤 예외가 나도 null 을 반환하여 페이지가 깨지지 않게 한다.
	 */
	public String getForRender(String key, Locale locale) {
		PageContent pc = safeSelect(key);
		if (pc == null) {
			return null;
		}
		boolean en = locale != null && "en".equals(locale.getLanguage());
		if (en && pc.getContent_en() != null && !pc.getContent_en().trim().isEmpty()) {
			return pc.getContent_en();
		}
		String content = pc.getContent();
		return (content != null && !content.trim().isEmpty()) ? content : null;
	}

	/**
	 * 현재 유효 콘텐츠(관리자 조회용). DB 값이 있으면 그것을, 없으면 기존 메시지 값을 반환한다.
	 */
	public String getEffectiveContent(String key, Locale locale) {
		String db = getForRender(key, locale);
		if (db != null) {
			return db;
		}
		PageInfo info = getInfo(key);
		if (info == null) {
			return "";
		}
		try {
			return messageSource.getMessage(info.messageCode, null, locale != null ? locale : Locale.KOREA);
		} catch (Exception e) {
			return "";
		}
	}

	/** DB 원본 행(있으면). 테이블이 없거나 오류면 null. */
	public boolean hasDbRow(String key) {
		return safeSelect(key) != null;
	}

	/**
	 * 콘텐츠 저장(없으면 insert, 있으면 update). 성공 시 반영된 행 수(>0).
	 * 테이블 부재 등 DB 예외는 그대로 던진다(호출부에서 안내 처리).
	 */
	public int upsert(String key, String contentKo, String contentEn) {
		PageInfo info = getInfo(key);
		PageContent existing = dao.selectByKey(key);
		if (existing == null) {
			PageContent p = new PageContent();
			p.setContent_key(key);
			p.setTitle(info != null ? info.title : key);
			p.setContent(contentKo);
			p.setContent_en(contentEn);
			return dao.insert(p);
		} else {
			PageContent p = new PageContent();
			p.setContent_key(key);
			if (contentKo != null) {
				p.setContent(contentKo);
			}
			if (contentEn != null) {
				p.setContent_en(contentEn);
			}
			return dao.update(p);
		}
	}

	private PageContent safeSelect(String key) {
		if (key == null) {
			return null;
		}
		try {
			return dao.selectByKey(key);
		} catch (Exception e) {
			// page_content 테이블이 아직 없을 수 있음 → 폴백을 위해 null
			logger.debug("page_content lookup failed for key={} ({})", key, e.getMessage());
			return null;
		}
	}
}
