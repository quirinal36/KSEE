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
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				
				<!-- 회원가입 - 내 정보 -->
				<div class="member member_form1">
					<div class="paper">
						<dl>
							<dt>회원구분</dt>
							<dd>
							<c:choose>
								<c:when test="${user.user_role eq 1 }">
									관리자
								</c:when>
								<c:when test="${user.user_role eq 2 }">
									학생
								</c:when>
								<c:when test="${user.user_role eq 3 }">
									일반
								</c:when>
								<c:when test="${user.user_role eq 4 }">
									기업
								</c:when>
							</c:choose>
							</dd>
						</dl>
						<dl>
							<dt>아이디</dt>
							<dd>${user.login }</dd>
						</dl>
						<dl>
							<dt>비밀번호</dt>
							<dd><a href="<c:url value="/member/newPwd"/>" class="bt2">비밀번호 변경</a></dd>
						</dl>
						<dl>
							<dt>이름</dt>
							<dd>${user.username }</dd>
						</dl>
						<dl>
							<dt>휴대전화 번호</dt>
							<dd>${user.phone }</dd>
						</dl>
						<dl>
							<dt>이메일 주소</dt>
							<dd>${user.email }@${user.domain }</dd>
						</dl>
						<dl>
							<dt>소속</dt>
							<dd>${user.classification }</dd>
						</dl>
						<dl>
							<dt>직위</dt>
							<dd>${user.level }</dd>
						</dl>
						<dl>
							<dt>직장주소</dt>
							<dd>${user.address } ${user.addressDetail }</dd>
						</dl>
						<div class="bt_wrap item2">
							<input type="button" value="내 정보 수정" class="bt3 on" onclick="location.replace('<c:url value="/member/edit"/>')">
							<input type="button" value="탈퇴하기" class="bt3" onclick="location.replace('<c:url value="/member/delete"/>')"/>
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