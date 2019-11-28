<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="<c:url value="/resources/js/jquery.i18n.properties.js"/>" type="text/javascript"></script>
<script type="text/javascript">
function searchAll(){
	var query = $(".search_ipt_all").find("input[name='query']").val();
	var url = $(".search_ipt_all").find("input[name='search_url']").val();
	
	window.location.replace(url +"?query="+ encodeURI(query));
}
$(document).ready(function(){
	$(".search_ipt_all").find("input[name='query']").keyup(function(e){
		if(e.keyCode == 13){
			searchAll();
		}
	});
	
	jQuery.i18n.properties({
  		name: 'messages', 
  		path:'/properties',
  		mode:'map',
  		language:"${locale}",
  		callback: function(){ 
  			
  		}
	});
	
	// mobile gnb
	$(".gnb_m_opener").click(function(){
		$(".gnb_m_menu").fadeIn();
	});
	$(".gnb_m_close").click(function(){
		$(".gnb_m_menu").fadeOut();
	});
	
	$(".gnb_m_menu .dep1 > li > a").click(function(){
		$(".gnb_m_menu .dep1 > li > a").removeClass("on");
		$(this).addClass("on");
		$(".gnb_m_menu .dep1 > li > ul").hide();
		$(this).find("+ ul").slideDown();
	});
	
});
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
				<div class="gnb_menu">
					<div>
						<div class="image"></div>
						<ul class="dep1">
							<c:forEach items="${parents}" var="pmenu">
								<li>
									<ul class="dep2">
										<c:forEach items="${children }" var="item">
											<c:if test="${pmenu.id eq item.parent}">
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
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<div class="gnb_m_wrap">
				<input type="button" class="gnb_m_opener" value="메뉴 열">
				<div class="gnb_m_menu">
					<div class="bg"></div>
					<div class="menu_area">
						<div class="top">
							<a href="/" class="logo"><img src="<c:url value="/resources/img/comm/logo.png"/>" alt="한국효소공학연구회"></a>
							<input type="button" class="gnb_m_close" value="메뉴 닫기">
						</div>
						<ul class="dep1">
							<c:forEach items="${parents }" var="pmenu">
							<li>
								<a href="javascript:void(0);">
									<c:choose>
										<c:when test="${locale.language eq 'en'}">
											${pmenu.title_en }			
										</c:when>
										<c:otherwise>
											${pmenu.title }
										</c:otherwise>
									</c:choose>
								</a>
								<ul class="dep2">
									<c:forEach items="${children }" var="item">
										<c:if test="${pmenu.id eq item.parent}">
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
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<input type="button" value="검색" class="bt_header_search">
			<div class="header_search">
				<div class="search_ipt_all">
					<input type="text" placeholder="<spring:message code="inc.header.query" text="inc.header.query"/>" name="query">
					<input type="hidden" name="search_url" value="<c:url value="/search"/>">
					<input type="button" value="<spring:message code="inc.header.search" text="inc.header.search"/>" onclick="javascript:searchAll();">
				</div>
				<input type="button" value="닫기" class="bt_header_search_close">
			</div>
		</div>
	</div>
</header>
