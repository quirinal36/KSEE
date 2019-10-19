<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<div class="admin_title">팝업 관리</div>
				<table class="tbl1 td_center">
					<thead>
						<tr>
							<th>번호</th>
							<th>팝업 이름</th>
							<th>등록기간</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="item">
							<tr>
								<td>${item.id }</td>
								<td>${item.symposiumTitle }</td>
								<td>${item.startDate } ~ ${item.finishDate }</td>
								<td>
									<input type="button" value="수정" class="bt2 on">
									<input type="button" value="삭제" class="bt2">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="bt_wrap">
					<a href="<c:url value="/popup/insertForm"/>" class="bt1 on">팝업 등록</a>
				</div>
				
				<!-- 여기부터 팝업 수정화면 -->
				<div class="admin_title">팝업 수정</div>
				<table class="tbl1">
					<colgroup>
						<col width="15%">
						<col width="35%">
						<col width="15%">
						<col width="35%">
					</colgroup>
					<tbody>
						<tr>
							<th>팝업 이름</th>
							<td>
								<input type="text" placeholder="팝업 이름 입력" class="w90 ipt2" name="title">
							</td>
							<th>등록기간</th>
							<td>
								<div class="date_chk">
									<input type="hidden" value="" name="startDate">
									<input type="hidden" value="" name="finishDate">
									<input type="text" value=" ~ " class="ipt_date" name="period" readonly="">
									<input type="button" value="2019-10-15 - 2019-10-15" class="bt_date_chk" id="symposium_date_btn">
								</div>
							</td>
						</tr>
					</tbody>
				</table>
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
				<p class="popup_img_guide">팝업 이미지의 사이즈는 624*337이며, 좌우 여백 90px이 확보되어야 합니다.</p>
				<div class="bt_wrap">
					<a href="#" class="bt1 on">수정</a>
					<a href="#" class="bt1">취소</a>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>