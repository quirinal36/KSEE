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
						<form action="<c:url value="/group/"/>">
							<input type="text" name="query" placeholder="검색어를 입력하세요." value="${paging.query }" autocomplete="off" />
							<input type="hidden" name="pageNo" value="${paging.pageNo }"/>
							<input type="button" value="검색" onclick="search();">
						</form>
					</div>
				</div>
				<div class="search_result_message">
					<c:if test="${not empty paging.query }">
						<p><span>“${paging.query }”</span> 검색 결과입니다.</p>
					</c:if>
				</div>
				<div class="board_list board_list_typeB">
					<ul class="list">
						<li class="head">
							<div class="num">번호</div>
							<div class="title">제목</div>
							<div class="writer">작성자</div>
							<div class="date">작성일</div>
							<div class="file">첨부파일</div>
							<div class="view">조회</div>
						</li>
						<li>
							<div class="num">3</div>
							<div class="title"><a href="<c:url value="/group/notice/view/3"/>">한국효소공학연구회 공지사항입니다.</a></div>
							<div class="writer">이승구</div>
							<div class="date">2019-08-11</div>
							<div class="file">1</div>
							<div class="view">123</div>
						</li>
						<li>
							<div class="num">2</div>
							<div class="title"><a href="<c:url value="/group/notice/view/2"/>">한국효소공학연구회 공지사항입니다.</a></div>
							<div class="writer">이승구</div>
							<div class="date">2019-08-11</div>
							<div class="file">1</div>
							<div class="view">123</div>
						</li>
						<li>
							<div class="num">1</div>
							<div class="title"><a href="<c:url value="/group/notice/view/1"/>">한국효소공학연구회 공지사항입니다.</a></div>
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
					<div class="bt_wrap">
						<input type="hidden" name="write_url" value="/group/notice/write">
						<input type="button" class="bt1 bt_write popup_password_opener" value="글쓰기">
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>