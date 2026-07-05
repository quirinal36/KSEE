<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/chatbot.css"/>">

<div id="ksee-chatbot" aria-live="polite">
	<button type="button" id="kc-toggle" aria-label="채팅 도우미 열기" title="KSEE 도우미">
		<span class="kc-toggle-icon">💬</span>
	</button>

	<div id="kc-panel" class="kc-hidden" role="dialog" aria-label="KSEE 도우미">
		<div class="kc-header">
			<span class="kc-title">KSEE 도우미</span>
			<button type="button" class="kc-close" id="kc-close" aria-label="닫기">&times;</button>
		</div>

		<div class="kc-messages" id="kc-messages">
			<div class="kc-msg kc-msg-bot">
				<div class="kc-bubble">안녕하세요! 한국효소공학연구회 안내 도우미입니다. 심포지엄 일정, 참가 접수, 게시판 이용 등 궁금한 점을 물어보세요.</div>
			</div>
		</div>

		<div class="kc-disabled-note kc-hidden" id="kc-disabled-note">
			챗봇이 아직 설정되지 않았습니다.
		</div>

		<form class="kc-inputbar" id="kc-form" autocomplete="off">
			<textarea id="kc-text" rows="1" placeholder="메시지를 입력하세요..." maxlength="4000"></textarea>
			<button type="submit" id="kc-send" aria-label="전송">전송</button>
		</form>
	</div>
</div>

<script>
	window.KSEE_CHATBOT = {
		streamUrl: '<c:url value="/chatbot/stream"/>',
		statusUrl: '<c:url value="/chatbot/status"/>',
		isAdmin: ${chatbotIsAdmin == true ? 'true' : 'false'}
	};
</script>
<script type="text/javascript" src="<c:url value="/resources/js/chatbot.js"/>"></script>
