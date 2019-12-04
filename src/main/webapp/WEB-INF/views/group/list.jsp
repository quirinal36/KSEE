<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% 
pageContext.setAttribute("LF", "\n"); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
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
							<input type="text" name="query" placeholder="<spring:message code="inc.header.query"/>" value="${paging.query }"/>
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
				<div class="board_list board_list_typeA">
					<ul>
						<c:forEach items="${list}" var="item" varStatus="sts">
							<li>
								<a href="<c:url value="${viewUrl }${item.id }"/>">
									<div class="top">
										<span class="num">No. ${paging.totalCount - (sts.index) - (paging.pageSize * (paging.pageNo-1))}</span>
										<span class="file">${item.fileCnt }</span>
										<span class="view">${item.viewCount }</span>
									</div>
									<div class="cont">
										<strong class="title">
											<c:choose>
												<c:when test="${locale.language eq 'en' }">
													${item.title_en }
												</c:when>
												<c:otherwise>
													${item.title }
												</c:otherwise>
											</c:choose>
										</strong>
										<div class="info">
											<span class="writer">${item.writerName }</span>
											<span class="date">
												<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
											</span>
										</div>						   
										<div class="content">
										${item.content }
										</div>
									</div>
								</a>
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
						<sec:authorize access="isAuthenticated()">
							<input type="button" class="bt1 bt_write popup_password_opener" value="<spring:message code="board.write"/>">
						</sec:authorize>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>