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
				<div class="admin_title">학술대회 등록</div>
				<table class="tbl1">
					<colgroup>
						<col width="15%">
						<col width="35%">
						<col width="15%">
						<col width="35%">
					</colgroup>
					<tbody>
						<tr>
							<th>행사명</th>
							<td><input type="text" placeholder="행사명 입력" class="w90 ipt2"></td>
							<th>장소</th>
							<td><input type="text" placeholder="장소 입력" class="w90 ipt2"></td>
						</tr>
						<tr>
							<th>행사기간</th>
							<td>달력</td>
							<th>접수기간</th>
							<td>달력</td>
						</tr>
					</tbody>
				</table>
				<div class="bt_wrap mb-60">
					<a href="#" class="bt1">등록</a>
					<a href="#" class="bt1">수정</a>
					<a href="#" class="bt1">삭제</a>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>