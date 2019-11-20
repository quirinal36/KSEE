<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<div class="board_view symposium">
					<div class="board_view_title">
						<div class="title">${symposium.title }</div>
						<div class="file">${fn:length(photos) }</div>
						<div class="view">${symposium.viewCnt }</div>
					</div>
					<div class="board_view_tab">
						<div class="tab">
							<ul>
								<c:forEach items="${detailList }" var="item" varStatus="sts">
									<li>
										<a href="<c:url value="/symposium/domestic/view/${item.symposiumId }/${item.stype}"/>" 
											<c:if test="${tab eq item.stype}">class="on"</c:if>>
											<spring:message code="symposium.type.${item.msgKey}" text="symposium.type.${item.msgKey}"></spring:message>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
						
						<div class="cont">
							<c:forEach items="${detailList }" var="item" varStatus="sts">
								<c:if test="${tab eq item.stype}">
									<div class="detail_title">
										<strong><spring:message code="symposium.type.${item.msgKey}" text="symposium.type.${item.msgKey}"></spring:message></strong>
										<p></p>
									</div>
									<div class="detail_cont">
										<div>
											<c:forEach items="${photos }" var="photo">
												<img src="<c:url value="${photo.url }"/>" style="display: block; width: 100%; margin-bottom: 30px;" alt="${photo.name }">
											</c:forEach>
										</div>
										<div>
											${item.content }
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="bt_wrap">
						<fmt:parseDate var="from" value="${symposium.applyStart }" pattern="yyyy-MM-dd"/>
                      	<fmt:parseDate var="to" value="${symposium.applyFinish }" pattern="yyyy-MM-dd"/>
                      	<fmt:parseDate var="now" value="${today }" pattern="yyyy-MM-dd"/>
                      	<c:if test="${now ge from and now le to }">
							<a href="<c:url value="/symposium/apply/${symposium.id }"/>" class="bt1 on">참가신청</a>
						</c:if>
						<a href="<c:url value="/symposium/"/>" class="bt1">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>