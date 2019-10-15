<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script src="<c:url value="/resources/js/signup.js"/>"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript">
var afterSignup = parseInt('${fn:length(afterSignup )}');
var signupComplete = false;
signupComplete = (afterSignup > 0);

$(document).ready(function(){
	$("#submit").on('click', function(){
		var result = validate($("form").serializeArray());
		if(result == true){
			if(jscd.browser.indexOf('msie') != -1  ){
				if(confirm("회원가입 하시겠습니까?")){
					submitSignup();
				}
			}else{
				swal({
					text : "회원가입 하시겠습니까?",
					showCancelButton: true,
					focusConfirm: true,
					confirmButtonText: "확인",
					cancelButtonText: "취소",
					animation: false
				}).then(function(result){
					if(result.value){
						submitSignup();
					}
				});
			}
		}
	});
	function submitSignup(){
		var url = $("form").attr("action");
		var param = $("form").serialize();
		
		$.ajax({
			url : url,
			data: param,
			type: 'POST',
			dataType: 'json'
		}).done(function(json){
			if(json.result > 0){
				signupComplete = true;
				
				if(jscd.browser.indexOf('msie') != -1  ){
					if(confirm("가입 완료되었습니다.")){
						move(2);
					}
				}else{
					swal({
						text : "가입 완료되었습니다.",
						showCancelButton: false,
						focusConfirm: true,
						confirmButtonText: "확인",
						animation: false
					}).then(function(result){
						if(result.value){
							move(2);
						}
					});
				}
			}
		}).fail(function(xhr, status, error){
			
		}).always(function(xhr, status){
			
		});
	}
});

$(window).on("beforeunload", function(){
	
	if(!signupComplete){
		var msg = "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
		return msg;		
	}
});
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
				<c:choose>
					<c:when test="${fn:length(afterSignup ) eq 0}">
						<!-- 회원가입 - 동의 -->
						<div class="member form_step1">
							<!-- 현재상태 -->
							<div class="location">
								<div class="on">약관동의</div>
								<div>정보입력</div>
								<div>가입완료</div>
							</div>
							<div class="paper">
								<strong>정관</strong>
								<div class="term">
									<div class="item">
										<div class="title">
											<strong>제1장 총칙</strong>
										</div>
										<div class="content">
											<strong>제1조 (명칭)</strong>
											<p>본 법인은 『 사단법인 한국효소공학연구회 』라 칭한다.</p>
											<strong>제2조 (목적)</strong>
											<p>본 법인은 국내 효소공학 및 단백질공학 분야에서 학연산에 종사하고 있는 연구자들이 모여 최신의 효소공학관련 정보, 기술을 발표를 통하여 공유하고, 연구자간의 교제를 통하여 결과적으로 효소공학 분야의 학문적, 기술적 발전을 목적으로 한다.</p>
											<strong>제3조 (사업)</strong>
											<p>
												본 법인은 제2조의 목적을 달성하기 위하여 다음 각 호의 사업을 수행한다.<br>
												1. 효소공학 및 단백질공학 분야의 최신 정보 및 기술을 습득<br>
												2. 효소공학 및 단백질공학 분야의 인적교류 확대<br>
												3. 효소공학 및 단백질공학 분야의 국제적 경쟁력 증진<br> 
												4. 효소공학 및 단백질공학 분야의 연구수준 및 산업의 경쟁력 증진<br>
												5. 기타 이 법인의 목적을 수행하기 위한 사업
											</p>
											<strong>제4조 (사무소의 소재지)</strong>
											<p>본 법인의 주사무소는 『대전광역시 유성구 대학로 291 번지 생명과학과 3201호』에 두며 필요에 따라 이사장의 발의와 이사회의 결의로 타 지역으로 이전할 수 있다.</p>
										</div>
									</div>
									<div class="item">
										<div class="title">
											<strong>제2장 회원 및 임원</strong>
										</div>
										<div class="content">
											<strong>제5조 (회원의 자격)</strong>
											<p>
												① 본 법인의 회원은 다음 2종으로 한다.<br>
												　 1) 정회원 : 본 법인의 설립취지에 동의하고 소정의 가입을 한 자.<br>
												　 2) 학생회원 : 박사과정 및 석사과정 학생신분으로 소정의 가입을 한 자.<br>
												② 본 법인의 회원으로 가입하고자 하는 자는 소정의 가입신청서를 제출하여 이사회의 승인을 얻어야 하며, 학생회원에 한하여는 의결권을 부여하지 않는다.
											</p>
											<strong>제6조 (회원의 권리와 의무)</strong>
											<p>
												① 회원은 총회를 통하여 이 법인의 운영에 참여하되, 정회원은 발의권과 의결권, 피선거권을 가지나 학생회원은 발의권만 갖는다.<br>
												② 회원은 본 법인의 정관, 규정 및 각종 회의의 의결사항을 준수하고 회비 및 제 부담금을 납부할 의무를 진다.
											</p>
											<strong>제7조 (회원의 탈퇴 및 제명)</strong>
											<p>
												① 회원은 본인의 의사에 따라 자유롭게 탈퇴할 수 있다.<br>
												② 회원이 다음 각호의 사유에 해당될 경우에는 이사회의 의결을 거쳐 제명할 수 있다.<br>
												　 1. 본회의 명예를 손상시키고 목적수행에 지장을 초래한 경우<br>
												　 2. 1년 이상 회원의 의무를 준수하지 않는 자<br>
												③ 탈퇴 및 제명으로 인하여 회원의 자격을 상실한 경우에는 납부한 회비 등에 대한 권리를 요구할 수 없다.
											</p>
											<strong>제8조 (임원의 종류 및 원수)</strong>
											<p>
												① 본 법인은 다음의 임원을 둔다.<br>
												　 1. 이사장 1인<br>
												　 2. 이사(이사장 포함) 5인 이상 10인 이하<br>
												　 3. 감사 1인
											</p>
											<strong>제9조 (임원의 선임)</strong>
											<p>
												① 본 법인의 임원의 정관 제17조의 방법에 의하여 총회에서 선출한다.<br>
												② 임원의 보선은 결원이 발생한 날로부터 2개월 이내로 하여야 한다.
											</p>
											<strong>제10조 (임원의 해임)</strong>
											<p>
												임원이 다음 각호에 해당하는 행위를 한 때에는 총회의 의결로 해임할 수 있다.<br>
												1. 본 법인의 목적에 위배되는 행위<br>
												2. 임원간의 분쟁·회계부정 또는 현저한 부당행위<br>
												3. 본 법인의 업무를 방해하는 행위 
											</p>
											<strong>제11조 (임원의 임기)</strong>
											<p>
												① 이사의 임기는 2년, 감사의 임기도 2년으로 하며, 연임할 수 있다. 다만, 임기만료될 때까지 후임자를 선임하지 못하였을 시는 후임자 선임시까지 그 임기가 연장된 것으로 본다.<br>
												② 보선에 의하여 선임된 임원의 임기는 전임자의 잔여기간으로 한다. 
											</p>
											<strong>제12조 (임원의 직무)</strong>
											<p>
												① 이사장은 이 단체를 대표하고 업무를 통할하며 총회 및 이사회의 의장이 된다. 이사장 유고시에는 미리 이사회가 정한 순으로 그 직무를 대행한다.<br>
												② 이사는 이사회를 통하여 본 법인의 주요 사항을 심의, 의결하며 이사회 또는 이사장으로부터 위임 받은 사항을 처리한다.<br>
												③ 감사는 일반회계 및 운영에 대해 감사하며 부정 또는 부당한 점이 있을 경우 이사회에 시정을 요구하고 그 보고를 위하여 이사회 또는 총회의 소집을 요구할 수 있다.
											</p>
										</div>
									</div>
									<div class="item">
										<div class="title">
											<strong>제3장 총회 및 이사회</strong>
										</div>
										<div class="content">
											<strong>제16조 (총회)</strong>
											<p>① 총회는 최고 의결기관으로 전 회원으로 구성한다.</p>
											<strong>제17조 (총회의 구분과 소집)</strong>
											<p>
												① 총회는 정기총회와 임시총회가 있고 이사장이 소집한다.<br>
												② 정기총회는 매 회계연도 종료 후 1개월 이내에 소집하며, 임시총회는 이사장 또는 감사 및 재적회원 1/3 이상의 서면 요정이 있을 때 소집한다.<br>
												③ 이사장은 총회의 안건, 일시, 장소 등을 명기하여 회일 7일전까지 서면 통지하여야 한다.
											</p>
											<strong>제18조 (의결정족수)</strong>
											<p>
												① 총회는 민법 또는 정관에 특별한 규정이 없는 한 재적 정회원 과반수의 출석으로 개회하고, 출석 정회원 과반수의 찬성으로 의결한다.<br>
												② 가부동수일 때는 의장이 이를 결정한다.
											</p>
											<strong>제19조 (서면에 의한 표결 및 표결의 위임)</strong>
											<p>부득이한 사유로 회의에 출석할 수 없는 사원은 사전에 통지된 사항에 한하여 서면으로 표결할 수 있고, 다른 사원 또는 대리인에게 위임할 수 있다. 이때 서면으로 표결하거나 표결 위임한 사원은 출석한 것으로 보며, 이 경우 위임장은 총회 전까지 의장에게 제출하여야 한다.</p>
											<strong>제20조 (총회의 의결사항)</strong>
											<p>
												총회는 다음 사항을 심의, 의결한다.<br>
												1. 임원의 선출과 해임<br>
												2. 법인의 해산 및 정관 변경에 관한 사항<br>
												3. 기본재산의 취득, 처분 및 자금 차입에 관한 사항<br>
												4. 예산 및 결산의 승인<br>
												5. 사업계획의 승인<br>
												6. 기타 중요사항
											</p>
											<strong>제21조 (이사회의 구성)</strong>
											<p>
												① 이사장과 이사로 구성한다.<br>
												② 감사는 이사회에 참석하여 발언할 수 있다.
											</p>
											<strong>제22조 (이사회의 소집)</strong>
											<p>
												① 이사회는 정기이사회 및 임시이사회로 구분하며 이사장이 소집한다.<br>
												② 정기이사회는 매 분기 1회 소집하며 임시이사회는 이사장, 감사 또는 재적이사 1/3 이상의 서면 요청이 있을 때 소집한다.<br>
												③ 이사장은 이사회를 소집하고자 할 때에는 회의 개최 7일전까지 이사 및 감사에게 회의의 목적과 안전, 개최일시 및 장소를 통지하여야 한다. 다만, 이사전원이 참석하고 또는 그 전원이 이사회의 소집을 요구할 때 또는 이사장이 긴급을 요하는 정당한 사유가 있는 경우는 그러하지 아니하다.
											</p>
											<strong>제23조 (이사회의 의결사항)</strong>
											<p>
												이사회는 다음의 사항을 심의의결한다.<br>
												1. 임원의 선출과 해임<br>
												2. 정관 변경 및 법인 해산에 관한 사항<br>
												3. 기본 재산의 취득, 처분 및 자금 차입에 관한 사항<br>
												4. 예산 및 결산의 승인<br>
												5. 사업계획의 승인<br>
												6. 총회에 부의할 안건의 작성 및 총회에서 위임받은 사항<br>
												7. 기타 중요사항
											</p>
											<strong>제24조 (의결정족수)</strong>
											<p>이사회는 재적이사 과반수의 출석으로 개회하고, 출석이사 과반수의 찬성으로 의결한다.</p>
											<strong>제25조 (회의록)</strong>
											<p>총회 및 이사회의 의사 진행 경과와 결과는 회의록으로 작성해야 하며 의장과 출석 이사가 기명 날인한다.</p>
										</div>
									</div>
									<div class="item">
										<div class="title">
											<strong>제4장 사무국</strong>
										</div>
										<div class="content">
											<strong>제26조 (종사자의 구성 및 임면) </strong>
											<p>
												① 본 법인의 업무를 효율적으로 집행하기 위하여 사무국을 두며 필요한 조직의 각 부서는 이사회 결의로 정한다.<br>
												② 종사자의 임면에 관하여는 이사회 결의로 별도의 인사규정을 두어 정한다.
											</p>
										</div>
									</div>
									<div class="item">
										<div class="title">
											<input type="button" value="제5장 회계 및 재정" class="term_bt">
										</div>
										<div class="content">
											<strong>제27조 (재산의 구분)</strong>
											<p>
												본 법인의 재산은 기본재산과 보통재산으로 구분한다.<br>
												1. 기본재산은 본 법인 설립 당시 기본재산으로 출연한 재산과 이사회에서 기본재산으로 편입할 것을 의결할 재산으로 하며, 그 목록은 별지2. 기재와 같다.<br>
												2. 보통재산은 기본재산 이외의 재산으로 한다.
											</p>
											<strong>제28조 (재산의 관리)</strong>
											<p>
												① 법인의 기본재산을 매도, 증여, 임대 교환하거나 담보제공 또는 용도 등을 변경하고자 할 때 또는 의무의 부담이나 권리를 포기하고자 할 때는 총회의 의결을 거쳐야 한다.<br>
												② 기본재산의 변경에 관하여는 정관변경에 관한 규정을 준용한다.
											</p>
											<strong>제29조 (재원)</strong>
											<p>
												① 본 법인의 유지 및 운영에 필요한 경비의 재원은 다음과 같다.<br>
												　 1) 회원의 회비<br>
												　 2) 수익사업으로 취득한 수익금<br>
												　 3) 정부 및 지방자치단체보조금<br>
												　 4) 각종 후원금 및 기타의 수입으로 한다.<br>
												② 본 법인이 예산외의 채무부담을 하고자 할 때에는 총회의 의결을 거쳐 주무관청의 승인을 받아야 한다.
											</p>
											<strong>제30조 (회계연도 및 보고)</strong>
											<p>
												① 회계연도는 정부의 회계연도에 준한다.<br>
												② 감사는 회계연도 종료 후 1개월 이내에 전년도 사업실적서 및 수지결산서를 작성하여 이사회 의결을 거쳐 총회에 보고한다.
											</p>
										</div>
									</div>
									<div class="item">
										<div class="title">
											<input type="button" value="제6장 보칙" class="term_bt">
										</div>
										<div class="content">
											<strong>제31조 (정관변경) </strong>
											<p>본 법인의 정관을 변경하고자 할 때에는 총회에서 재적회원 3분의 2 이상의 찬성으로 의결한다.</p>
											<strong>제32조 (해산 및 합병)</strong>
											<p>본 법인이 해산하거나 합병하고자 할 때에는 총회에서 재적회원 4분의 3 이상의 찬성으로 의결하여 주무관청에게 신고하여야 한다.</p>
											<strong>제33조 (잔여재산의 처분)</strong>
											<p>본 법인이 해산된 때에는 잔여재산은 총회의 의결을 거쳐 주무관청의 허가를 얻어 다른 사회적 기업 또는 공익적 기금에 기부한다.</p>
											<strong>제34조 (운영규정)</strong>
											<p>이 정관 규정 이외에 이 단체의 운영에 필요한 사항은 이사회 의결로 별도의 규정을 두어 정한다.</p>
										</div>
									</div>
									<div class="item">
										<div class="title">
											<strong>부칙</strong>
										</div>
										<div class="content">
											<p>
				                                이 정관은 주무관청이 허가한 날로부터 시행한다.<br>
				                                이 정관은 시행당시 법인설립을 위하여 발기인 등이 행한 행위는 이 정관에 의하여 행한 것으로 본다.<br>
				                                이 법인 설립시의 재산목록은 별지1과 같다.<br>
				                                본 법인을 설립하기 위하여 이 정관을 작성하고, 다음과 같이 설립 발기인 전원이 기명 날인하다.
				                            </p>
										</div>
									</div>
								</div>
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
								<input type="button" value="다음 단계로" class="bt3 on" onclick="javascript:move(1);">
							</div>
						</div>
						
						<!-- 회원가입 - 정보 입력 -->
						<div class="member member_form1 form_step2">
							<!-- 현재상태 -->
							<div class="location">
								<div>약관동의</div>
								<div class="on">정보입력</div>
								<div>가입완료</div>
							</div>
							<div class="paper">
								<form action="<c:url value="/member/signup"/>" method="post">
									<dl class="member_chk">
										<dt>회원구분</dt>
										<dd>
											<ul class="chk_wrap">
												<li>
													<input type="radio" name="user_role" id="member_chk2" class="radio1" value="3">
													<label for="member_chk2">일반</label>
												</li>
												<li>
													<input type="radio" name="user_role" id="member_chk3" class="radio1" value="4">
													<label for="member_chk3">기업</label>
												</li>
												<li>
													<input type="radio" name="user_role" id="member_chk1" class="radio1" value="2" checked>
													<label for="member_chk1">학생</label>
												</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>아이디</dt>
										<dd>
											<input type="text" placeholder="아이디 입력" class="ipt1" name="login">
											<p class="message error">5~20자의 영문 소문자, 숫자만 사용 가능합니다.</p>
											<p class="message confirm">사용 가능한 아이디입니다.</p>
										</dd>
									</dl>
									<dl>
										<dt>비밀번호</dt>
										<dd>
											<input type="password" placeholder="비밀번호 입력" class="ipt1" name="password" autocomplete="off">
											<p class="message error">6자리 이상 입력하세요.</p>
										</dd>
									</dl>
									<dl>
										<dt>비밀번호 확인</dt>
										<dd>
											<input type="password" placeholder="비밀번호 재입력" class="ipt1" name="password_confirm" autocomplete="off">
											<p class="message error">비밀번호가 일치하지 않습니다.</p>
											<p class="message confirm">비밀번호가 일치합니다.</p>
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
									<dl class="company_tel">
										<dt>연락처</dt>
										<dd>
											<input type="text" placeholder="연락처" class="ipt1" name="phone">
											<p class="message error">연락처가 입력되지 않았습니다.</p>
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
									<input type="button" value="회원가입" class="bt3 on" id="submit">
								</form>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<!-- 회원가입 - 가입 완료 -->
						<div class="member form_complete">
							<div class="paper">
								환영합니다!<br>
								한국효소공학연구회 회원가입이 완료되었습니다.
								<a href="<c:url value="/"/>" class="bt3 on">HOME</a>
							</div>
						</div>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>