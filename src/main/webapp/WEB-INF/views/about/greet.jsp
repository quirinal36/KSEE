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
				<!-- 회원가입 - 동의 -->
				<div class="member join_step1">
					<div>
						<strong>이용약관</strong>
						<div class="term"></div>
						<div class="chk_wrap">
							<input type="checkbox" id="term_chk1" class="chk1">
							<label for="term_chk1">동의합니다.</label>
						</div>
						<strong>개인정보처리방침</strong>
						<div class="term"></div>
						<div class="chk_wrap">
							<input type="checkbox" id="term_chk2" class="chk1">
							<label for="term_chk2">동의합니다.</label>
						</div>
						<input type="button" value="다음 단계로" class="bt3">
					</div>
				</div>
				<!-- 회원가입 - 정보 입력 -->
				<div class="member member_form1">
					<div>
						<dl class="member_chk">
							<dt>회원구분</dt>
							<dd>
								<ul class="chk_wrap">
									<li>
										<input type="radio" name="member_chk" id="member_chk1" class="radio1">
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
							<dt>아이디</dt>
							<dd>
								<input type="text" placeholder="아이디 입력" class="ipt1">
								<p class="message error">5~20자의 영문 소문자, 숫자만 사용 가능합니다.</p>
								<p class="message error">이미 사용 중인 아이디입니다.</p>
								<p class="message confirm">사용 가능한 아이디입니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>비밀번호</dt>
							<dd>
								<input type="password" placeholder="비밀번호 입력" class="ipt1">
								<p class="message error">6자리 이상 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>비밀번호 확인</dt>
							<dd>
								<input type="password" placeholder="비밀번호 재입력" class="ipt1">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
								<p class="message confirm">비밀번호가 일치합니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>이름</dt>
							<dd>
								<input type="text" placeholder="이름 입력" class="ipt1">
								<p class="message error">이름을 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>휴대전화 번호</dt>
							<dd>
								<input type="text" placeholder="휴대전화번호 입력" class="ipt1">
								<p class="message error">휴대전화 번호를 입력하세요.</p>
							</dd>
						</dl>
						<dl class="email">
							<dt>이메일 주소</dt>
							<dd>
								<input type="text" placeholder="이메일 아이디 입력" class="ipt1">
								<span>@</span>
							 	<input type="text" placeholder="도메인 입력" class="ipt1">
								<p class="message error">이메일 아이디를 입력하세요.</p>
								<p class="message error">도메인을 입력하세요.</p>
								<p class="message error">잘못된 도메인 형식입니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>소속</dt>
							<dd>
								<input type="text" placeholder="소속 입력" class="ipt1">
								<p class="message error">소속을 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>직위</dt>
							<dd>
								<input type="text" placeholder="직위 입력" class="ipt1">
								<p class="message error">직위를 입력하세요.</p>
							</dd>
						</dl>
						<dl class="company_address">
							<dt>직장주소</dt>
							<dd>
								<input type="button" value="주소찾기" class="bt2">
								<input type="text" placeholder="주소" class="mt-10 ipt1" readonly>
								<input type="text" placeholder="상세주소 입력" class="mt-10 ipt1">
								<p class="message error">상세주소가 입력되지 않았습니다.</p>
							</dd>
						</dl>
						<input type="button" value="회원가입" class="bt3">
					</div>
				</div>
				<!-- 로그인 -->
				<div class="member member_form1 login">
					<div>
						<dl>
							<dt>아이디</dt>
							<dd>
								<input type="text" placeholder="아이디 입력" class="ipt1">
								<p class="message error">존재하지 않는 아이디입니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>비밀번호</dt>
							<dd>
								<input type="password" placeholder="비밀번호 입력" class="ipt1">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
							</dd>
						</dl>
						<input type="button" value="로그인" class="bt3">
						<div class="bt_wrap">
							<a href="#">회원가입</a>
							<a href="#">아이디 찾기</a>
							<a href="#">비밀번호 찾기</a>
						</div>
					</div>
				</div>
				<!-- 아이디 찾기 -->
				<div class="member member_form1">
					<div>
						<dl>
							<dt>이름</dt>
							<dd>
								<input type="text" placeholder="이름 입력" class="ipt1">
								<p class="message error">이름을 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>휴대전화 번호</dt>
							<dd>
								<input type="text" placeholder="휴대전화번호 입력" class="ipt1">
								<p class="message error">휴대전화 번호를 입력하세요.</p>
							</dd>
						</dl>
						<input type="button" value="아이디 찾기" class="bt3">
						<div class="result">
							<p>회원님의 아이디는 <span>withi5</span>입니다.</p>
							<div class="bt_wrap">
								<a href="#">로그인</a>
								<a href="#">비밀번호 찾기</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 비밀번호 찾기 -->
				<div class="member member_form1">
					<div>
						<dl>
							<dt>아이디</dt>
							<dd>
								<input type="text" placeholder="아이디 입력" class="ipt1">
								<p class="message error">아이디를 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>이름</dt>
							<dd>
								<input type="text" placeholder="이름 입력" class="ipt1">
								<p class="message error">이름을 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>휴대전화 번호</dt>
							<dd>
								<input type="text" placeholder="휴대전화번호 입력" class="ipt1">
								<p class="message error">휴대전화 번호를 입력하세요.</p>
							</dd>
						</dl>
						<input type="button" value="비밀번호 찾기" class="bt3">
						<div class="result">
							<p>
								회원님의 이메일 주소(with**@d***.***)로<br>
								비밀번호 변경 링크를 보내드렸습니다.<br>
								메일이 오지 않는 경우 스팸/광고메일함을 확인해주세요.
							</p>
							<div class="bt_wrap">
								<a href="#">로그인</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 새 비밀번호 -->
				<div class="member member_form1">
					<div>
						<dl>
							<dt>새 비밀번호</dt>
							<dd>
								<input type="password" placeholder="새 비밀번호 입력" class="ipt1">
								<p class="message error">6자리 이상 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>비밀번호 확인</dt>
							<dd>
								<input type="password" placeholder="비밀번호 재입력" class="ipt1">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
								<p class="message confirm">비밀번호가 일치합니다.</p>
							</dd>
						</dl>
						<input type="button" value="비밀번호 변경" class="bt3">
					</div>
				</div>
				<!-- 회원가입 - 내 정보 -->
				<div class="member member_form1">
					<div>
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
				<!-- 회원가입 - 내 정보 수정 -->
				<div class="member member_form1">
					<div>
						<dl class="member_chk">
							<dt>회원구분</dt>
							<dd>
								<ul class="chk_wrap">
									<li>
										<input type="radio" name="member_chk" id="member_chk1" class="radio1">
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
								<input type="text" placeholder="휴대전화번호 입력" class="ipt1">
								<p class="message error">휴대전화 번호를 입력하세요.</p>
							</dd>
						</dl>
						<dl class="email">
							<dt>이메일 주소</dt>
							<dd>
								<input type="text" placeholder="이메일 아이디 입력" class="ipt1">
								<span>@</span>
							 	<input type="text" placeholder="도메인 입력" class="ipt1">
								<p class="message error">이메일 아이디를 입력하세요.</p>
								<p class="message error">도메인을 입력하세요.</p>
								<p class="message error">잘못된 도메인 형식입니다.</p>
							</dd>
						</dl>
						<dl>
							<dt>소속</dt>
							<dd>
								<input type="text" placeholder="소속 입력" class="ipt1">
								<p class="message error">소속을 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>직위</dt>
							<dd>
								<input type="text" placeholder="직위 입력" class="ipt1">
								<p class="message error">직위를 입력하세요.</p>
							</dd>
						</dl>
						<dl class="company_address">
							<dt>직장주소</dt>
							<dd>
								<input type="button" value="주소찾기" class="bt2">
								<input type="text" placeholder="주소" class="mt-10 ipt1" readonly>
								<input type="text" placeholder="상세주소 입력" class="mt-10 ipt1">
								<p class="message error">상세주소가 입력되지 않았습니다.</p>
							</dd>
						</dl>
						<input type="button" value="수정완료" class="bt3">
					</div>
				</div>
				<!-- 회원탈퇴 -->
				<div class="member join_step1">
					<div>
						<strong>안내사항</strong>
						<div class="term"></div>
						<div class="chk_wrap">
							<input type="checkbox" id="term_chk1" class="chk1">
							<label for="term_chk1">동의합니다.</label>
						</div>
						<dl>
							<dt>비밀번호</dt>
							<dd>
								<input type="password" placeholder="비밀번호 입력" class="ipt1">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
							</dd>
						</dl>
						<input type="button" value="회원탈퇴" class="bt3">
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>