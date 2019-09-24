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
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<!-- 회원가입 - 내 정보 수정 -->
				<div class="member member_form1">
					<div class="paper">
						<dl class="member_chk">
							<dt>회원구분</dt>
							<dd>
								<ul class="chk_wrap">
									<li>
										<input type="radio" name="member_chk" id="member_chk1" class="radio1" checked>
										<label for="member_chk1">학생회원</label>
									</li>
									<li>
										<input type="radio" name="member_chk" id="member_chk2" class="radio1">
										<label for="member_chk2">정회원(교수)</label>
									</li>
									<li>
										<input type="radio" name="member_chk" id="member_chk3" class="radio1">
										<label for="member_chk3">정회원(기업)</label>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>휴대전화 번호</dt>
							<dd>
								<input type="text" placeholder="휴대전화번호 입력" value="${user.phone }" class="ipt1">
								<p class="message error">휴대전화 번호를 입력하세요.</p>
							</dd>
						</dl>
						<dl class="email">
							<dt>이메일 주소</dt>
							<dd>
								<input type="text" placeholder="이메일 아이디 입력" value="${user.email }" class="ipt1">
								<span>@</span>
							 	<input type="text" placeholder="도메인 입력" value="gmail.com" class="ipt1">
								<p class="message error">이메일 아이디를 입력하세요.</p>
								<p class="message error">도메인을 입력하세요.</p>
								<p class="message error">잘못된 도메인 형식입니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>소속</dt>
							<dd>
								<input type="text" placeholder="소속 입력" value="${user.classification }" class="ipt1">
								<p class="message error">소속을 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>직위</dt>
							<dd>
								<input type="text" placeholder="직위 입력" value="${user.level }" class="ipt1">
								<p class="message error">직위를 입력하세요.</p>
							</dd>
						</dl>
						<dl class="company_address">
							<dt>직장주소</dt>
							<dd>
								<input type="button" value="주소찾기" class="bt2">
								<input type="text" placeholder="주소" value="전북 전주시 완산구 우전로 260" class="mt-10 ipt1" readonly>
								<input type="text" placeholder="상세주소 입력" value="세움펠리피아 오피스텔 765호" class="mt-10 ipt1">
								<p class="message error">상세주소가 입력되지 않았습니다.</p>
							</dd>
						</dl>
						<input type="button" value="수정완료" class="bt3 on">
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>