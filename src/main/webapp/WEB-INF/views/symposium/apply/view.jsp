<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
								<dt><spring:message code="symposium.apply.view.status"/></dt>
								<dd>
									<c:choose>
										<c:when test="${apply.status eq 1 }"><spring:message code="symposium.apply.view.status_processing"/></c:when>
										<c:when test="${apply.status eq 2 }"><spring:message code="symposium.apply.view.accepted"/></c:when>
										<c:otherwise>신청 취소</c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.apply.view.attendance_type"/></dt>
								<dd>
									<c:choose>
										<c:when test="${apply.memberType eq 2}"><spring:message code="symposium.apply.view.general"/></c:when>
										<c:when test="${apply.memberType eq 3}"><spring:message code="symposium.apply.view.company"/></c:when>
										<c:when test="${apply.memberType eq 4}"><spring:message code="symposium.apply.view.student"/></c:when>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.apply.view.is_speaker"/></dt>
								<dd>
									<c:choose>
										<c:when test="${apply.isSpeaker eq 1 }"><spring:message code="symposium.apply.view.speaker"/></c:when>
										<c:otherwise><spring:message code="symposium.apply.view.no_speaker"/></c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.apply.view.national"/></dt>
								<dd>
									<c:choose>
										<c:when test="${apply.national eq 1}"><spring:message code="symposium.korea"/></c:when>
										<c:when test="${apply.national eq 2}"><spring:message code="symposium.china"/></c:when>
										<c:otherwise><spring:message code="symposium.japan"/></c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.name"/></dt>
								<dd>${apply.username }</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.apply.view.sosok"/></dt>
								<dd>${apply.classification }</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.position"/></dt>
								<dd>${apply.level }</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.tel"/></dt>
								<dd>${su:phone(apply.telephone) }</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.email"/></dt>
								<dd>${apply.email }@${apply.domain }</dd>
							</dl>
							<c:if test="${apply.fileId gt 0 }">
								<dl>
									<dt><spring:message code="symposium.conference_abstract"/></dt>
									<dd>
										<a href="<c:url value="/upload/get/${apply.fileId }"/>">${apply.filename }</a>
									</dd>
								</dl>
							</c:if>
							<c:choose>
								<c:when test="${apply.status eq 1 }">
									<!-- 수정 가능할 때 (접수 중) -->
									<div class="bt3_item2">
										<a href="<c:url value="/symposium/apply/edit/${apply.id }"/>" class="bt3 on">
											<spring:message code="symposium.apply.view.edit_apply"/>
										</a>
										<a href="<c:url value="/symposium/apply/search"/>" class="bt3">
											<spring:message code="symposium.apply.view.prev_page"/>
										</a>
									</div>
								</c:when>
								<c:when test="${apply.status eq 2 }">
									<!-- 수정 불가능할 때 (신청 완료 / 신청 취소) -->
									<a href="<c:url value="/symposium/apply/search"/>" class="bt3 on">
										<spring:message code="symposium.apply.view.prev_page"/>
									</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value="/symposium/apply/search"/>" class="bt3 on">
										<spring:message code="symposium.apply.view.prev_page"/>	
									</a>
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