<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<header>
	<div id="header_wrap">
		<div class="top_menu">
			<sec:authorize access="isAnonymous()">
				<a href="<c:url value="/member/signup"/>">JOIN</a>
				<a href="<c:url value="/member/login"/>">LOGIN</a>
			</sec:authorize>
			<a href="#">CONTACT US</a>
			<a href="#">ADMIN</a>
			<a href="#" class="language on">KOR</a>
			<a href="#" class="language">ENG</a>
		</div>
		<div id="header">
			<div class="logo">
				<h1><a href="/"><img src="<c:url value="/resources/img/comm/logo.png"/>" alt="한국효소공학연구회"></a></h1>
			</div>
			<div class="gnb_wrap">
				<ul>
					<li><a href="<c:url value="/about/greet"/>">연구회 소개</a></li>
					<li><a href="<c:url value="/group/"/>">학회소식</a></li>
					<li><a href="<c:url value="/symposium/"/>">학술대회</a></li>
					<li><a href="<c:url value="/community/board"/>">커뮤니티</a></li>
				</ul>
				<div class="gnb_menu">
					<div>
						<div class="image"></div>
						<ul class="dep1">
							<li>
								<ul class="dep2">
									<li><a href="<c:url value="/about/greet"/>">인사말</a></li>
									<li><a href="<c:url value="/about/history"/>">연혁</a></li>
									<li><a href="<c:url value="/about/term"/>">정관</a></li>
									<li><a href="<c:url value="/about/member"/>">임원진</a></li>
								</ul>
							</li>
							<li>
								<ul class="dep2">
									<li><a href="<c:url value="/group/notice"/>">공지사항</a></li>
									<li><a href="<c:url value="/group/news"/>">관련소식</a></li>
								</ul>
							</li>
							<li>
								<ul class="dep2">
									<li><a href="<c:url value="/symposium/domestic"/>">국내 학술대회</a></li>
									<li><a href="<c:url value="/symposium/international"/>">한중일 학술대회</a></li>
								</ul>
							</li>
							<li>
								<ul class="dep2">
									<li><a href="<c:url value="/community/board"/>">자유게시판</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<input type="button" value="검색" class="bt_header_search">
			<div class="header_search">
				<div class="search_ipt">
					<input type="text" placeholder="검색어를 입력하세요.">
					<input type="button" value="검색">
				</div>
				<input type="button" value="닫기" class="bt_header_search_close">
			</div>
		</div>
	</div>
</header>