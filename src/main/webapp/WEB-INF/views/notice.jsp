<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한국효소공학연구회</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/fonts/NotoSans.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/layout.css"/>"/>
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
	<div id="header_wrap">
    	<div class="top_line">
        	<div class="left"></div>
        	<div class="right"></div>
        </div>
		<div id="header">
			<div class="logo">
				<h1><a href="/"><img src="<c:url value="/resources/img/comm/logo.png"/>" alt="한국효소공학연구회"></a></h1>
			</div>
			<div class="gnb_wrap">
				<ul>
					<li><a href="/company">연구회소개</a></li>
					<li><a href="/notice">공지사항</a></li>
					<li><a href="/symposium">심포지움</a></li>
					<li><a href="/information">정보광장</a></li>
					<li><a href="/picture">사진뉴스</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="container_wrap">
		<div id="container">
			<h2 class="cont_title notice">공지사항</h2>
			<h3 class="cont_sub_title">NEW &amp; NOTICE</h3>
			<div class="board_search">
				<img src="<c:url value="/resources/img/contents/board_search_icon.png"/>">
				<input type="text" class="검색어 입력">
				<input type="button" value="검색" class="bt1 on">
			</div>
			<div class="board_list">
				<div class="board_list_head">
					<div class="num">번호</div>
					<div class="title">제목</div>
					<div class="writer">작성자</div>
					<div class="date">작성일</div>
				</div>
				<div class="board_list_body">
					<div>
						<div class="num">8</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
					<div>
						<div class="num">7</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
					<div>
						<div class="num">6</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
					<div>
						<div class="num">5</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
					<div>
						<div class="num">4</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
					<div>
						<div class="num">3</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
					<div>
						<div class="num">2</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
					<div>
						<div class="num">1</div>
						<div class="title"><a href="/board/board_view">2019 하계 심포지움 안내</a></div>
						<div class="writer">이승구</div>
						<div class="date">2019-07-08</div>
					</div>
				</div>
			</div>
			<div class="board_list_page">
				<a href="#" class="first">맨 처음 페이지로 가기</a>
				<a href="#" class="prev">이전 페이지로 가기</a>
				<a href="#" class="num on">1</a>
				<a href="#" class="num">2</a>
				<a href="#" class="num">3</a>
				<a href="#" class="next">다음 페이지로 가기</a>
				<a href="#" class="last">마지막 페이지로 가기</a>
				<input type="button" class="bt1 w100 bt_write popup_password_opener" value="글쓰기">
			</div>
		</div>
	</div>
	<div id="footer_wrap">
		<div class="footer">
			<ul>
				<li>사단법인 한국효소공학연구회</li>
				<li>대전광역시 유성구 대학로 291, 생명과학과 3201호(구성동, 한국과학기술원)</li>
				<li>대표이사 : 김학성</li>
			</ul>
			<p>COPYRIGHT <span>KSEE</span>. ALL RIGHTS RESERVED.</p>
		</div>
	</div>
	<!-- 비밀번호 입력 팝업 -->
	<div id="popup_password" class="popup_wrap">
		<div class="bg"></div>
		<div class="v_align_set">
			<div>
				<!-- 팝업 내용 시작 -->
				<div class="popup">
					<strong>비밀번호를 입력하세요.</strong>
					<input type="password" placeholder="비밀번호 입력">
					<a href="/board/board_write" class="bt1 on">확인</a>
					<input type="button" value="닫기" class="bt1 bt_popup_close">
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
