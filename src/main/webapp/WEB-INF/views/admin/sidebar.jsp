<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<aside>
	<div id="sidebar">
		<ul>
			<li <c:if test="${menu eq 0}">class="on"</c:if>>
				<a href="<c:url value="/admin/members/"/>">회원 관리</a>
			</li>
			<li <c:if test="${menu eq 1 or menu eq 2}">class="on"</c:if>>
				<a href="<c:url value="/admin/domestic/"/>">학술대회 관리</a>
				<ul>
					<li><a href="<c:url value="/admin/domestic/"/>">국내 학술대회</a></li>
					<li><a href="<c:url value="/admin/international/"/>">한중일 학술대회</a></li>
				</ul>
			</li>
			<li <c:if test="${menu eq 3}">class="on"</c:if>>
				<a href="<c:url value="/admin/popup/"/>">팝업 관리</a>
			</li>
		</ul>
	</div>
</aside>