<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="contentsTitle">
	<div>
		<h2>${curMenu.title }</h2>
		<c:if test="${curMenu.prev.id gt 0}">
			<a href="<c:url value="${curMenu.prev.url }"/>" class="prev">${curMenu.prev.title }</a>
		</c:if>
		<c:if test="${curMenu.next.id gt 0}">
			<a href="<c:url value="${curMenu.next.url }"/>" class="next">${curMenu.next.title }</a>
		</c:if>
	</div>
</div>