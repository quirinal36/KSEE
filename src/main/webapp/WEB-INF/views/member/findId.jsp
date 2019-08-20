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
				<!-- 아이디 찾기 -->
				<div class="member member_form1">
					<div class="paper">
						<dl>
							<dt>이름</dt>
							<dd>
								<input type="text" placeholder="이름 입력" class="ipt1">
								<p class="message error">이름을 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>휴대전화 번호</dt>
							<dd>
								<input type="text" placeholder="휴대전화번호 입력" class="ipt1">
								<p class="message error">휴대전화 번호를 입력하세요.</p>
							</dd>
						</dl>
						<input type="button" value="아이디 찾기" class="bt3 on">
						<div class="result">
							<p>회원님의 아이디는 <span>withi5</span>입니다.</p>
							<div class="bt_wrap">
								<a href="/member/login">로그인</a>
								<a href="/member/findPwd">비밀번호 찾기</a>
							</div>
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