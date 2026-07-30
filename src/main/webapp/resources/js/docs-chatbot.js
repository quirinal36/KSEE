(function () {
	'use strict';

	var contextPath = window.KSEE_CONTEXT_PATH || '';
	var storageKey = 'ksee-docs-chatbot-history-v1';
	var conversation = loadHistory();
	var isSending = false;

	function loadHistory() {
		try {
			var value = JSON.parse(window.sessionStorage.getItem(storageKey) || '[]');
			return Array.isArray(value) ? value.slice(-12) : [];
		} catch (error) {
			return [];
		}
	}

	function saveHistory() {
		try {
			window.sessionStorage.setItem(storageKey, JSON.stringify(conversation.slice(-12)));
		} catch (error) {
			// 저장소를 사용할 수 없어도 현재 페이지의 대화는 계속한다.
		}
	}

	function createElement(tag, className, text) {
		var element = document.createElement(tag);
		if (className) { element.className = className; }
		if (text !== undefined) { element.textContent = text; }
		return element;
	}

	function extractAnswerActions(content) {
		var linkPattern = /\[([^\]\r\n]+)\]\((\/[^\s)]+)\)/g;
		var text = content == null ? '' : String(content);
		var actions = [];
		var seenPaths = {};
		var answer = text.replace(linkPattern, function (all, label, path) {
			if (!seenPaths[path]) {
				actions.push({ label: label, path: path });
				seenPaths[path] = true;
			}
			return '';
		});
		return { content: answer.replace(/[ \t]+\n/g, '\n').replace(/\n{3,}/g, '\n\n').trim(), actions: actions };
	}

	function appendActions(container, actions) {
		if (!actions.length) { return; }
		var actionList = createElement('div', 'ksee-chatbot-sources');
		actions.forEach(function (action) {
			var button = createElement('a', '', action.label);
			button.href = contextPath + action.path;
			button.target = '_blank';
			button.rel = 'noopener';
			actionList.appendChild(button);
		});
		container.appendChild(actionList);
	}

	function buildWidget() {
		if (document.getElementById('ksee-chatbot-root')) {
			return;
		}

		var root = createElement('div', 'ksee-chatbot-root');
		root.id = 'ksee-chatbot-root';

		var toggle = createElement('button', 'ksee-chatbot-toggle');
		toggle.type = 'button';
		toggle.setAttribute('aria-label', '기능 안내 챗봇 열기');
		toggle.setAttribute('aria-expanded', 'false');
		toggle.innerHTML = '<svg class="ksee-chatbot-open-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M4 3h16a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H9l-5 4v-4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2zm3 6h10V7H7v2zm0 4h7v-2H7v2z"/></svg><span class="ksee-chatbot-close-icon" aria-hidden="true">&times;</span>';

		var panel = createElement('section', 'ksee-chatbot-panel');
		panel.setAttribute('role', 'dialog');
		panel.setAttribute('aria-label', 'KSEE 기능 안내 챗봇');

		var header = createElement('div', 'ksee-chatbot-header');
		var headerCopy = createElement('div', 'ksee-chatbot-header-copy');
		headerCopy.appendChild(createElement('strong', '', 'KSEE 기능 안내'));
		headerCopy.appendChild(createElement('span', '', '프로젝트 기능 문서를 바탕으로 답변합니다'));
		var reset = createElement('button', 'ksee-chatbot-reset', '대화 초기화');
		reset.type = 'button';
		header.appendChild(headerCopy);
		header.appendChild(reset);

		var messages = createElement('div', 'ksee-chatbot-messages');
		messages.setAttribute('aria-live', 'polite');
		var form = createElement('form', 'ksee-chatbot-form');
		var inputRow = createElement('div', 'ksee-chatbot-input-row');
		var input = createElement('textarea', 'ksee-chatbot-input');
		input.name = 'question';
		input.rows = 1;
		input.maxLength = 800;
		input.placeholder = '예: 참가신청은 어떻게 하나요?';
		input.setAttribute('aria-label', '기능 문서 질문');
		var send = createElement('button', 'ksee-chatbot-send', '전송');
		send.type = 'submit';
		inputRow.appendChild(input);
		inputRow.appendChild(send);
		form.appendChild(inputRow);
		form.appendChild(createElement('p', 'ksee-chatbot-note', '기능 문서에 없는 내용은 답변하지 않습니다.'));

		panel.appendChild(header);
		panel.appendChild(messages);
		panel.appendChild(form);
		root.appendChild(panel);
		root.appendChild(toggle);
		document.body.appendChild(root);

		function renderStoredConversation() {
			messages.innerHTML = '';
			if (conversation.length === 0) {
				appendMessage(messages, 'assistant', '안녕하세요. KSEE 웹사이트의 기능, URL, 이용 절차를 물어보세요.');
				return;
			}
			conversation.forEach(function (turn) {
				appendMessage(messages, turn.role, turn.content, false);
			});
		}

		toggle.addEventListener('click', function () {
			var open = !panel.classList.contains('is-open');
			panel.classList.toggle('is-open', open);
			toggle.classList.toggle('is-open', open);
			toggle.setAttribute('aria-expanded', String(open));
			toggle.setAttribute('aria-label', open ? '기능 안내 챗봇 닫기' : '기능 안내 챗봇 열기');
			if (open) { input.focus(); scrollBottom(messages); }
		});

		reset.addEventListener('click', function () {
			conversation = [];
			saveHistory();
			renderStoredConversation();
			input.focus();
		});

		input.addEventListener('input', function () {
			input.style.height = 'auto';
			input.style.height = Math.min(input.scrollHeight, 104) + 'px';
		});
		input.addEventListener('keydown', function (event) {
			if (event.key === 'Enter' && !event.shiftKey) {
				event.preventDefault();
				if (typeof form.requestSubmit === 'function') { form.requestSubmit(); }
				else { send.click(); }
			}
		});

		form.addEventListener('submit', function (event) {
			event.preventDefault();
			var question = input.value.trim();
			if (!question || isSending) { return; }
			sendQuestion(question, input, send, messages);
		});

		renderStoredConversation();
	}

	function appendMessage(container, role, content, isError) {
		var row = createElement('div', 'ksee-chatbot-message is-' + role + (isError ? ' is-error' : ''));
		var bubble = createElement('div', 'ksee-chatbot-bubble');
		var answer;
		if (role === 'assistant' && !isError) {
			answer = extractAnswerActions(content);
			bubble.textContent = answer.content;
		} else {
			bubble.textContent = content;
		}
		row.appendChild(bubble);
		container.appendChild(row);
		if (answer) { appendActions(container, answer.actions); }
		scrollBottom(container);
		return row;
	}

	function appendTyping(container) {
		var row = createElement('div', 'ksee-chatbot-message is-assistant');
		var bubble = createElement('div', 'ksee-chatbot-bubble');
		bubble.innerHTML = '<span class="ksee-chatbot-typing"><span></span><span></span><span></span></span>';
		row.appendChild(bubble);
		container.appendChild(row);
		scrollBottom(container);
		return row;
	}

	function sendQuestion(question, input, send, messages) {
		var priorHistory = conversation.slice(-6).map(function (turn) {
			return { role: turn.role, content: turn.content };
		});
		conversation.push({ role: 'user', content: question });
		appendMessage(messages, 'user', question);
		input.value = '';
		input.style.height = 'auto';
		isSending = true;
		send.disabled = true;
		var typing = appendTyping(messages);
		var body = 'question=' + encodeURIComponent(question) + '&history=' + encodeURIComponent(JSON.stringify(priorHistory));

		window.fetch(contextPath + '/docs/chat', {
			method: 'POST',
			headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
			credentials: 'same-origin',
			body: body
		}).then(function (response) {
			return response.json().then(function (json) {
				if (!response.ok || json.result !== 1) {
					throw new Error(json.message || '답변 요청에 실패했습니다.');
				}
				return json;
			});
		}).then(function (json) {
			typing.remove();
			var turn = { role: 'assistant', content: json.answer };
			conversation.push(turn);
			appendMessage(messages, 'assistant', turn.content, false);
			saveHistory();
		}).catch(function (error) {
			typing.remove();
			appendMessage(messages, 'assistant', error.message || '답변 요청에 실패했습니다.', true);
			saveHistory();
		}).then(function () {
			isSending = false;
			send.disabled = false;
			input.focus();
		});
	}

	function scrollBottom(container) {
		container.scrollTop = container.scrollHeight;
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', buildWidget);
	} else {
		buildWidget();
	}
}());
