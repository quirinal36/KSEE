<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap"></c:import>
			<c:import url="/inc/contentsTitle"></c:import>
			<div id="contentsPrint">
				<div class="board_search">
					<div class="search_ipt">
						<input type="text" placeholder="검색어를 입력하세요.">
						<input type="button" value="검색">
					</div>
				</div>
				<div class="search_result_message">
					<p><span>“연구회”</span> 검색 결과입니다.</p>
				</div>
				<div class="board_list board_list_typeB news">
					<ul class="list">
						<li class="head">
							<div class="num">번호</div>
							<div class="category">구분</div>
							<div class="title">제목</div>
							<div class="writer">작성자</div>
							<div class="date">작성일</div>
							<div class="file">첨부파일</div>
							<div class="view">조회</div>
						</li>
						<li>
							<div class="num">5</div>
							<div class="category">공지사항</div>
							<div class="title"><a href="#">한국효소공학연구회 공지사항입니다.</a></div>
							<div class="writer">이승구</div>
							<div class="date">2019-08-11</div>
							<div class="file">1</div>
							<div class="view">123</div>
						</li>
						<li>
							<div class="num">4</div>
							<div class="category">관련소식</div>
							<div class="title"><a href="#">한국효소공학연구회 공지사항입니다.</a></div>
							<div class="writer">이승구</div>
							<div class="date">2019-08-11</div>
							<div class="file">1</div>
							<div class="view">123</div>
						</li>
						<li>
							<div class="num">3</div>
							<div class="category">공지사항</div>
							<div class="title"><a href="#">한국효소공학연구회 공지사항입니다.</a></div>
							<div class="writer">이승구</div>
							<div class="date">2019-08-11</div>
							<div class="file">1</div>
							<div class="view">123</div>
						</li>
						<li>
							<div class="num">2</div>
							<div class="category">관련소식</div>
							<div class="title"><a href="#">한국효소공학연구회 공지사항입니다.</a></div>
							<div class="writer">이승구</div>
							<div class="date">2019-08-11</div>
							<div class="file">1</div>
							<div class="view">123</div>
						</li>
						<li>
							<div class="num">1</div>
							<div class="category">공지사항</div>
							<div class="title"><a href="#">한국효소공학연구회 공지사항입니다.</a></div>
							<div class="writer">이승구</div>
							<div class="date">2019-08-11</div>
							<div class="file">1</div>
							<div class="view">123</div>
						</li>
					</ul>
					<div class="page">
						<a href="#" class="bt first">맨 처음 페이지로 가기</a>
						<a href="#" class="bt prev">이전 페이지로 가기</a>
						<a href="#" class="num on">1</a>
						<a href="#" class="num">2</a>
						<a href="#" class="num">3</a>
						<a href="#" class="bt next">다음 페이지로 가기</a>
						<a href="#" class="bt last">마지막 페이지로 가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>