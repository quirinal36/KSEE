<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="lnb_wrap">
	<div>
		<div class="home"><a href="/">HOME</a></div>
		<div class="dep1">
			<a href="javascript:void(0)">연구회 소개</a>
			<ul>
				<li><a href="<c:url value="/about/greet"/>">연구회 소개</a></li>
				<li><a href="<c:url value="/group/"/>">학회소식</a></li>
				<li><a href="<c:url value="/symposium/"/>">학술대회</a></li>
				<li><a href="<c:url value="/community/board"/>">커뮤니티</a></li>
			</ul>
		</div>
		<div class="dep2">
			<a href="javascript:void(0)">인사말</a>
			<ul>
				<li><a href="<c:url value="/about/greet"/>">인사말</a></li>
				<li><a href="<c:url value="/about/history"/>">연혁</a></li>
				<li><a href="<c:url value="/about/term"/>">정관</a></li>
				<li><a href="<c:url value="/about/member"/>">임원진</a></li>
			</ul>
		</div>
	</div>
</div>