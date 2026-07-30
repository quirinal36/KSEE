<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KSEE 기능 문서</title>
<c:import url="/inc/head"></c:import>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/docs.css"/>">
<script defer src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
<script defer src="<c:url value="/resources/js/docs.js"/>"></script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<main class="docs-shell" data-document="${documentKey}" data-context="${pageContext.request.contextPath}">
		<aside class="docs-navigation" aria-label="기능 문서 목차">
			<a class="docs-home" href="<c:url value="/docs"/>">KSEE 기능 문서</a>
			<nav>
				<c:forEach items="${documents}" var="entry">
					<a href="<c:url value="/docs/${entry.key}"/>" class="<c:if test="${documentKey eq entry.key}">active</c:if>">
						<c:choose>
							<c:when test="${entry.key eq 'overview'}">문서 안내</c:when>
							<c:otherwise>${entry.value}</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</nav>
		</aside>
		<section class="docs-content" aria-live="polite">
			<p class="docs-loading">문서를 불러오는 중입니다.</p>
		</section>
	</main>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>
