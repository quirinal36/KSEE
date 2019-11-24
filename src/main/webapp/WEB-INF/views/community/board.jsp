<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${curMenu.title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/notice.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/list.js"/>"></script>
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
				<div class="board_search">
					<div class="search_ipt">
						<form action="<c:url value="${listUrl }"/>">
							<input type="text" name="query" placeholder="검색어를 입력하세요." value="${paging.query }" autocomplete="off" />
							<input type="hidden" name="pageNo" value="${paging.pageNo }"/>
							<input type="button" value="검색" onclick="search(this.form);">
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
							<div class="num"><spring:message code="board.number"/></div>
							<div class="title"><spring:message code="board.title"/></div>
							<div class="writer"><spring:message code="board.user"/></div>
							<div class="date"><spring:message code="board.date"/></div>
							<div class="file"><spring:message code="board.attachment"/></div>
							<div class="view"><spring:message code="board.show"/></div>
						</li>
						<c:forEach items="${list }" var="item" varStatus="sts">
							<li>
								<div class="num">${paging.totalCount - (sts.index) - (paging.pageSize * (paging.pageNo-1))}</div>
								<div class="title"><a href="<c:url value="${viewUrl }${item.id }"/>">${item.title }<c:if test="${item.replyCnt > 0 }">(${item.replyCnt })</c:if></a></div>
								<div class="writer">${item.writerName }</div>
								<div class="date">
								<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
								</div>
								<div class="file">${item.fileCnt }</div>
								<div class="view">${item.viewCount }</div>
							</li>
						</c:forEach>
						
					</ul>
					<div class="page">
						<a href="javascript:pageGo(${paging.firstPageNo})" class="bt first">맨 처음 페이지로 가기</a>
						<a href="javascript:pageGo(${paging.prevPageNo})" class="bt prev">이전 페이지로 가기</a>
						<c:choose>
							<c:when test="${paging.finalPageNo eq 0}">
								<a href="javascript:pageGo(1)" class="num on">1</a>
							</c:when>
							<c:otherwise>
								<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo}" varStatus="loop">
									<a href="javascript:pageGo(${loop.current })" class="num <c:if test="${loop.current eq paging.pageNo }">on</c:if>">
									${loop.current }
									</a>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						<a href="javascript:pageGo(${paging.nextPageNo})" class="bt next">다음 페이지로 가기</a>
						<a href="javascript:pageGo(${paging.endPageNo})" class="bt last">마지막 페이지로 가기</a>
					</div>
					<div class="bt_wrap">
						<input type="hidden" name="write_url" value="${writeUrl }">
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