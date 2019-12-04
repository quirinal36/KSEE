<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
					<h2>
						<spring:message code="comm.search_all"/>
					</h2>
				</div>
			</div>
			<div class="board_search">
				<div class="search_ipt">
					<form action="<c:url value="/search"/>" method="get">
						<input type="text" name="query" placeholder="<spring:message code="inc.header.query" text="inc.header.query"/>">
						<input type="submit" value="<spring:message code="comm.search" text="comm.search"/>">
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
							<c:when test="${sts.count eq 1}"><spring:message code="comm.announcements"/></c:when>
							<c:when test="${sts.count eq 2}"><spring:message code="comm.relevant_news"/></c:when>
							<c:when test="${sts.count eq 3}"><spring:message code="comm.member_news"/></c:when>
							<c:when test="${sts.count eq 4}"><spring:message code="comm"/></c:when>
							<c:when test="${sts.count eq 5}"><spring:message code="comm.bulletin_board"/></c:when>
						</c:choose>
					</h2>
					<div class="board_list board_list_typeB news">
						<ul class="list">
							<li class="head">
								<div class="num"><spring:message code="board.number"/></div>
								<div class="title"><spring:message code="board.title"/></div>
								<div class="writer"><spring:message code="board.user"/></div>
								<div class="date"><spring:message code="board.date"/></div>
								<div class="file"><spring:message code="board.attachment"/></div>
								<div class="view"><spring:message code="board.show"/></div>
							</li>
							<c:choose>
								<c:when test="${fn:length(list) gt 0 }">
									<c:forEach items="${list }" var="item" varStatus="sts">
										<li>
											<div class="num">${sts.count }</div>
											<div class="title">
												<a href="/group/${item.boardName_en }/view/${item.id}">
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
							<c:when test="${sts.count eq 1}"><spring:message code="symposium.korean"/></c:when>
							<c:when test="${sts.count eq 2}"><spring:message code="symposium.kcj"/></c:when>
						</c:choose>
					</h2>
					<div class="board_list board_list_typeB symposium">
						<ul class="list">
							<li class="head">
								<div class="num"><spring:message code="symposium.num"/></div>
								<div class="title"><spring:message code="symposium.name_of_event"/></div>
								<div class="period"><spring:message code="symposium.dates"/></div>
								<div class="place"><spring:message code="symposium.place"/></div>
								<div class="apply"><spring:message code="symposium.attendant"/></div>
							</li>
							<c:forEach items="${list }" var="item" varStatus="ists">
								<c:choose>
									<c:when test="${item.sympType eq 1 }">
										<c:set value="domestic" var="where"/> 
									</c:when>
									<c:otherwise>
										<c:set value="international" var="where"/>
									</c:otherwise>
								</c:choose>
								<li>
									<div class="num">${ists.count }</div>
									<div class="title">
										<a href="<c:url value="/symposium/${where}/view/${item.id }"/>">
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
									<div class="period">${item.startDate } ~ ${item.finishDate}</div>
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
							<c:if test="${fn:length(list) eq 0 }">
								<li class="noItem"><div><spring:message code="comm.no_result"/></div></li>
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