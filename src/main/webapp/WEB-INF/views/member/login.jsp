<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
			<div id="contentsTitle">
				<div>
					<h2><spring:message code="member.login" text="member.login"></spring:message></h2>
				</div>
			</div>
			<div id="contentsPrint">
				<form action="<c:url value="/member/loginProcess"/>" method="POST">
					<!-- 로그인 -->
					<div class="member member_form1 login">
						<div class="paper">
							<dl>
								<dt><spring:message code="member.id" text="member.id"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.id" text="member.id"></spring:message>" class="ipt1" name="loginid" value="${loginid }" autocomplete="off">
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.password" text="member.password"></spring:message></dt>
								<dd>
									<input type="password" placeholder="<spring:message code="member.password" text="member.password"></spring:message>" class="ipt1" name="loginpwd" autocomplete="off">
								</dd>
							</dl>
							
							<p class="message error" <c:if test="${not empty securityexceptionmsg }">style="display:block"</c:if>>${securityexceptionmsg }</p>
							<input type="hidden" name="loginRedirect" value="${loginRedirect}"/>
							<input type="submit" value="<spring:message code="member.login" text="member.login"></spring:message>" class="bt3 on">
							<div class="bt_wrap">
								<a href="<c:url value="/member/signup"/>"><spring:message code="member.member_registration" text="member.member_registration"></spring:message></a>
								<a href="<c:url value="/member/findId"/>"><spring:message code="member.find_id" text="member.find_id"></spring:message></a>
								<a href="<c:url value="/member/findPwd"/>"><spring:message code="member.find_password" text="member.find_password"></spring:message></a>
							</div>
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