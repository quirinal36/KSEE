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
									<input type="checkbox" id="chk0" class="chk1">
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
						<%--
							<a href="javascript:void(0);" class="bt1" onclick="">선택회원 이메일 발송</a>
							<a href="javascript:void(0);" class="bt1" onclick="">전체회원 이메일 발송</a>
						--%>
						<a href="javascript:void(0);" class="bt1" onclick="javascript:downloadExcel();">전체회원 엑셀파일로 저장</a>
					</div>
					<!-- 메일 보내기 -->
					<div class="mail_wrap">
						<form>
							<table class="tbl1">
								<tbody>
									<tr>
										<th>보내는 사람</th>
										<td>한국효소공학연구회(admin@ksee.kr)</td>
									</tr>
									<tr>
										<th>받는 사람</th>
										<td>유단아(with_i5@nate.com), 유단아(with_i5@naver.com), 유단아(with_i5@daum.net)</td>
									</tr>
									<tr class="title">
										<th>제목</th>
										<td>
											<input type="text" placeholder="제목 입력">
										</td>
									</tr>
									<tr class="cont">
										<td colspan="2">에디터</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td>
											<input type="button" value="파일 등록" class="bt2">
										</td>
									</tr>
								</tbody>
							</table>
							<div class="bt_wrap">
								<a href="#" class="bt1 on">발송</a>
								<a href="#" class="bt1">취소</a>
							</div>
						</form>
					</div>
					<!-- 목록 -->
					<div class="mail_wrap list">
						<table class="tbl1 td_center">
							<colgroup>
								<col width="10%">
								<col width="50%">
								<col width="15%">
								<col width="25%">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>발송인</th>
									<th>발송일시</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>3</td>
									<td><a href="#">KSEE 웹사이트 오픈!</a></td>
									<td>이승구</td>
									<td>2019-12-04 14:31:00</td>
								</tr>
								<tr>
									<td>2</td>
									<td><a href="#">KSEE 웹사이트 오픈!</a></td>
									<td>염수진</td>
									<td>2019-12-04 14:31:00</td>
								</tr>
								<tr>
									<td>1</td>
									<td><a href="#">KSEE 웹사이트 오픈!</a></td>
									<td>이승구</td>
									<td>2019-12-04 14:31:00</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 보낸 메일함 -->
					<div class="mail_wrap">
						<table class="tbl1">
							<tbody>
								<tr>
									<th>보내는 사람</th>
									<td>한국효소공학연구회(admin@ksee.kr)</td>
								</tr>
								<tr>
									<th>받는 사람</th>
									<td>유단아(with_i5@nate.com), 유단아(with_i5@naver.com), 유단아(with_i5@daum.net)</td>
								</tr>
								<tr class="title">
									<th>제목</th>
									<td>한국효소공학연구회입니다.</td>
								</tr>
								<tr class="cont">
									<td colspan="2">안녕하세요. 효소공학연구회입니다.</td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td><a href="파일다운로드링크">인사말.png</a></td>
								</tr>
							</tbody>
						</table>
						<div class="bt_wrap">
							<a href="#" class="bt1 on">목록</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>