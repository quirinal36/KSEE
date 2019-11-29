<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<!-- 회원 관리 -->
				<div class="board_list">
					<div class="admin_title">${title }</div>
					<div class="admin_search">
						<form action="<c:url value="${listUrl }"/>">
							<input type="text" name="query" placeholder="검색어를 입력하세요." value="${paging.query }"/>
							<input type="hidden" name="pageNo" value="${paging.pageNo }"/>
							<input type="button" value="검색" onclick="search(this.form);">
						</form>
					</div>
					<div class="search_result_message">
						<c:if test="${not empty paging.query }">
							<p><span>“${paging.query }”</span> 검색 결과입니다.</p>
						</c:if>
					</div>
					<table class="tbl1 td_center">
						<thead>
							<tr>
								<th>선택</th>
								<th>회원구분</th>
								<th>이름</th>
								<th>소속</th>
								<th>직위</th>
								<th>이메일</th>
								<th>가입일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${members }" var="item">
								<tr>
									<td>
										<input type="checkbox" id="chk1" class="chk1">
										<label for="chk1"></label>
									</td>
									<td>${item.role_name_kr }</td>
									<td><a href="<c:url value="/admin/members/view/${item.id }"/>">${item.username }</a></td>
									<td>${item.classification }</td>
									<td>${item.level }</td>
									<td>${su:phone(item.phone) }</td>
									<td>
										<fmt:formatDate value="${item.mdate}" pattern="yyyy-MM-dd" />
									</td>
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
						<a href="javascript:void(0);" class="bt1" onclick="">선택회원 이메일 발송</a>
						<a href="javascript:void(0);" class="bt1" onclick="">전체회원 이메일 발송</a>
						<a href="javascript:void(0);" class="bt1" onclick="javascript:downloadExcel('${sympId}');">엑셀파일로 저장</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>