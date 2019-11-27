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
						<a href="javascript:void(0)">
							<c:choose>
								<c:when test="${locale.language eq 'en'}">
									${item.title_en }					
								</c:when>
								<c:otherwise>
									${item.title }	
								</c:otherwise>
							</c:choose>
						</a>
					</c:if>
				</c:forEach>
				<ul>
					<c:forEach items="${parents }" var="item">
						<li>
							<a href="<c:url value="${item.url }"/>">
								<c:choose>
									<c:when test="${locale.language eq 'en'}">
										${item.title_en }					
									</c:when>
									<c:otherwise>
										${item.title }	
									</c:otherwise>
								</c:choose>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="dep2">
				<a href="javascript:void(0)">
					<c:choose>
						<c:when test="${locale.language eq 'en'}">
							${curMenu.title_en }					
						</c:when>
						<c:otherwise>
							${curMenu.title }	
						</c:otherwise>
					</c:choose>
				</a>
				<ul>
					<c:forEach items="${children }" var="item">
						<c:if test="${curMenu.parent eq item.parent }">
							<li>
								<a href="<c:url value="${item.url }"/>">
									<c:choose>
										<c:when test="${locale.language eq 'en'}">
											${item.title_en }					
										</c:when>
										<c:otherwise>
											${item.title }	
										</c:otherwise>
									</c:choose>
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>