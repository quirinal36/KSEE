<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="contentsTitle">
	<div>
		<h2>${title }</h2>
		<a href="<c:url value="/about/member"/>" class="prev">임원진</a>
		<a href="<c:url value="/about/term"/>" class="next">정관</a>
	</div>
</div>