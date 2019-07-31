<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한국효소공학연구회</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/fonts/NotoSans.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/layout.css"/>">
<script>
$(function(){
	// 팝업 닫기
	$(".popup .bt_popup_close").click(function(){
		$(".popup_wrap").fadeOut();
	});
	// 비밀번호 입력 팝업
	$(".popup_password_opener").click(function(){
		$("#popup_password").fadeIn();
	});
});
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<h2 class="cont_title notice">공지사항</h2>
			<div class="board_view">
				<div class="board_view_title">
					<div class="title">2019 하계 중국 심포지움</div>
					<div class="writer">
						<dl>
							<dt>작성자</dt>
							<dd>이승구</dd>
						</dl>
					</div>
					<div class="date">
						<dl>
							<dt>작성일</dt>
							<dd>2019-07-09</dd>
						</dl>
					</div>
				</div>
				<div class="board_view_cont">
					<div class="board_view_img">
						<img src="/img/temp/2.png" alt="게시글 제목">
					</div>
					과학<br>
					보편적인 진리나 법칙의 발견을 목적으로 한 체계적인 지식. 넓은 뜻으로는 학(學)을 이르고, 좁은 뜻으로는 자연 과학을 이른다.
				</div>
				<div class="board_view_file">
					<div class="title">첨부파일</div>
					<div class="file_list">
						<ul>
							<li><a href="#">2019 하계 중국 심포지움 안내파일.hwp</a></li>
							<li><a href="#">2019 하계 중국 심포지움 안내파일.pdf</a></li>
							<li><a href="#">2019 하계 중국 심포지움 안내파일.ppt</a></li>
						</ul>
					</div>
				</div>
				<div class="board_view_bt">
					<a href="/notice.jsp" class="bt1 on w100">목록</a>
					<input type="button" class="bt1 w100 popup_password_opener" value="수정">
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
	<!-- 비밀번호 입력 팝업 -->
	<div id="popup_password" class="popup_wrap">
		<div class="bg"></div>
		<div class="v_align_set">
			<div>
				<!-- 팝업 내용 시작 -->
				<div class="popup">
					<strong>비밀번호를 입력하세요.</strong>
					<input type="password" placeholder="비밀번호 입력">
					<a href="/board_edit.jsp" class="bt1 on">확인</a>
					<input type="button" value="닫기" class="bt1 bt_popup_close">
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
