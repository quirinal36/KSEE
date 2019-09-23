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
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
            	<div class="symposium_title_img">
            	<a href="<c:url value="/symposium/domestic/view/8"/>">
            		<img src="/resources/img/contents/2019_symposium.png" alt="2019 심포지엄">
            	</a></div>
				<div class="board_list board_list_typeB symposium">
					<ul class="list">
						<li class="head">
							<div class="num">번호</div>
							<div class="title">행사명</div>
							<div class="period">행사기간</div>
							<div class="place">장소</div>
							<div class="apply">참가신청</div>
						</li>
						<li>
							<div class="num">8</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제8회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/apply"/>" class="bt2 on">참가신청</a></div>
						</li>
						<li>
							<div class="num">7</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제7회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/domestic/view/7"/>" class="bt2">신청대기</a></div>
						</li>
						<li>
							<div class="num">6</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제6회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/domestic/view/6"/>" class="bt2 off">신청종료</a></div>
						</li>
						<li>
							<div class="num">5</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제5회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/domestic/view/5"/>" class="bt2 off">신청종료</a></div>
						</li>
						<li>
							<div class="num">4</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제4회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/domestic/view/4"/>" class="bt2 off">신청종료</a></div>
						</li>
						<li>
							<div class="num">3</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제3회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/domestic/view/3"/>" class="bt2 off">신청종료</a></div>
						</li>
						<li>
							<div class="num">2</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제2회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/domestic/view/2"/>" class="bt2 off">신청종료</a></div>
						</li>
						<li>
							<div class="num">1</div>
							<div class="title"><a href="<c:url value="/symposium/domestic/view/8"/>">제1회 한국효소공학연구회 심포지엄</a></div>
							<div class="period">2019-08-11(월) ~ 2019-08-13(수)</div>
							<div class="place">고성 델피노</div>
                            <div class="apply"><a href="<c:url value="/symposium/domestic/view/1"/>" class="bt2 off">신청종료</a></div>
						</li>
					</ul>
					<!--
					<div class="page">
						<a href="#" class="bt first">맨 처음 페이지로 가기</a>
						<a href="#" class="bt prev">이전 페이지로 가기</a>
						<a href="#" class="num on">1</a>
						<a href="#" class="num">2</a>
						<a href="#" class="num">3</a>
						<a href="#" class="bt next">다음 페이지로 가기</a>
						<a href="#" class="bt last">마지막 페이지로 가기</a>
					</div>
					-->
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>