<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				<!-- 국내 학술대회 -->
				<div>
					<div class="admin_title">${title }</div>
					<div class="admin_search">
						<form>
							<input type="text" placeholder="검색어를 입력하세요.">
							<input type="button" value="검색">
						</form>
					</div>
					<table class="tbl1 td_center">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="20%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th>행사명</th>
								<th>행사기간</th>
								<th>장소</th>
								<th>신청현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list }" var="item">
								<tr>
									<td>
										<a href="<c:url value="/admin/domestic/detail/${item.id}"/>">
										${item.title }
										</a>
									</td>
									<td>2019-08-11(월) ~ 2019-08-13(수)</td>
									<td>${item.place }</td>
									<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="<c:url value="/admin/domestic/write"/>" class="bt1">등록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>