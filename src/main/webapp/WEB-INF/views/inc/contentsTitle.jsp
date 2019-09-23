<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="contentsTitle">
	<div>
		<h2>${curMenu.title }</h2>
		<a href="<c:url value="${curMenu.prev.url }"/>" class="prev">${curMenu.prev.title }</a>
		<a href="<c:url value="${curMenu.next.url }"/>" class="next">${curMenu.next.title }</a>
	</div>
</div>