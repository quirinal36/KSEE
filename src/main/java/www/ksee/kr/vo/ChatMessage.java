package www.ksee.kr.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 챗봇 대화 메시지 한 건 (role + content)
 * OpenRouter(OpenAI 호환) 메시지 포맷과 1:1 대응된다.
 *
 * role 값: "system", "user", "assistant"
 */
@Getter
@Setter
@NoArgsConstructor
public class ChatMessage {
	private String role;
	private String content;

	public ChatMessage(String role, String content) {
		this.role = role;
		this.content = content;
	}
}
