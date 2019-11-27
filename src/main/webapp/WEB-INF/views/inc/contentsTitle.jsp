<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="contentsTitle">
	<div>
		<h2>
			<c:choose>
				<c:when test="${locale.language eq 'en'}">
					${curMenu.title_en }				
				</c:when>
				<c:otherwise>
					${curMenu.title }
				</c:otherwise>
			</c:choose>
		</h2>
		<c:if test="${curMenu.prev.id gt 0}">
			<a href="<c:url value="${curMenu.prev.url }"/>" class="prev">
				<c:choose>
					<c:when test="${locale.language eq 'en'}">
						${curMenu.prev.title_en }				
					</c:when>
					<c:otherwise>
						${curMenu.prev.title }
					</c:otherwise>
				</c:choose>
			</a>
		</c:if>
		<c:if test="${curMenu.next.id gt 0}">
			<a href="<c:url value="${curMenu.next.url }"/>" class="next">
				<c:choose>
					<c:when test="${locale.language eq 'en'}">
						${curMenu.next.title_en }				
					</c:when>
					<c:otherwise>
						${curMenu.next.title }
					</c:otherwise>
				</c:choose>
			</a>
		</c:if>
	</div>
</div>