<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/list.js"/>"></script>
<style>
	
</style>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<!-- 국내 학술대회 -->
				<div class="board_list">
					<div class="admin_title">${title }</div>
					<div class="admin_search">
						<form action="<c:url value="/admin/${where }/"/>">
							<input type="text" placeholder="검색어를 입력하세요." name="query" value="${paging.query }">
							<input type="submit" value="검색">
						</form>
					</div>
					<table class="tbl1 td_center">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="20%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th>행사명</th>
								<th>행사기간</th>
								<th>장소</th>
								<th>신청현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list }" var="item">
								<tr>
									<td>
										<a href="<c:url value="/admin/${where }/detail/${item.id}"/>">
										${item.title }
										</a>
									</td>
									<td>${item.startDate }(${su:getDayOfWeek(item.startDate)}) ~ ${item.finishDate}(${su:getDayOfWeek(item.finishDate)})</td>
									<td>${item.place }</td>
									<td><a href="<c:url value="/admin/apply/list/${item.id }"/>" class="bt2">신청현황</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
						<a href="<c:url value="/admin/${where }/write"/>" class="bt1 on">등록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>