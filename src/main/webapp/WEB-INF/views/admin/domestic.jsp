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
							<tr>
								<td>제8회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
							<tr>
								<td>제7회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
							<tr>
								<td>제6회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
							<tr>
								<td>제5회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
							<tr>
								<td>제4회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
							<tr>
								<td>제3회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
							<tr>
								<td>제2회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
							<tr>
								<td>제1회 한국효소공학연구회 심포지엄</td>
								<td>2019-08-11(월) ~ 2019-08-13(수)</td>
								<td>고성 델피노</td>
								<td><a href="<c:url value="/admin/domestic/list"/>" class="bt2">신청현황</a></td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="<c:url value="/admin/domestic/write"/>" class="bt1">등록</a>
					</div>
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
					<div class="admin_title">학술대회 상세내용</div>
					<table class="tbl1 mb-60">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th>행사개요</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
								<th>인사말</th>
								<td>
									<a href="#" class="bt2">국문 수정</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
							</tr>
							<tr>
								<th>조직위원회</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
								<th>프로그램</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
							</tr>
							<tr>
								<th>발표요강</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
								<th>등록 및 숙박</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
							</tr>
							<tr>
								<th>투어안내</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
								<th>후원</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
							</tr>
							<tr>
								<th>학회장소 및 교통</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
								<th>문의</th>
								<td>
									<a href="#" class="bt2">국문 작성</a>
									<a href="#" class="bt2">영문 작성</a>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="admin_title">행사개요</div>
					<div style="width: 100%; height: 300px; background: #ddd;">에디터 삽입</div>
					<div class="board_write_img" id="dropzone-img">
						<dl>
							<dt>사진</dt>
							<dd>
								<!-- 사진 목록 -->
								<ul id="picture_ul">
									<!-- 
									<li style="background-image: url(/resources/img/temp/3.png);">
										<input type="button" title="삭제" class="bt_del_img">
									</li>
									 -->
								</ul>
								<!-- 첨부하기 버튼 -->
								<input id="imageupload" type="file" name="files[]" accept="image/*" data-url="/upload/image" multiple="">
							    <div id="progress_img" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
							        <div class="progress-bar" style="width: 0%;"></div>
							    </div>
							</dd>
						</dl>
					</div>
					<div class="bt_wrap mb-60">
						<a href="#" class="bt1 on">등록</a>
						<a href="#" class="bt1 on">수정</a>
						<a href="#" class="bt1">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>