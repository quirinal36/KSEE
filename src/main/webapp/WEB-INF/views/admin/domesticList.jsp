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
			<div>
				<div class="admin_title">신청현황 - 제8회 한국효소공학연구회 심포지엄</div>
				<div class="admin_search">
					<form>
						<input type="text" placeholder="검색어를 입력하세요.">
						<input type="button" value="검색">
					</form>
				</div>
				<table class="tbl1 td_center">
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="20%">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>회원구분</th>
							<th>이름</th>
							<th>소속</th>
							<th>직위</th>
							<th>직장 유선번호</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>학생회원</td>
							<td>유단아</td>
							<td>코딩앤플레이</td>
							<td>팀장</td>
							<td>063-111-1111</td>
						</tr>
						<tr>
							<td>학생회원</td>
							<td>유단아</td>
							<td>코딩앤플레이</td>
							<td>팀장</td>
							<td>063-111-1111</td>
						</tr>
						<tr>
							<td>학생회원</td>
							<td>유단아</td>
							<td>코딩앤플레이</td>
							<td>팀장</td>
							<td>063-111-1111</td>
						</tr>
						<tr>
							<td>학생회원</td>
							<td>유단아</td>
							<td>코딩앤플레이</td>
							<td>팀장</td>
							<td>063-111-1111</td>
						</tr>
					</tbody>
				</table>
				<div class="bt_wrap">
					<a href="#" class="bt1">등록</a>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>