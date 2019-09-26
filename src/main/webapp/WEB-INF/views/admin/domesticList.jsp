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
				<div>
					<div class="admin_title">${title}</div>
					<div class="admin_search">
						<form>
							<input type="text" placeholder="검색어를 입력하세요.">
							<input type="button" value="검색">
						</form>
					</div>
					<div class="admin_sort">
						<a href="#">신청일</a>
						<a href="#">구분</a>
						<a href="#">발표자</a>
						<a href="#">국적</a>
						<a href="#">이름</a>
						<a href="#">소속</a>
						<a href="#">초록</a>
					</div>
					<table class="tbl1 td_center">
						<thead>
							<tr>
								<th>신청일</th>
								<th>구분</th>
								<th>발표자</th>
								<th>국적</th>
								<th>이름</th>
								<th>소속</th>
								<th>직위</th>
								<th>직장주소</th>
								<th>연락처</th>
								<th>이메일 주소</th>
								<th>초록</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>O</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td><a href="#"><img src="/resources/img/contents/board_file_icon.png" alt="다운로드"></a></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>O</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td><a href="#"><img src="/resources/img/contents/board_file_icon.png" alt="다운로드"></a></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>O</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td><a href="#"><img src="/resources/img/contents/board_file_icon.png" alt="다운로드"></a></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>X</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>X</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>X</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>X</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>X</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>O</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td><a href="#"><img src="/resources/img/contents/board_file_icon.png" alt="다운로드"></a></td>
							</tr>
							<tr>
								<td>2019-11-12</td>
								<td>일반</td>
								<td>O</td>
								<td>대한민국</td>
								<td>유단아</td>
								<td>코딩앤플레이 전주지사</td>
								<td>지사장</td>
								<td>전북 전주시 우전로 260</td>
								<td>063-111-1111</td>
								<td>turbolady36@gmail.com</td>
								<td><a href="#"><img src="/resources/img/contents/board_file_icon.png" alt="다운로드"></a></td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="/admin/domestic" class="bt1 on">엑셀파일로 저장</a>
						<a href="/admin/domestic" class="bt1 on">초록 일괄다운로드</a>
						<a href="#" class="bt1">이전</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>