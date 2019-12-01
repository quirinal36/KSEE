<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한국효소공학연구회</title>
<c:import url="/inc/head"></c:import>
<script>
// 모바일 팝업 가로길이

$(document).ready(function(){
	resizePopup();
});

//리사이징 됐을 때
$(window).resize(function(){
	resizePopup();
});

function resizePopup(){
	var popup_width = $(document).width();
	// console.log( popup_width );
	var popup_height = popup_width / 100 * 54 - 5;
	// console.log( popup_height );
	var windowWidth = $( window ).width();
	if(windowWidth <= 800) {
		$(".idx_popup_wrap, .idx_popup_wrap .item a").height( popup_height + "px" );
	}
};
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<div class="idx_intro">
				<div class="title">
					<span>KSEE</span>
					<span>한국효소공학연구회</span>
				</div>
				<div class="text">
					<span>K</span>orean <span>S</span>ociety for <span>E</span>nzyme <span>E</span>ngineering
				</div>
			</div>
			<div class="idx_cont">
            	<div>
                    <div class="idx_popup_wrap">
						<div class="idx_popup">
							<c:forEach items="${popups }" var="item">
								<div class="item">
									<a href="<c:url value="${item.link }"/>" style="background-image: url(<c:url value="${item.url }"/>);">${item.popupTitle }</a>
								</div>
							</c:forEach>
						</div>
                    </div>
                    <div class="idx_notice_list">
                        <div class="title">
                            <a href="<c:url value="/group/notice/"/>" class="name">
                            	<spring:message code="comm.announcements" text="comm.announcements"></spring:message>
                            </a>
                            <a href="<c:url value="/group/notice/"/>" title="<spring:message code="comm.more" text="comm.more"></spring:message>" class="more">
                            	<spring:message code="comm.more" text="comm.more"></spring:message>
                            </a>
                        </div>
                        <div class="list">
                            <ul>
                            	<c:forEach items="${noticeList }" var="item" begin="0" end="2">
	                            	<li>
	                                    <div class="date">
	                                        <strong><fmt:formatDate value="${item.wdate}" pattern="dd" /></strong>
	                                        <span><fmt:formatDate value="${item.wdate}" pattern="yyyy-MM" /></span>
	                                    </div>
	                                    <div class="cont">
	                                        <a href="<c:url value="/group/notice/view/${item.id }"/>" class="title">${item.title }</a><br>
	                                        <a href="<c:url value="/group/notice/view/${item.id }"/>" class="text">
	                                        	<b>이승구</b> ${ su:removeTag(item.content) }
	                                        </a>
	                                    </div>
	                                </li>
                            	</c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="idx_board_list">
                        <div class="title">
                            <a href="<c:url value="/group/news/"/>" class="name">
                            	<spring:message code="comm.relevant_news" text="comm.relevant_news"></spring:message>
                            </a>
                            <a href="<c:url value="/group/news/"/>" title="<spring:message code="comm.more" text="comm.more"></spring:message>" class="more">
                            	<spring:message code="comm.more" text="comm.more"></spring:message>
                            </a>
                        </div>
                        <div class="list">
                        	<c:forEach items="${newsBoardList }" var="item" begin="0" end="0">
	                            <div class="first">
									<a href="<c:url value="/group/news/view/${item.id }"/>">${item.title }</a>
	                                <span>
		                                ${item.writerName }
	                                	<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
	                                </span>
	                            </div>
                            </c:forEach>
                            <ul>
                            	<c:forEach items="${newsBoardList }" var="item" begin="1" end="4">
	                                <li>
										<a href="<c:url value="/group/news/view/${item.id }"/>">${item.title }</a>
	                                    <span>
		                                    ${item.writerName }
	                                    	<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
	                                    </span>
	                                </li>
                                </c:forEach>
                                
                            </ul>
                        </div>
					</div>
                    <div class="idx_board_list">
                        <div class="title">
                            <a href="<c:url value="/group/free/"/>" class="name">
                            	<spring:message code="comm.bulletin_board" text="comm.bulletin_board"></spring:message>
                            </a>
                            <a href="<c:url value="/group/free/"/>" title="<spring:message code="comm.more" text="comm.more"></spring:message>" class="more">
                            	<spring:message code="comm.more" text="comm.more"></spring:message>
                            </a>
                        </div>
						<div class="list">
							<c:forEach items="${freeBoardList }" var="item" begin="0" end="0">
								<div class="first">
									<a href="<c:url value="/group/free/view/${item.id }"/>">${item.title }</a>
									<span>
										${item.writerName }
										<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
									</span>
								</div>
							</c:forEach>
							<ul>
								<c:forEach items="${freeBoardList }" var="item" begin="1" end="4">
									<li>
										<a href="<c:url value="/group/free/view/${item.id }"/>">${item.title }</a>
										<span>
											${item.writerName }
											<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
										</span>
									</li>
								</c:forEach>
							</ul>
						</div>
                    </div>
                </div>
			</div>
			<div class="idx_banner">
				<a href="https://www.kribb.re.kr" target="_blank"><img src="<c:url value="/resources/img/index/b1.png"/>" alt="한국생명공학연구원"></a>
				<a href="https://www.kolonls.co.kr" target="_blank"><img src="<c:url value="/resources/img/index/b2.png"/>" alt="코오롱생명과학"></a>
				<a href="https://www.kfri.re.kr" target="_blank"><img src="<c:url value="/resources/img/index/b3.png"/>" alt="한국식품연구원"></a>
				<a href="https://www.kr.genofocus.com" target="_blank"><img src="<c:url value="/resources/img/index/b4.png"/>" alt="Genofocus"></a>
				<a href="https://www.doosan.com/kr" target="_blank"><img src="<c:url value="/resources/img/index/b5.png"/>" alt="두산"></a>
				<a href="http://www.mh2.co.kr" target="_blank"><img src="<c:url value="/resources/img/index/b6.png"/>" alt="MH2 BIO CHEMICAL"></a>
				<a href="http://www.amicogen.com" target="_blank"><img src="<c:url value="/resources/img/index/b7.png"/>" alt="Amicogen"></a>
				<a href="javascript:void(0);"><img src="<c:url value="/resources/img/index/b8.png"/>" alt="AP"></a>
				<a href="https://www.cj.net" target="_blank"><img src="<c:url value="/resources/img/index/b9.png"/>" alt="CJ"></a>
				<a href="https://www.gist.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b10.png"/>" alt="광주과학기술원"></a>
				<a href="https://www.kaist.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b11.png"/>" alt="한국과학기술원"></a>
				<a href="https://unist-kor.unist.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b12.png"/>" alt="unist"></a>
				<a href="https://www.catholic.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b13.png"/>" alt="가톨릭대학교"></a>
				<a href="https://www.gwnu.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b14.png"/>" alt="강릉원주대학교"></a>
				<a href="https://www.knu.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b15.png"/>" alt="경북대학교"></a>
				<a href="http://www.pusan.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b16.png"/>" alt="부산대학교"></a>
				<a href="https://www.yonsei.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b17.png"/>" alt="연세대학교"></a>
				<a href="http://www.ewha.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b18.png"/>" alt="이화여자대학교"></a>
				<a href="http://www.jnu.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b19.png"/>" alt="전남대학교"></a>
				<a href="http://www.jejunu.ac.kr" target="_blank"><img src="<c:url value="/resources/img/index/b20.png"/>" alt="제주대학교"></a>
				<a href="https://www.krict.re.kr/" target="_blank"><img src="<c:url value="/resources/img/index/b21.png"/>" alt="한국화학연구원"></a>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>
