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
				<!-- 회원 관리 -->
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
								<td><a href="#">유단아</a></td>
								<td>전북대학교</td>
								<td>학생</td>
								<td>063-111-1111</td>
							</tr>
							<tr>
								<td>학생회원</td>
								<td><a href="#">유단아</a></td>
								<td>전북대학교</td>
								<td>학생</td>
								<td>063-111-1111</td>
							</tr>
							<tr>
								<td>학생회원</td>
								<td><a href="#">유단아</a></td>
								<td>전북대학교</td>
								<td>학생</td>
								<td>063-111-1111</td>
							</tr>
							<tr>
								<td>학생회원</td>
								<td><a href="#">유단아</a></td>
								<td>전북대학교</td>
								<td>학생</td>
								<td>063-111-1111</td>
							</tr>
						</tbody>
					</table>
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
								<td colspan="3">학생회원</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>유단아</td>
								<th>아이디</th>
								<td>withi5</td>
							</tr>
							<tr>
								<th>휴대전화 번호</th>
								<td>01098752564</td>
								<th>이메일 주소</th>
								<td>turbolady36@gmail.com</td>
							</tr>
							<tr>
								<th>소속</th>
								<td>전북대학교</td>
								<th>직위</th>
								<td>학생</td>
							</tr>
							<tr>
								<th>직장 주소</th>
								<td>전라북도 전주시 완산구 우전로 260, 765</td>
								<th>직장 전화번호</th>
								<td>0631112222</td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="/admin/members" class="bt1 on">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>