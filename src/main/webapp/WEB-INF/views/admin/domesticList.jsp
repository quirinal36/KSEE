<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<style>
	
</style>
<script type="text/javascript">
function downloadExcel(sympId){
	window.location.replace("/admin/apply/list/"+sympId+"/excel");
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
				<div>
					<div class="admin_title">${title}</div>
					<div class="admin_search">
						<form action="<c:url value="/admin/apply/list/${sympId }"/>">
							<input type="text" placeholder="검색어를 입력하세요." value="${paging.query }" name="query">
							<input type="submit" value="검색">
						</form>
					</div>
					<div class="admin_sort" style="display:none;">
						<a href="#">신청일</a>
						<a href="#">구분</a>
						<a href="#">발표자</a>
						<a href="#">국적</a>
						<a href="#">이름</a>
						<a href="#">소속</a>
						<a href="#">초록</a>
					</div>
					<table class="tbl1 td_center">
						<thead>
							<tr>
								<th>선택</th>
								<th>상태</th>
								<th>신청일</th>
								<th>구분</th>
								<th>발표자</th>
								<th>국적</th>
								<th>이름</th>
								<th>소속</th>
								<th>직위</th>
								<th>연락처</th>
								<th>이메일 주소</th>
								<th>초록</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${applyList }" var="item">
								<tr>
									<td>
										<input type="checkbox" id="chk1" class="chk1">
										<label for="chk1"></label>
									</td>
									<td>접수 중</td>
									<td><fmt:formatDate value="${item.mdate}" pattern="yyyy-MM-dd" /></td>
									<td>
										<c:choose>
											<c:when test="${item.memberType eq 2 }">일반</c:when>
											<c:when test="${item.memberType eq 3 }">기업</c:when>
											<c:when test="${item.memberType eq 4 }">학생</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.isSpeaker eq 1}">O</c:when>
											<c:otherwise>X</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.national eq 1 }">대한민국</c:when>
											<c:when test="${item.national eq 2 }">중국</c:when>
											<c:when test="${item.national eq 2 }">일본</c:when>
										</c:choose>
									</td>
									<td>${item.username }</td>
									<td>${item.classification }</td>
									<td>${item.level }</td>
									<td>${item.telephone }</td>
									<td>${item.email }@${item.domain }</td>
									<td>
										<c:if test="${item.fileId > 0 }">
											<a href="<c:url value="/upload/get/${item.fileId }"/>">
												<img src="/resources/img/contents/board_file_icon.png" alt="다운로드">
											</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="javascript:void(0);" class="bt1" onclick="">접수 중으로 변경</a>
						<a href="javascript:void(0);" class="bt1 on" onclick="">접수완료로 변경</a>
						<a href="javascript:void(0);" class="bt1" onclick="">신청취소</a>
						<a href="javascript:void(0);" class="bt1" onclick="javascript:downloadExcel('${sympId}');">엑셀파일로 저장</a>
						<a href="javascript:void(0);" class="bt1" onclick="javascript:downloadAllFiles();">초록 일괄다운로드</a>
						<a href="javascript:void(0);" class="bt1" onclick="javascript:history.go(-1)">이전</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>