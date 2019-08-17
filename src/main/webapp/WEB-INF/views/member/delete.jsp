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
				
				<!-- 회원탈퇴 -->
				<div class="member join_step1">
					<div>
						<strong>안내사항</strong>
						<div class="term"></div>
						<div class="chk_wrap">
							<input type="checkbox" id="term_chk1" class="chk1">
							<label for="term_chk1">동의합니다.</label>
						</div>
						<dl>
							<dt>비밀번호</dt>
							<dd>
								<input type="password" placeholder="비밀번호 입력" class="ipt1">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
							</dd>
						</dl>
						<input type="button" value="회원탈퇴" class="bt3">
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>