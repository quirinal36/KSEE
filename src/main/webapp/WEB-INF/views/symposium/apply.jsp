<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/resources/js/symposium.js"/>"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<title>${title }</title>
<c:import url="/inc/head"></c:import>
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
            	
				<!-- 심포지엄 참가신청 - 동의 -->
				<div class="member form_step1">
					<!-- 현재상태 -->
					<div class="location">
						<div class="on">안내사항</div>
						<div>정보입력</div>
						<div>신청완료</div>
					</div>
					<div class="paper">
						<strong>개인정보처리방침</strong>
						<div class="term"></div>
						<div class="chk_wrap">
							<input type="checkbox" id="term_chk1" class="chk1">
							<label for="term_chk1">동의합니다.</label>
						</div>
						<input type="button" value="다음 단계로" class="bt3 on" onclick="javascript:move(1);">
					</div>
				</div>
				
				<!-- 심포지엄 참가신청 - 정보 입력 -->
				<div class="member member_form1 form_step2" style="display: none;">
					<!-- 현재상태 -->
					<div class="location">
						<div>동의</div>
						<div class="on">정보입력</div>
						<div>신청완료</div>
					</div>
					<div class="paper">
						<form action="<c:url value="/member/signup"/>" method="post">
							<dl class="member_chk">
								<dt>참가자 구분</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="user_role" id="member_chk1" class="radio1" value="2" checked="">
											<label for="member_chk1">일반</label>
										</li>
										<li>
											<input type="radio" name="user_role" id="member_chk2" class="radio1" value="3">
											<label for="member_chk2">기업</label>
										</li>
										<li>
											<input type="radio" name="user_role" id="member_chk3" class="radio1" value="4">
											<label for="member_chk3">학생</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt>발표자 여부</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="user_role" id="member_chk1" class="radio1" value="2">
											<label for="member_chk1">발표자입니다</label>
										</li>
										<li>
											<input type="radio" name="user_role" id="member_chk2" class="radio1" value="3" checked="">
											<label for="member_chk2">발표자가 아닙니다</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt>국적</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="user_role" id="member_chk1" class="radio1" value="2" checked="">
											<label for="member_chk1">대한민국</label>
										</li>
										<li>
											<input type="radio" name="user_role" id="member_chk2" class="radio1" value="3">
											<label for="member_chk2">중국</label>
										</li>
										<li>
											<input type="radio" name="user_role" id="member_chk3" class="radio1" value="4">
											<label for="member_chk3">일본</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" placeholder="이름 입력" class="ipt1" name="username" autocomplete="off">
									<p class="message error">이름을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>
									<input type="text" placeholder="소속 입력" class="ipt1" name="classification" autocomplete="off">
									<p class="message error">소속을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>
									<input type="text" placeholder="직위 입력" class="ipt1" name="level" autocomplete="off">
									<p class="message error">직위를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="company_address">
								<dt>직장주소</dt>
								<dd>
									<input type="button" value="주소찾기" class="bt2" onclick="javascript:fn_setAddr()">
									<input type="text" placeholder="주소" class="mt-10 ipt1" readonly name="address">
									<input type="text" placeholder="상세주소 입력" class="mt-10 ipt1" name="addressDetail" autocomplete="off">
									<p class="message error">상세주소가 입력되지 않았습니다.</p>
								</dd>
							</dl>
							<dl class="company_tel">
								<dt>연락</dt>
								<dd>
									<input type="text" placeholder="직장 유선번호" class="ipt1" name="telephone" autocomplete="off">
								</dd>
							</dl>
							<dl class="email">
								<dt>이메일 주소</dt>
								<dd>
									<input type="text" placeholder="이메일 아이디 입력" class="ipt1" name="email" autocomplete="off">
									<span>@</span>
									<input type="text" placeholder="도메인 입력" class="ipt1" name="domain" autocomplete="off">
									<p class="message error">이메일 아이디를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="file">
								<dt>학술대회 초록</dt>
								<dd>
									<input type="button" value="등록" class="bt2">
								</dd>
							</dl>
							<input type="button" value="신청서 제출" class="bt3 on" id="submit" onclick="javascript:move(2);">
						</form>
					</div>
				</div>
				<!-- 심포지엄 참가신청 - 신청완료 -->
				<div class="member form_complete">
					<div class="paper">
						참가신청이 완료되었습니다.<br>						
						<a href="<c:url value="/"/>" class="bt3 on">HOME</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>