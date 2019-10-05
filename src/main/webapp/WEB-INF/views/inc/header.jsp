<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
function search(){
	var query = $(".search_ipt").find("input[name='query']").val();
	var url = $(".search_ipt").find("input[name='search_url']").val();
	
	window.location.replace(url +"?query="+ query);
}
</script>
<header>
	<div id="header_wrap">
		<div class="top_menu">
			<sec:authorize access="isAnonymous()">
				<a href="<c:url value="/member/signup"/>">JOIN</a>
				<a href="<c:url value="/member/login"/>">LOGIN</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a href="<c:url value="/j_spring_security_logout"/>">LOGOUT</a>
				<a href="<c:url value="/member/myinfo"/>">MY INFO</a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a href="<c:url value="/admin/"/>">ADMIN</a>
			</sec:authorize>
			<!-- 
			<a href="#">CONTACT US</a>
			 -->
			 
			<%request.setAttribute("currentUrl", request.getAttribute("javax.servlet.forward.request_uri"));%>
			<a href="<c:url value="${currentUrl }?lang=ko_KR"/>" class="language <c:if test="${locale == 'ko_KR' }">on</c:if>">KOR</a>
			<a href="<c:url value="${currentUrl }?lang=en_US"/>" class="language <c:if test="${locale == 'en_US' }">on</c:if>">ENG</a>
		</div>
		<div id="header">
			<div class="logo">
				<h1><a href="/"><img src="<c:url value="/resources/img/comm/logo.png"/>" alt="한국효소공학연구회"></a></h1>
			</div>
			<div class="gnb_wrap">
				<ul>
					<c:forEach items="${parents}" var="item">
						<li><a href="<c:url value="${item.url }"/>">${item.title }</a></li>
					</c:forEach>
				</ul>
				<div class="gnb_menu">
					<div>
						<div class="image"></div>
						<ul class="dep1">
							<c:forEach items="${parents}" var="pmenu">
								<li>
									<ul class="dep2">
										<c:forEach items="${children }" var="item">
											<c:if test="${pmenu.id eq item.parent}">
												<li><a href="<c:url value="${item.url }"/>">${item.title }</a></li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<input type="button" value="검색" class="bt_header_search">
			<div class="header_search">
				<div class="search_ipt">
					<input type="text" placeholder="검색어를 입력하세요." name="query">
					<input type="hidden" name="search_url" value="<c:url value="/search"/>">
					<input type="button" value="검색" onclick="javascript:search();">
				</div>
				<input type="button" value="닫기" class="bt_header_search_close">
			</div>
		</div>
	</div>
</header>
