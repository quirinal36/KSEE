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
				
				<!-- 로그인 -->
				<div class="member member_form1 login">
					<div>
						<dl>
							<dt>아이디</dt>
							<dd>
								<input type="text" placeholder="아이디 입력" class="ipt1">
								<p class="message error">존재하지 않는 아이디입니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>비밀번호</dt>
							<dd>
								<input type="password" placeholder="비밀번호 입력" class="ipt1">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
							</dd>
						</dl>
						<input type="button" value="로그인" class="bt3">
						<div class="bt_wrap">
							<a href="#">회원가입</a>
							<a href="#">아이디 찾기</a>
							<a href="#">비밀번호 찾기</a>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>