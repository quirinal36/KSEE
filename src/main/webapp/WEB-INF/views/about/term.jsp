<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script>
$(function(){
	if($(".term_bt").length > 0){
		// 정관
		$(".term_bt").click(function(){
			$(this).toggleClass("on");
			$(this).parent().find("+ .content").slideToggle();
		});
	}
});
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<c:choose>
				<c:when test="${not empty pageContent and (not empty pageContent.content or (pageContent.viewType eq 'FILE' and not empty pageContent.fileId))}">
					<%@ include file="/WEB-INF/views/inc/pageContent.jsp" %>
				</c:when>
				<c:otherwise>
					<div class="term_list">
						<c:import url="/inc/term"></c:import>
					</div>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>
