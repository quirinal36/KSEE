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
	
<script type="text/javascript">
$(document).ready(function(){
	$("#chk0").change(function(){
		var isChecked = $(this).is(":checked");
		$(".chk1").each(function(){
			$(this).prop("checked", isChecked);
		});
	});
});

function downloadExcel(){
	window.location.replace("/admin/members/download/excel");
}
function sendMail(){
	var ids = new Array();
	$(".chk1").each(function(){
		if($(this).is(":checked")){
			ids.push($(this).val());
		}
	});
	var param = ids.join(",");
	window.location.replace("/admin/members/mail/write?ids=" + param);
}
function sendMailAll(){
	window.location.replace("/admin/members/mail/write");
}
</script>
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
							<p><span>“${paging.query }”</span></p>
						</c:if>
					</div>
					<table class="tbl1 td_center">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="chk0" class="chk1" value="0">
									<label for="chk0"></label>
								</th>
								<th><a href="javascript:arangeList('user_role')">회원구분</a></th>
								<th><a href="javascript:arangeList('username')">이름</a></th>
								<th><a href="javascript:arangeList('classification')">소속</a></th>
								<th><a href="javascript:arangeList('level')">직위</a></th>
								<th><a href="javascript:arangeList('email')">이메일</a></th>
								<th><a href="javascript:arangeList('mdate')">가입일</a></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${members }" var="item" varStatus="sts">
								<tr>
									<td>
										<input type="checkbox" id="chk${sts.count }" class="chk1" value="${item.id }">
										<label for="chk${sts.count }"></label>
									</td>
									<td>${item.role_name_kr }</td>
									<td><a href="<c:url value="/admin/members/view/${item.id }"/>">${item.username }</a></td>
									<td>${item.classification }</td>
									<td>${item.level }</td>
									<td>${item.email }@${item.domain }</td>
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
						<a href="javascript:sendMail();" class="bt1">선택회원 이메일 발송</a>
						<a href="javascript:sendMailAll();" class="bt1">전체회원 이메일 발송</a>
						<a href="javascript:downloadExcel();" class="bt1">전체회원 엑셀파일로 저장</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>