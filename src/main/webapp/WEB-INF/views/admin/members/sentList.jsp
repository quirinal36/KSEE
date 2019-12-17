<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/list.js"/>"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<!-- 목록 -->
				<div class="admin_title">${title }</div>
				<div class="mail_wrap list">
					<table class="tbl1 td_center">
						<colgroup>
							<col width="10%">
							<col width="50%">
							<col width="15%">
							<col width="25%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>발송인</th>
								<th>발송일시</th>
							</tr>
						</thead>
						<tbody>
						<%--
							<tr>
								<td>3</td>
								<td><a href="#">KSEE 웹사이트 오픈!</a></td>
								<td>이승구</td>
								<td>2019-12-04 14:31:00</td>
							</tr>
							<tr>
								<td>2</td>
								<td><a href="#">KSEE 웹사이트 오픈!</a></td>
								<td>염수진</td>
								<td>2019-12-04 14:31:00</td>
							</tr>
							<tr>
								<td>1</td>
								<td><a href="#">KSEE 웹사이트 오픈!</a></td>
								<td>이승구</td>
								<td>2019-12-04 14:31:00</td>
							</tr>
						 --%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>