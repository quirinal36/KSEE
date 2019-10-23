<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/list.js"/>"></script>
<script type="text/javascript">

</script>
</head>
<body>
<div id="wrap" class="search_page">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsTitle">
				<div>
					<h2>통합검색</h2>
				</div>
			</div>
			<div class="board_search">
				<div class="search_ipt">
					<form action="<c:url value="/search"/>" method="get">
						<input type="text" name="query" placeholder="검색어를 입력하세요.">
						<input type="submit" value="검색">
					</form>
				</div>
			</div>
			<div id="contentsPrint">
				<div class="search_result_message">
					<c:if test="${not empty paging.query }">
						<p><span>“${paging.query }”</span> 검색 결과입니다.</p>
					</c:if>
				</div>
				<c:forEach items="${boardList }" var="list" varStatus="sts">
					<h2 class="search_title">
						<c:choose>
							<c:when test="${sts.count eq 1}">공지사항</c:when>
							<c:when test="${sts.count eq 2}">관련소식</c:when>
							<c:when test="${sts.count eq 3}">회원동정</c:when>
							<c:when test="${sts.count eq 4}">연사제안</c:when>
							<c:when test="${sts.count eq 5}">자유게시판</c:when>
						</c:choose>
					</h2>
					<div class="board_list board_list_typeB news">
						<ul class="list">
							<li class="head">
								<div class="num">번호</div>
								<div class="title">제목</div>
								<div class="writer">작성자</div>
								<div class="date">작성일</div>
								<div class="file">첨부파일</div>
								<div class="view">조회</div>
							</li>
							<c:choose>
								<c:when test="${fn:length(list) gt 0 }">
									<c:forEach items="${list }" var="item" varStatus="sts">
										<li>
											<div class="num">${item.id }</div>
											<div class="title"><a href="/">${item.title }</a></div>
											<div class="writer">${item.writerName }</div>
											<div class="date"><fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" /></div>
											<div class="file">${item.fileCnt }</div>
											<div class="view">${item.viewCount }</div>
										</li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li class="noItem">
										<div>검색결과가 없습니다.</div>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</c:forEach>
				
				<c:forEach items="${sympList }" var="list" varStatus="sts">
					<h2 class="search_title">
						<c:choose>
							<c:when test="${sts.count eq 1}">국내 학술대회</c:when>
							<c:when test="${sts.count eq 2}">한중일 학술대회</c:when>
						</c:choose>
					</h2>
					<div class="board_list board_list_typeB symposium">
						<ul class="list">
							<li class="head">
								<div class="num">번호</div>
								<div class="title">행사명</div>
								<div class="period">행사기간</div>
								<div class="place">장소</div>
								<div class="apply">참가신청</div>
							</li>
							<c:forEach items="${list }" var="item">
								<c:choose>
									<c:when test="${item.sympType eq 1 }">
										<c:set value="domestic" var="where"/> 
									</c:when>
									<c:otherwise>
										<c:set value="international" var="where"/>
									</c:otherwise>
								</c:choose>
								<li>
									<div class="num">${item.id }</div>
									<div class="title"><a href="<c:url value="/symposium/${where}/view/${item.id }"/>">${item.title }</a></div>
									<div class="period">${item.startDate }(${su:getDayOfWeek(item.startDate)}) ~ ${item.finishDate}(${su:getDayOfWeek(item.finishDate)})</div>
									<div class="place">${item.place }</div>
	                            	<div class="apply"><a href="<c:url value="/symposium/apply"/>" class="bt2 on">참가신청</a></div>
								</li>
							</c:forEach>
							<c:if test="${fn:length(list) eq 0 }">
								<li class="noItem"><div>검색결과가 없습니다.</div></li>
							</c:if>
						</ul>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>