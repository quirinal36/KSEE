<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap"></c:import>
			<c:import url="/inc/contentsTitle"></c:import>
			<div id="contentsPrint">
				<div class="error_wrap">
					<div>
						<div>
							<strong>404</strong>
							<p>
								페이지의 주소가 잘못되었거나 변경 혹은 삭제되어<br>
								요청하신 페이지를 찾을 수 없습니다.<br>
								입력하신 주소가 정확한지 다시 한번 확인해주시기 바랍니다.
							</p>
							<a href="#" class="bt1">HOME</a>
							<a href="#" onclick="history.back();" class="bt1 on">이전 페이지로 이동</a>
						</div>
					</div>
				</div>
				<div class="error_wrap">
					<div>
						<div>
							<strong>503</strong>
							<p>
								서버에 일시적인 오류가 있습니다.<br>
								문제가 계속 발생하는 경우 관리자에게 문의해주세요.
							</p>
							<a href="#" class="bt1">HOME</a>
							<a href="#" onclick="history.back();" class="bt1 on">이전 페이지로 이동</a>
						</div>
					</div>
				</div>
				<form action="<c:url value="/member/loginProcess"/>" method="POST">
					<!-- 로그인 -->
					<div class="member member_form1 login">
					<div class="paper">
						<dl>
							<dt>아이디</dt>
							<dd>
								<input type="text" placeholder="아이디 입력" class="ipt1" name="loginid">
								<p class="message error">존재하지 않는 아이디입니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>비밀번호</dt>
							<dd>
								<input type="password" placeholder="비밀번호 입력" class="ipt1" name="loginpwd">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
							</dd>
						</dl>
						<input type="hidden" name="loginRedirect" value="<c:url value="/"/>"/>
						<input type="submit" value="로그인" class="bt3 on">
						<div class="bt_wrap">
							<a href="<c:url value="/member/signup"/>">회원가입</a>
							<a href="<c:url value="/member/findId"/>">아이디 찾기</a>
							<a href="<c:url value="/member/findPwd"/>">비밀번호 찾기</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>