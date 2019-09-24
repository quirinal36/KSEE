<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한국효소공학연구회</title>
<c:import url="/inc/head"></c:import>
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
							<div class="item">
								<a href="<c:url value="/symposium/domestic/"/>" style="background: url(/resources/img/temp/10.png);">팝업 제목</a>
							</div>
							<div class="item">
								<a href="<c:url value="/symposium/domestic/"/>" style="background: url(/resources/img/temp/10.png);">팝업 제목</a>
							</div>
						</div>
                    </div>
                    <div class="idx_notice_list">
                        <div class="title">
                            <a href="<c:url value="/group/notice/"/>" class="name">공지사항</a>
                            <a href="<c:url value="/group/notice/"/>" title="더 보기" class="more">더 보기</a>
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
	                                        ${ su:removeTag(item.content) }
	                                        </a>
	                                    </div>
	                                </li>
                            	</c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="idx_board_list">
                        <div class="title">
                            <a href="<c:url value="/group/news/"/>" class="name">관련소식</a>
                            <a href="<c:url value="/group/news/"/>" title="더 보기" class="more">더 보기</a>
                        </div>
                        <div class="list">
                        	<c:forEach items="${newsBoardList }" var="item" begin="0" end="0">
	                            <div class="first">
									<a href="<c:url value="/group/news/view/${item.id }"/>">${item.title }</a>
	                                <span><fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" /></span>
	                            </div>
                            </c:forEach>
                            <ul>
                            	<c:forEach items="${newsBoardList }" var="item" begin="1" end="4">
	                                <li>
										<a href="<c:url value="/group/news/view/${item.id }"/>">${item.title }</a>
	                                    <span><fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" /></span>
	                                </li>
                                </c:forEach>
                                
                            </ul>
                        </div>
					</div>
                    <div class="idx_board_list">
                        <div class="title">
                            <a href="<c:url value="/community/board/"/>" class="name">자유게시판</a>
                            <a href="<c:url value="/community/board/"/>" title="더 보기" class="more">더 보기</a>
                        </div>
						<div class="list">
							<c:forEach items="${freeBoardList }" var="item" begin="0" end="0">
								<div class="first">
									<a href="<c:url value="/community/board/view/${item.id }"/>">${item.title }</a>
									<span>
										<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
									</span>
								</div>
							</c:forEach>
							<ul>
								<c:forEach items="${freeBoardList }" var="item" begin="1" end="4">
									<li>
										<a href="<c:url value="/community/board/view/${item.id }"/>">${item.title }</a>
										<span><fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" /></span>
									</li>
								</c:forEach>
							</ul>
						</div>
                    </div>
                </div>
			</div>
			<div class="idx_banner">
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b1.png"/>" alt="한국생명공학연구원"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b2.png"/>" alt="코오롱생명과학"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b3.png"/>" alt="한국식품연구원"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b4.png"/>" alt="Genofocus"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b5.png"/>" alt="두산"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b6.png"/>" alt="MH2 BIO CHEMICAL"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b7.png"/>" alt="Amicogen"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b8.png"/>" alt="CJ"></a>
				<a href="#" target="_blank"><img src="<c:url value="/resources/img/index/b9.png"/>" alt="AP"></a>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>
