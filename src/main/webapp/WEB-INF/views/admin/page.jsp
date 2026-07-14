<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<script type="text/javascript">
function edit(key){
	window.location.href = "<c:url value='/admin/page/edit/'/>" + key;
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
				<div class="admin_title">페이지 관리</div>
				<p style="margin:10px 0; color:#666;">
					소개 페이지(인사말·임원진·정관·연혁) 내용을 에디터로 작성하거나 이미지/PDF 파일로 올려 바로 반영할 수 있습니다.
				</p>
				<table class="tbl1 td_center">
					<thead>
						<tr>
							<th>번호</th>
							<th>페이지</th>
							<th>현재 표시 방식</th>
							<th>최근 수정</th>
							<th>편집</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="idx" value="0"/>
						<c:forEach items="${pages }" var="page">
							<c:set var="idx" value="${idx + 1 }"/>
							<c:set var="pc" value="${contents[page.key] }"/>
							<tr>
								<td>${idx }</td>
								<td>${page.value }</td>
								<td>
									<c:choose>
										<c:when test="${not empty pc and pc.viewType eq 'FILE' and not empty pc.fileId}">
											파일 (${pc.fileType })
										</c:when>
										<c:when test="${not empty pc and not empty pc.content}">
											에디터
										</c:when>
										<c:otherwise>
											기본(코드) — 아직 등록 안 됨
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${not empty pc and not empty pc.updatedAt}">
											${pc.updatedAt } <c:if test="${not empty pc.updatedBy}">(${pc.updatedBy })</c:if>
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
								<td>
									<input type="button" value="편집" class="bt2 on" onclick="javascript:edit('${page.key }')">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>
