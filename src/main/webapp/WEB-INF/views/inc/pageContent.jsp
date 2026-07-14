<%-- 관리자에서 등록한 페이지 내용(DB) 렌더링 조각. 정적 include(<%@ include %>) 로 사용하므로 page 지시문은 두지 않는다. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
	<c:when test="${pageContent.viewType eq 'FILE' and not empty pageContent.fileId}">
		<c:choose>
			<c:when test="${pageContent.fileType eq 'IMAGE'}">
				<div class="page_content_file" style="text-align:center; margin:40px auto;">
					<img src="<c:url value='/picture/${pageContent.fileId}'/>" alt="${title }" style="max-width:100%;">
				</div>
			</c:when>
			<c:otherwise>
				<div class="page_content_file" style="text-align:center; margin:60px auto;">
					<a href="<c:url value='/upload/get/${pageContent.fileId}'/>" target="_blank" class="bt1 on">PDF 문서 보기 / 다운로드</a>
				</div>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<div class="page_content_html">${pageContent.content }</div>
	</c:otherwise>
</c:choose>
