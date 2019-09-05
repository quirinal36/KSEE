<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<header>
	<div id="header_wrap">
		<div id="header">
			<div>
				<div>
					<h1><a href="<c:url value="/admin/"/>">한국효소공학연구회 관리자</a></h1>
					<ul>
						<li><a href="<c:url value="/"/>">한국효소공학연구회</a></li>
						<li><a href="<c:url value="/j_spring_security_logout"/>">로그아웃</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</header>