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
					<h2><spring:message code="member.myinfo" text="member.myinfo"></spring:message></h2>
				</div>
			</div>
			<div id="contentsPrint">
				
				<!-- 회원가입 - 내 정보 -->
				<div class="member member_form1">
					<div class="paper">
						<dl>
							<dt><spring:message code="member.member_cate" text="member.member_cate"></spring:message></dt>
							<dd>
							<c:choose>
								<c:when test="${user.user_role eq 1 }">
									<spring:message code="member.admin" text="member.admin"></spring:message>
								</c:when>
								<c:when test="${user.user_role eq 2 }">
									<spring:message code="member.student" text="member.student"></spring:message>
								</c:when>
								<c:when test="${user.user_role eq 3 }">
									<spring:message code="member.general" text="member.general"></spring:message>
								</c:when>
								<c:when test="${user.user_role eq 4 }">
									<spring:message code="member.corporate" text="member.corporate"></spring:message>
								</c:when>
							</c:choose>
							</dd>
						</dl>
						<dl>
							<dt><spring:message code="member.id" text="member.id"></spring:message></dt>
							<dd>${user.login }</dd>
						</dl>
						<dl>
							<dt><spring:message code="member.password" text="member.password"></spring:message></dt>
							<dd><a href="<c:url value="/member/newPwd"/>" class="bt2"><spring:message code="member.change_password" text="member.change_password"></spring:message></a></dd>
						</dl>
						<dl>
							<dt><spring:message code="member.name" text="member.name"></spring:message></dt>
							<dd>${user.username }</dd>
						</dl>
						<dl>
							<dt><spring:message code="member.tel" text="member.tel"></spring:message></dt>
							<dd>${user.phone }</dd>
						</dl>
						<dl>
							<dt><spring:message code="member.email" text="member.email"></spring:message></dt>
							<dd>${user.email }@${user.domain }</dd>
						</dl>
						<dl>
							<dt><spring:message code="member.affiliation" text="member.affiliation"></spring:message></dt>
							<dd>${user.classification }</dd>
						</dl>
						<dl>
							<dt><spring:message code="member.position" text="member.position"></spring:message></dt>
							<dd>${user.level }</dd>
						</dl>
						<dl>
							<dt><spring:message code="member.work_address" text="member.work_address"></spring:message></dt>
							<dd>${user.address } ${user.addressDetail }</dd>
						</dl>
						<div class="bt_wrap item2">
							<input type="button" value="<spring:message code="member.edit_my_info" text="member.edit_my_info"></spring:message>" class="bt3 on" onclick="location.replace('<c:url value="/member/edit"/>')">
							<input type="button" value="<spring:message code="member.terminate_membership" text="member.terminate_membership"></spring:message>" class="bt3" onclick="location.replace('<c:url value="/member/delete"/>')"/>
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