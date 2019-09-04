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
            	<div class="symposium_title_img"><a href="#"><img src="/resources/img/contents/2019_symposium2.png" alt="2019 심포지엄"></a></div>
				<!-- 심포지엄 참가신청 - 동의 -->
				<div class="member join_step1">
					<!-- 현재상태 -->
					<div class="location">
						<div class="on">동의</div>
						<div>정보입력</div>
						<div>신청완료</div>
					</div>
					<div class="paper">
						<strong>개인정보처리방침</strong>
						<div class="term"></div>
						<div class="chk_wrap">
							<input type="checkbox" id="term_chk2" class="chk1">
							<label for="term_chk2">동의합니다.</label>
						</div>
						<input type="button" value="다음 단계로" class="bt3 on" onclick="javascript:move(1);">
					</div>
				</div>
				<!-- 심포지엄 참가신청 - 정보 입력 -->
				<div class="member member_form1 join_step2" style="display: block;">
					<!-- 현재상태 -->
					<div class="location">
						<div>동의</div>
						<div class="on">정보입력</div>
						<div>신청완료</div>
					</div>
					<div class="paper">
						<form action="<c:url value="/member/signup"/>" method="post">
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" placeholder="이름 입력" class="ipt1" name="username">
									<p class="message error">이름을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>휴대전화 번호</dt>
								<dd>
									<input type="text" placeholder="휴대전화번호 입력" class="ipt1" name="phone">
									<p class="message error">휴대전화 번호를 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>
									<input type="text" placeholder="소속 입력" class="ipt1" name="classification">
									<p class="message error">소속을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>
									<input type="text" placeholder="직위 입력" class="ipt1" name="level">
									<p class="message error">직위를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="company_address">
								<dt>직장주소</dt>
								<dd>
									<input type="button" value="주소찾기" class="bt2" onclick="javascript:fn_setAddr()">
									<input type="text" placeholder="주소" class="mt-10 ipt1" readonly name="address">
									<input type="text" placeholder="상세주소 입력" class="mt-10 ipt1" name="addressDetail">
									<p class="message error">상세주소가 입력되지 않았습니다.</p>
								</dd>
							</dl>
							<dl class="email">
								<dt>이메일 주소</dt>
								<dd>
									<input type="text" placeholder="이메일 아이디 입력" class="ipt1" name="email">
									<span>@</span>
									<input type="text" placeholder="도메인 입력" class="ipt1" name="domain">
									<p class="message error">이메일 아이디를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="file">
								<dt>학술대회 초록</dt>
								<dd>
									<input type="button" value="등록" class="bt2">
								</dd>
							</dl>
							<input type="button" value="회원가입" class="bt3 on" id="submit">
						</form>
					</div>
				</div>
				<!-- 심포지엄 참가신청 - 신청완료 -->
				<div class="member join_complete">
					<div class="paper">
						환영합니다!<br>
						한국효소공학연구회 회원가입이 완료되었습니다.
						<a href="/" class="bt3 on">HOME</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>