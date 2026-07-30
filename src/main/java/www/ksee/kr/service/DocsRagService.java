package www.ksee.kr.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.util.StreamUtils;

/**
 * 클래스패스의 기능 문서를 작은 단위로 나누고 질문과 관련도가 높은 구간을 찾는다.
 * 외부 벡터 DB 없이 동작하도록 키워드, 한글 접미사 정규화, 문자 n-gram을 조합한다.
 */
@Service
public class DocsRagService {

	private static final int MAX_CHUNK_LENGTH = 1500;
	private static final int MAX_CONTEXT_LENGTH = 8500;
	private static final int DEFAULT_RESULT_COUNT = 5;
	private static final double MIN_RELEVANCE_SCORE = 0.75;
	private static final Pattern TOKEN_PATTERN = Pattern.compile("[\\p{L}\\p{N}]{2,}");

	private static final Map<String, String> DOCUMENTS;
	static {
		Map<String, String> documents = new LinkedHashMap<String, String>();
		documents.put("overview", "README.md");
		documents.put("architecture", "01-architecture.md");
		documents.put("public-content", "02-public-content.md");
		documents.put("member", "03-member.md");
		documents.put("symposium-application", "04-symposium-application.md");
		documents.put("board-comment", "05-board-comment.md");
		documents.put("file-image", "06-file-image.md");
		documents.put("admin", "07-admin.md");
		documents.put("route-catalog", "08-route-catalog.md");
		documents.put("chatbot", "09-chatbot.md");
		DOCUMENTS = Collections.unmodifiableMap(documents);
	}

	private volatile List<DocumentChunk> chunks = Collections.emptyList();

	@PostConstruct
	public void initialize() {
		List<DocumentChunk> loaded = new ArrayList<DocumentChunk>();
		for (Map.Entry<String, String> entry : DOCUMENTS.entrySet()) {
			try {
				String markdown = readDocument(entry.getValue());
				loaded.addAll(split(entry.getKey(), entry.getValue(), markdown));
			} catch (IOException ignored) {
				// 일부 문서가 없어도 나머지 문서로 검색 서비스를 제공한다.
			}
		}
		chunks = Collections.unmodifiableList(loaded);
	}

	public SearchResult search(String question) {
		String normalizedQuestion = normalize(question);
		Set<String> queryTerms = terms(normalizedQuestion);
		Set<String> queryBigrams = bigrams(normalizedQuestion);
		List<ScoredChunk> scored = new ArrayList<ScoredChunk>();

		for (DocumentChunk chunk : chunks) {
			double score = score(chunk, normalizedQuestion, queryTerms, queryBigrams);
			scored.add(new ScoredChunk(chunk, score));
		}
		Collections.sort(scored, new Comparator<ScoredChunk>() {
			@Override
			public int compare(ScoredChunk left, ScoredChunk right) {
				return Double.compare(right.score, left.score);
			}
		});

		StringBuilder context = new StringBuilder();
		List<Source> sources = new ArrayList<Source>();
		Set<String> sourceKeys = new HashSet<String>();
		Map<String, Integer> chunksPerDocument = new HashMap<String, Integer>();
		int selected = 0;
		for (ScoredChunk item : scored) {
			if (selected >= DEFAULT_RESULT_COUNT) {
				break;
			}
			if (item.score < MIN_RELEVANCE_SCORE) {
				break;
			}
			Integer documentChunkCount = chunksPerDocument.get(item.chunk.documentKey);
			if (documentChunkCount != null && documentChunkCount >= 2) {
				continue;
			}
			String block = "\n\n[문서: " + item.chunk.filename + " / " + item.chunk.heading + "]\n"
					+ item.chunk.content;
			if (context.length() + block.length() > MAX_CONTEXT_LENGTH) {
				continue;
			}
			context.append(block);
			selected++;
			chunksPerDocument.put(item.chunk.documentKey,
					documentChunkCount == null ? 1 : documentChunkCount + 1);
			if (sourceKeys.add(item.chunk.documentKey)) {
				sources.add(new Source(item.chunk.documentKey, item.chunk.filename,
						"/docs/" + item.chunk.documentKey));
			}
		}
		return new SearchResult(context.toString().trim(), sources);
	}

	private String readDocument(String filename) throws IOException {
		ClassPathResource resource = new ClassPathResource("docs/" + filename);
		InputStream input = resource.getInputStream();
		try {
			return StreamUtils.copyToString(input, StandardCharsets.UTF_8);
		} finally {
			input.close();
		}
	}

	private List<DocumentChunk> split(String documentKey, String filename, String markdown) {
		List<DocumentChunk> result = new ArrayList<DocumentChunk>();
		String[] lines = markdown.replace("\r\n", "\n").split("\n");
		String heading = filename;
		StringBuilder content = new StringBuilder();

		for (String line : lines) {
			if (line.matches("^#{1,3}\\s+.*")) {
				if (content.length() > 0) {
					addSizedChunks(result, documentKey, filename, heading, content.toString());
				}
				heading = line.replaceFirst("^#{1,3}\\s+", "").trim();
				content.setLength(0);
			}
			content.append(line).append('\n');
		}
		if (content.length() > 0) {
			addSizedChunks(result, documentKey, filename, heading, content.toString());
		}
		return result;
	}

	private void addSizedChunks(List<DocumentChunk> target, String documentKey, String filename,
			String heading, String content) {
		String remaining = content.trim();
		while (remaining.length() > MAX_CHUNK_LENGTH) {
			int splitAt = remaining.lastIndexOf('\n', MAX_CHUNK_LENGTH);
			if (splitAt < MAX_CHUNK_LENGTH / 2) {
				splitAt = remaining.lastIndexOf(' ', MAX_CHUNK_LENGTH);
			}
			if (splitAt < MAX_CHUNK_LENGTH / 2) {
				splitAt = MAX_CHUNK_LENGTH;
			}
			target.add(new DocumentChunk(documentKey, filename, heading,
					remaining.substring(0, splitAt).trim()));
			remaining = remaining.substring(splitAt).trim();
		}
		if (remaining.length() > 0) {
			target.add(new DocumentChunk(documentKey, filename, heading, remaining));
		}
	}

	private double score(DocumentChunk chunk, String normalizedQuestion, Set<String> queryTerms,
			Set<String> queryBigrams) {
		String body = normalize(chunk.content);
		String heading = normalize(chunk.heading + " " + chunk.filename);
		double score = 0;
		for (String term : queryTerms) {
			score += occurrences(body, term) * 2.0;
			score += occurrences(heading, term) * 5.0;
		}
		if (normalizedQuestion.length() >= 4 && body.contains(normalizedQuestion)) {
			score += 12.0;
		}
		Set<String> bodyBigrams = bigrams(heading + " " + body);
		int overlap = 0;
		for (String bigram : queryBigrams) {
			if (bodyBigrams.contains(bigram)) {
				overlap++;
			}
		}
		if (!queryBigrams.isEmpty()) {
			score += ((double) overlap / queryBigrams.size()) * 4.0;
		}
		return score;
	}

	private int occurrences(String text, String term) {
		int count = 0;
		int index = 0;
		while ((index = text.indexOf(term, index)) >= 0) {
			count++;
			index += term.length();
		}
		return Math.min(count, 5);
	}

	private Set<String> terms(String text) {
		Set<String> result = new HashSet<String>();
		Matcher matcher = TOKEN_PATTERN.matcher(text);
		while (matcher.find()) {
			String token = stripKoreanSuffix(matcher.group());
			if (token.length() >= 2) {
				result.add(token);
			}
		}
		return result;
	}

	private String stripKoreanSuffix(String token) {
		String[] suffixes = {"인가요", "에서는", "으로는", "에서", "에게", "까지", "부터", "하고",
				"으로", "로는", "에는", "은요", "는요", "이요", "가요", "을", "를", "은", "는",
				"이", "가", "의", "에", "로", "와", "과", "도", "만"};
		for (String suffix : suffixes) {
			if (token.endsWith(suffix) && token.length() - suffix.length() >= 2) {
				return token.substring(0, token.length() - suffix.length());
			}
		}
		return token;
	}

	private Set<String> bigrams(String text) {
		String compact = text.replaceAll("[^\\p{L}\\p{N}]", "");
		Set<String> result = new HashSet<String>();
		for (int i = 0; i + 2 <= compact.length(); i++) {
			result.add(compact.substring(i, i + 2));
		}
		return result;
	}

	private String normalize(String value) {
		return value == null ? "" : value.toLowerCase(Locale.KOREA).replaceAll("\\s+", " ").trim();
	}

	private static class DocumentChunk {
		private final String documentKey;
		private final String filename;
		private final String heading;
		private final String content;

		private DocumentChunk(String documentKey, String filename, String heading, String content) {
			this.documentKey = documentKey;
			this.filename = filename;
			this.heading = heading;
			this.content = content;
		}
	}

	private static class ScoredChunk {
		private final DocumentChunk chunk;
		private final double score;

		private ScoredChunk(DocumentChunk chunk, double score) {
			this.chunk = chunk;
			this.score = score;
		}
	}

	public static class SearchResult {
		private final String context;
		private final List<Source> sources;

		private SearchResult(String context, List<Source> sources) {
			this.context = context;
			this.sources = Collections.unmodifiableList(sources);
		}

		public String getContext() {
			return context;
		}

		public List<Source> getSources() {
			return sources;
		}
	}

	public static class Source {
		private final String key;
		private final String title;
		private final String url;

		private Source(String key, String title, String url) {
			this.key = key;
			this.title = title;
			this.url = url;
		}

		public String getKey() {
			return key;
		}

		public String getTitle() {
			return title;
		}

		public String getUrl() {
			return url;
		}
	}
}
