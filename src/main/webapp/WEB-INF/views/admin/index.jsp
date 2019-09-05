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
	<header>
		<div id="header_wrap">
			<div id="header">
				<div>
					<div>
						<h1><a href="#">한국효소공학연구회 관리자</a></h1>
						<ul>
							<li><a href="#">한국효소공학연구회</a></li>
							<li><a href="#">로그아웃</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</header>
	</header>
	<div id="container_wrap">
		<aside>
			<div id="sidebar">
				<ul>
					<li>
						<a href="#">회원관리</a>
					</li>
					<li class="on">
						<a href="javascript:void(0)">학술대회 관리</a>
						<ul>
							<li><a href="#">국내 학술대회</a></li>
							<li><a href="#">한중일 학술대회</a></li>
						</ul>
					</li>
					<li>
						<a href="#">팝업 관리</a>
						<ul>
							<li><a href="#">신청내역</a></li>
							<li><a href="#">신청내역</a></li>
							<li><a href="#">신청내역</a></li>
							<li><a href="#">신청내역</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</aside>
		<div id="container">
			<!-- 회원관리 -->
			<div>
				<div class="admin_title">회원관리</div>
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
			</div>
			
			<!-- 국내 학술대회 -->
			<div>
				<div class="admin_title">국내 학술대회</div>
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
						<tr>
							<td>제8회 한국효소공학연구회 심포지엄</td>
							<td>2019-08-11(월) ~ 2019-08-13(수)</td>
							<td>고성 델피노</td>
							<td><a href="#" class="bt2">신청현황</a></td>
						</tr>
						<tr>
							<td>제8회 한국효소공학연구회 심포지엄</td>
							<td>2019-08-11(월) ~ 2019-08-13(수)</td>
							<td>고성 델피노</td>
							<td><a href="#" class="bt2">신청현황</a></td>
						</tr>
						<tr>
							<td>제8회 한국효소공학연구회 심포지엄</td>
							<td>2019-08-11(월) ~ 2019-08-13(수)</td>
							<td>고성 델피노</td>
							<td><a href="#" class="bt2">신청현황</a></td>
						</tr>
						<tr>
							<td>제8회 한국효소공학연구회 심포지엄</td>
							<td>2019-08-11(월) ~ 2019-08-13(수)</td>
							<td>고성 델피노</td>
							<td><a href="#" class="bt2">신청현황</a></td>
						</tr>
						<tr>
							<td>제8회 한국효소공학연구회 심포지엄</td>
							<td>2019-08-11(월) ~ 2019-08-13(수)</td>
							<td>고성 델피노</td>
							<td><a href="#" class="bt2">신청현황</a></td>
						</tr>
					</tbody>
				</table>
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