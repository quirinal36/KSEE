/* ==========================================================================
 * KSEE 챗봇 위젯 클라이언트
 * - fetch + ReadableStream 으로 서버(SSE)를 읽어 실시간 표시
 * - 렌더링은 textContent 로만 하여 XSS 를 방지한다
 * ========================================================================== */
(function () {
	'use strict';

	var cfg = window.KSEE_CHATBOT || {};
	var MAX_HISTORY = 20;

	var toggleBtn, panel, closeBtn, messagesEl, form, textEl, sendBtn, disabledNote;
	var history = [];       // [{role:'user'|'assistant', content:'...'}]
	var streaming = false;
	var statusChecked = false;

	document.addEventListener('DOMContentLoaded', init);

	function init() {
		toggleBtn = document.getElementById('kc-toggle');
		panel = document.getElementById('kc-panel');
		closeBtn = document.getElementById('kc-close');
		messagesEl = document.getElementById('kc-messages');
		form = document.getElementById('kc-form');
		textEl = document.getElementById('kc-text');
		sendBtn = document.getElementById('kc-send');
		disabledNote = document.getElementById('kc-disabled-note');

		if (!toggleBtn || !panel) {
			return;
		}

		toggleBtn.addEventListener('click', togglePanel);
		closeBtn.addEventListener('click', closePanel);
		form.addEventListener('submit', onSubmit);

		// 관리자에게는 게시판 작업이 가능함을 안내
		if (cfg.isAdmin) {
			appendMessage('bot', '관리자로 로그인하셨습니다. 게시판 글 조회·작성·수정·삭제를 채팅으로 요청할 수 있어요. 예) "공지사항 최근 글 목록 보여줘", "자유게시판에 \'회비 안내\' 제목으로 공지 올려줘"');
		}

		// 입력창 자동 높이 + Enter 전송(Shift+Enter 줄바꿈)
		textEl.addEventListener('input', autoGrow);
		textEl.addEventListener('keydown', function (e) {
			if (e.key === 'Enter' && !e.shiftKey) {
				e.preventDefault();
				form.requestSubmit ? form.requestSubmit() : onSubmit(e);
			}
		});
	}

	function togglePanel() {
		if (panel.classList.contains('kc-hidden')) {
			openPanel();
		} else {
			closePanel();
		}
	}

	function openPanel() {
		panel.classList.remove('kc-hidden');
		checkStatus();
		setTimeout(function () { textEl.focus(); }, 50);
	}

	function closePanel() {
		panel.classList.add('kc-hidden');
	}

	function checkStatus() {
		if (statusChecked || !cfg.statusUrl) {
			return;
		}
		statusChecked = true;
		fetch(cfg.statusUrl, { credentials: 'same-origin' })
			.then(function (r) { return r.json(); })
			.then(function (s) {
				if (s && s.enabled === false) {
					disabledNote.classList.remove('kc-hidden');
					textEl.disabled = true;
					sendBtn.disabled = true;
				}
			})
			.catch(function () { /* 상태 확인 실패는 무시 */ });
	}

	function autoGrow() {
		textEl.style.height = 'auto';
		textEl.style.height = Math.min(textEl.scrollHeight, 120) + 'px';
	}

	function onSubmit(e) {
		if (e) { e.preventDefault(); }
		if (streaming) { return; }

		var message = (textEl.value || '').trim();
		if (!message) { return; }

		appendMessage('user', message);
		textEl.value = '';
		autoGrow();

		var botBubble = appendMessage('bot', '');
		var typing = showTyping(botBubble);

		setStreaming(true);

		streamChat(message, botBubble, typing)
			.then(function (full) {
				removeTyping(typing);
				if (!full) {
					botBubble.textContent = '(응답이 없습니다.)';
				}
				pushHistory(message, full);
			})
			.catch(function (err) {
				removeTyping(typing);
				botBubble.textContent = err && err.message ? err.message : '오류가 발생했습니다.';
			})
			.then(function () {
				setStreaming(false);
				textEl.focus();
			});
	}

	function streamChat(message, botBubble, typing) {
		return fetch(cfg.streamUrl, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json;charset=UTF-8' },
			credentials: 'same-origin',
			body: JSON.stringify({ message: message, history: history })
		}).then(function (resp) {
			if (!resp.ok) {
				return resp.json().catch(function () { return {}; }).then(function (j) {
					throw new Error(j.error || '오류가 발생했습니다.');
				});
			}
			if (!resp.body || !resp.body.getReader) {
				// 스트리밍 미지원 브라우저: 통째로 읽기
				return resp.text().then(function (t) {
					var full = collectFromText(t);
					botBubble.textContent = full;
					return full;
				});
			}
			return readStream(resp.body.getReader(), botBubble, typing);
		});
	}

	function readStream(reader, botBubble, typing) {
		var decoder = new TextDecoder('utf-8');
		var buffer = '';
		var full = '';
		var firstToken = true;

		function pump() {
			return reader.read().then(function (res) {
				if (res.done) {
					return full;
				}
				buffer += decoder.decode(res.value, { stream: true });

				var idx;
				while ((idx = buffer.indexOf('\n\n')) >= 0) {
					var rawEvent = buffer.slice(0, idx);
					buffer = buffer.slice(idx + 2);
					var evt = parseEvent(rawEvent);
					if (!evt) { continue; }

					if (evt.event === 'done') {
						return full;
					}
					if (evt.event === 'error') {
						var em = '오류가 발생했습니다.';
						try { em = JSON.parse(evt.data); } catch (e) { /* ignore */ }
						throw new Error(em);
					}
					// 일반 토큰
					var tok = '';
					try { tok = JSON.parse(evt.data); } catch (e) { tok = ''; }
					if (tok) {
						if (firstToken) { removeTyping(typing); firstToken = false; }
						full += tok;
						botBubble.textContent = full;
						scrollToBottom();
					}
				}
				return pump();
			});
		}
		return pump();
	}

	function parseEvent(raw) {
		var lines = raw.split('\n');
		var event = 'message';
		var dataParts = [];
		for (var i = 0; i < lines.length; i++) {
			var line = lines[i];
			if (line.indexOf('event:') === 0) {
				event = line.slice(6).trim();
			} else if (line.indexOf('data:') === 0) {
				dataParts.push(line.slice(5).trim());
			}
		}
		return { event: event, data: dataParts.join('\n') };
	}

	// 스트리밍 미지원 fallback: 텍스트 전체에서 토큰 이어붙이기
	function collectFromText(text) {
		var full = '';
		var blocks = text.split('\n\n');
		for (var i = 0; i < blocks.length; i++) {
			var evt = parseEvent(blocks[i]);
			if (!evt || evt.event === 'done' || evt.event === 'error') { continue; }
			try {
				var tok = JSON.parse(evt.data);
				if (tok) { full += tok; }
			} catch (e) { /* ignore */ }
		}
		return full;
	}

	function pushHistory(userMessage, assistantMessage) {
		history.push({ role: 'user', content: userMessage });
		if (assistantMessage) {
			history.push({ role: 'assistant', content: assistantMessage });
		}
		if (history.length > MAX_HISTORY) {
			history = history.slice(history.length - MAX_HISTORY);
		}
	}

	function setStreaming(on) {
		streaming = on;
		sendBtn.disabled = on;
	}

	// --- DOM helpers (textContent 로만 렌더링) ---

	function appendMessage(who, text) {
		var wrap = document.createElement('div');
		wrap.className = 'kc-msg ' + (who === 'user' ? 'kc-msg-user' : 'kc-msg-bot');

		var bubble = document.createElement('div');
		bubble.className = 'kc-bubble';
		bubble.textContent = text;

		wrap.appendChild(bubble);
		messagesEl.appendChild(wrap);
		scrollToBottom();
		return bubble;
	}

	function showTyping(bubble) {
		var typing = document.createElement('span');
		typing.className = 'kc-typing';
		typing.innerHTML = '<span></span><span></span><span></span>';
		bubble.appendChild(typing);
		return typing;
	}

	function removeTyping(typing) {
		if (typing && typing.parentNode) {
			typing.parentNode.removeChild(typing);
		}
	}

	function scrollToBottom() {
		messagesEl.scrollTop = messagesEl.scrollHeight;
	}
})();
