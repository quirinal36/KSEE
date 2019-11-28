<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
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
            	<div class="symposium_title_img">
	            	<a href="<c:url value="/symposium/domestic/view/8"/>">
	            		<img src="/resources/img/contents/2019_symposium.png" alt="2019 심포지엄">
	            	</a>
            	</div>
				<div class="board_list board_list_typeB symposium">
					<ul class="list">
						<li class="head">
							<div class="num"><spring:message code="symposium.num"/></div>
							<div class="title"><spring:message code="symposium.name_of_event"/></div>
							<div class="period"><spring:message code="symposium.dates"/></div>
							<div class="place"><spring:message code="symposium.place"/></div>
							<div class="apply"><spring:message code="symposium.attendant"/></div>
						</li>
						<c:forEach items="${list }" var="item" varStatus="sts">
							<li>
								<div class="num">${sts.count + (paging.pageNo - 1) * 10}</div>
								<div class="title">
									<a href="<c:url value="/symposium/domestic/view/${item.id }"/>">
										<c:choose>
											<c:when test="${locale.language eq 'en' }">
												${item.title_en }
											</c:when>
											<c:otherwise>
												${item.title }
											</c:otherwise>
										</c:choose>
									</a>
								</div>
								<div class="period">${item.startDate }(${su:getDayOfWeek(item.startDate)}) ~ ${item.finishDate}(${su:getDayOfWeek(item.finishDate)})</div>
								<div class="place">
									<c:choose>
										<c:when test="${locale.language eq 'en' }">
											${item.place_en }
										</c:when>
										<c:otherwise>
											${item.place }
										</c:otherwise>
									</c:choose>
								</div>
	                            <div class="apply">
	                            	<fmt:parseDate var="from" value="${item.applyStart }" pattern="yyyy-MM-dd"/>
	                            	<fmt:parseDate var="to" value="${item.applyFinish }" pattern="yyyy-MM-dd"/>
	                            	<fmt:parseDate var="now" value="${today }" pattern="yyyy-MM-dd"/>
	                            	<c:choose>
	                            		<c:when test="${now ge from and now le to }">
		                            		<a href="<c:url value="/symposium/apply/${item.id }"/>" class="bt2 on"><spring:message code="symposium.attendant"/></a>
		                            	</c:when>
		                            	<c:otherwise>
		                            		
		                            	</c:otherwise>
	                            	</c:choose>
	                            </div>
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
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>