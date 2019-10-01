<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<style>
	
</style>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<!-- 회원 관리 -->
				<div>
					<div class="admin_title">${title }</div>
					<table class="tbl1">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th>회원구분</th>
								<td>${user.role_name_kr }</td>
								<th>가입일</th>
								<td><fmt:formatDate value="${user.mdate}" pattern="yyyy-MM-dd" /></td>
							</tr>
							<tr>
								<th>이름</th>
								<td>${user.username }</td>
								<th>아이디</th>
								<td>${user.login }</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>${su:phone(user.phone) }</td>
								<th>이메일 주소</th>
								<td>${user.email }@${user.domain }</td>
							</tr>
							<tr>
								<th>소속</th>
								<td>${user.classification }</td>
								<th>직위</th>
								<td>${user.level }</td>
							</tr>
							<tr>
								<th>직장 주소</th>
								<td>${user.address } ${user.addressDetail }</td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="<c:url value="/admin/members"/>" class="bt1 on">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>