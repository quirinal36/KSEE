<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="lnb_wrap">
	<div>
		<div>
			<div class="home"><a href="<c:url value="/"/>">HOME</a></div>
			<div class="dep1">
				<c:forEach items="${parents }" var="item">
					<c:if test="${item.id eq curMenu.parent }">
						<a href="javascript:void(0)">${item.title}</a>
					</c:if>
				</c:forEach>
				<ul>
					<c:forEach items="${parents }" var="item">
						<li><a href="<c:url value="${item.url }"/>">${item.title }</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="dep2">
				<a href="javascript:void(0)">${curMenu.title }</a>
				<ul>
					<c:forEach items="${children }" var="item">
						<c:if test="${curMenu.parent eq item.parent }">
							<li><a href="<c:url value="${item.url }"/>">${item.title }</a></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>