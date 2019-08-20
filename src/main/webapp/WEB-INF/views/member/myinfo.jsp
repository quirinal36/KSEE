<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap"></c:import>
			<c:import url="/inc/contentsTitle"></c:import>
			<div id="contentsPrint">
				
				<!-- 회원가입 - 내 정보 -->
				<div class="member member_form1">
					<div class="paper">
						<dl>
							<dt>회원구분</dt>
							<dd>학생회원</dd>
						</dl>
						<dl>
							<dt>아이디</dt>
							<dd>withi5</dd>
						</dl>
						<dl>
							<dt>비밀번호</dt>
							<dd><a href="#" class="bt2">비밀번호 변경</a></dd>
						</dl>
						<dl>
							<dt>이름</dt>
							<dd>김한국</dd>
						</dl>
						<dl>
							<dt>휴대전화 번호</dt>
							<dd>01012345678</dd>
						</dl>
						<dl>
							<dt>이메일 주소</dt>
							<dd>aasdfasdfas@gmail.com</dd>
						</dl>
						<dl>
							<dt>소속</dt>
							<dd>한국과학기술원</dd>
						</dl>
						<dl>
							<dt>직위</dt>
							<dd>교수</dd>
						</dl>
						<dl>
							<dt>직장주소</dt>
							<dd>대전광역시 유성구 대학로 291, 생명과학과 3201호(구성동, 한국과학기술원) </dd>
						</dl>
						<input type="button" value="내 정보 수정" class="bt3">
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>