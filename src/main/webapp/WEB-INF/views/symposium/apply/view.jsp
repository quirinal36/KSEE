<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
								<dd>접수 중 / 신청 완료 / 신청 취소</dd>
							</dl>
							<dl>
								<dt>참가자 구분</dt>
								<dd>일반</dd>
							</dl>
							<dl>
								<dt>발표자 여부</dt>
								<dd>발표자가 아닙니다</dd>
							</dl>
							<dl>
								<dt>국적</dt>
								<dd>대한민국</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>이형구</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>한국효소공학연구회</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>학생</dd>
							</dl>
							<dl>
								<dt>연락처</dt>
								<dd>01056790072</dd>
							</dl>
							<dl>
								<dt>이메일 주소</dt>
								<dd>turboguy@naver.com</dd>
							</dl>
							<dl>
								<dt>학술대회 초록</dt>
								<dd>
									<a href="#">파일명(다운로드 링크)</a>
								</dd>
							</dl>
							<!-- 수정 가능할 때 (접수 중) -->
							<div class="bt3_item2">
								<a href="#" class="bt3 on">신청서 수정</a>
								<a href="#" class="bt3">이전 페이지로 이동</a>
							</div>
							<!-- 수정 불가능할 때 (신청 완료 / 신청 취소) -->
							<a href="#" class="bt3 on">이전 페이지로 이동</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>