<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/resources/js/symposium.js"/>"></script>
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">

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
				<!-- 타이틀명 : 신청서 보기 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/symposium/apply"/>" id="applyForm">
							<dl>
								<dt>상태</dt>
								<dd>
									<c:choose>
										<c:when test="${apply.status eq 1 }">접수 중</c:when>
										<c:when test="${apply.status eq 2 }">신청 완료</c:when>
										<c:otherwise>신청 취소</c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt>참가자 구분</dt>
								<dd>
									<c:choose>
										<c:when test="${apply.memberType eq 2}">일반</c:when>
										<c:when test="${apply.memberType eq 3}">기업</c:when>
										<c:when test="${apply.memberType eq 4}">학생</c:when>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt>발표자 여부</dt>
								<dd>
									<c:choose>
										<c:when test="${apply.isSpeaker eq 1 }">발표자입니다.</c:when>
										<c:otherwise>발표자가 아닙니다.</c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt>국적</dt>
								<dd>
									<c:choose>
										<c:when test="${apply.national eq 1}">한국</c:when>
										<c:when test="${apply.national eq 2}">중국</c:when>
										<c:otherwise>일본</c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>${apply.username }</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>${apply.classification }</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>${apply.level }</dd>
							</dl>
							<dl>
								<dt>연락처</dt>
								<dd>${su:phone(apply.telephone) }</dd>
							</dl>
							<dl>
								<dt>이메일 주소</dt>
								<dd>${apply.email }@${apply.domain }</dd>
							</dl>
							<c:if test="${apply.fileId gt 0 }">
								<dl>
									<dt>학술대회 초록</dt>
									<dd>
										<a href="<c:url value="/upload/get/${apply.fileId }"/>">${apply.filename }</a>
									</dd>
								</dl>
							</c:if>
							<c:choose>
								<c:when test="${apply.status eq 1 }">
									<!-- 수정 가능할 때 (접수 중) -->
									<div class="bt3_item2">
										<a href="<c:url value="/symposium/apply/edit/${apply.id }"/>" class="bt3 on">신청서 수정</a>
										<a href="<c:url value="/symposium/apply/search"/>" class="bt3">이전 페이지로 이동</a>
									</div>
								</c:when>
								<c:when test="${apply.status eq 2 }">
									<!-- 수정 불가능할 때 (신청 완료 / 신청 취소) -->
									<a href="<c:url value="/symposium/apply/search"/>" class="bt3 on">이전 페이지로 이동</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value="/symposium/apply/search"/>" class="bt3 on">이전 페이지로 이동</a>
								</c:otherwise>
							</c:choose>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>