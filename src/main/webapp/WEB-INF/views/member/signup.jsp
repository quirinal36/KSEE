<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
								<div class="on"><spring:message code="member.agree_to_terms" text="member.agree_to_terms"></spring:message></div>
								<div><spring:message code="member.enter_info" text="member.enter_info"></spring:message></div>
								<div><spring:message code="member.completed" text="member.completed"></spring:message></div>
							</div>
							<div class="paper">
								<strong><spring:message code="member.articles" text="member.articles"></spring:message></strong>
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
									<label for="term_chk1"><spring:message code="member.i_agree" text="member.i_agree"></spring:message></label>
								</div>
								<strong><spring:message code="member.personal_info" text="member.personal_info"></spring:message></strong>
								<div class="term">
									<한국효소공학연구회>('www.ksee.kr'이하 '한국효소공학연구회')는 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.<br><br>
									<한국효소공학연구회>는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.<br><br>
									○ 본 방침은 2019년 10월 1일부터 시행됩니다.<br><br>
									1. 개인정보의 처리 목적 <한국효소공학연구회>('www.ksee.kr'이하 '한국효소공학연구회')는 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.<br>
									가. 홈페이지 회원가입 및 관리<br>
									회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 서비스 부정이용 방지, 각종 고지·통지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.<br>
									나. 민원사무 처리<br>
									민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을 목적으로 개인정보를 처리합니다.<br>
									다. 재화 또는 서비스 제공<br>
									콘텐츠 제공 등을 목적으로 개인정보를 처리합니다.<br>
									라. 마케팅 및 광고에의 활용<br>
									서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.<br><br>
									2. 개인정보 파일 현황<br>
									개인정보 파일명 : 한국효소공학연구회<br>
									- 개인정보 항목 : 이메일, 휴대전화번호, 비밀번호, 로그인ID, 성별, 생년월일, 이름, 회사전화번호, 직책, 부서, 회사명, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보<br>
									- 수집방법 : 홈페이지<br>
									- 보유근거 : 정보주체의 동의<br>
									- 보유기간 : 회원탈퇴 시까지<br>
									- 관련법령 : 신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년, 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년, 대금결제 및 재화 등의 공급에 관한 기록 : 5년, 계약 또는 청약철회 등에 관한 기록 : 5년, 표시/광고에 관한 기록 : 6개월<br><br>
									3. 개인정보의 처리 및 보유 기간<br>
									① <한국효소공학연구회>는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집시에 동의 받은 개인정보 보유,이용기간 내에서 개인정보를 처리,보유합니다.<br>
									② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.<br>
									1.<홈페이지 회원가입 및 관리><br>
									<홈페이지 회원가입 및 관리>와 관련한 개인정보는 수집.이용에 관한 동의일로부터 회원탈퇴 시까지 위 이용목적을 위하여 보유.이용됩니다.<br>
									-보유근거 : 정보주체의 동의<br>
									-관련법령 : 1)신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년<br>
									2) 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년<br>
									3) 대금결제 및 재화 등의 공급에 관한 기록 : 5년<br>
									4) 계약 또는 청약철회 등에 관한 기록 : 5년<br>
									5) 표시/광고에 관한 기록 : 6개월<br><br>
									4. 정보주체와 법정대리인의 권리·의무 및 그 행사방법 이용자는 개인정보주체로써 다음과 같은 권리를 행사할 수 있습니다.<br>
									① 정보주체는 한국효소공학연구회에 대해 언제든지 개인정보 열람,정정,삭제,처리정지 요구 등의 권리를 행사할 수 있습니다.<br>
									② 제1항에 따른 권리 행사는한국효소공학연구회에 대해 개인정보 보호법 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 한국효소공학연구회는 이에 대해 지체 없이 조치하겠습니다.<br>
									③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.<br>
									④ 개인정보 열람 및 처리정지 요구는 개인정보보호법 제35조 제5항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.<br>
									⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.<br>
									⑥ 한국효소공학연구회는 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.<br><br>
									5. 처리하는 개인정보의 항목 작성<br>
									① <한국효소공학연구회>('www.ksee.kr'이하 '한국효소공학연구회')는 다음의 개인정보 항목을 처리하고 있습니다.<br>
									<홈페이지 회원가입 및 관리><br>
									- 필수항목 : 이메일, 휴대전화번호, 비밀번호, 로그인ID, 이름, 회사전화번호, 직책, 부서, 회사명, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보<br><br>
									6. 개인정보의 파기<br>
									<한국효소공학연구회>는 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.<br>
									-파기절차<br>
									이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.<br>
									-파기기한<br>
									이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.<br>
									-파기방법<br>
									전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.<br><br>
									7. 개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항<br>
									① 한국효소공학연구회 은 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠기(cookie)’를 사용합니다. ② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다. 가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다. 나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다. 다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.<br><br>
									8. 개인정보 보호책임자 작성<br>
									① 한국효소공학연구회(‘www.ksee.kr’이하 ‘한국효소공학연구회) 는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.<br>
									▶ 개인정보 보호책임자<br>
									성명 :이승구<br>
									직책 :총무이사<br>
									직급 :이사<br>
									연락처 :0428604373, sgoolee@gmail.com, 0428604379<br>
									※ 개인정보 보호 담당부서로 연결됩니다.<br>
									② 정보주체께서는 한국효소공학연구회(‘www.ksee.kr’이하 ‘한국효소공학연구회) 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 한국효소공학연구회(‘www.ksee.kr’이하 ‘한국효소공학연구회) 는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.<br><br>
									9. 개인정보 처리방침 변경<br>
									①이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.<br><br>
									10. 개인정보의 안전성 확보 조치 <한국효소공학연구회>는 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.<br>
									<개인정보 취급 직원의 최소화 및 교육><br>
									개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.
								</div>
								<div class="chk_wrap">
									<input type="checkbox" id="term_chk2" class="chk1">
									<label for="term_chk2"><spring:message code="member.i_agree" text="member.i_agree"></spring:message></label>
								</div>
								<input type="button" value="<spring:message code="member.next" text="member.next"></spring:message>" class="bt3 on" onclick="javascript:move(1);">
							</div>
						</div>
						
						<!-- 회원가입 - 정보 입력 -->
						<div class="member member_form1 form_step2">
							<!-- 현재상태 -->
							<div class="location">
								<div><spring:message code="member.agree_to_terms" text="member.agree_to_terms"></spring:message></div>
								<div class="on"><spring:message code="member.enter_info" text="member.enter_info"></spring:message></div>
								<div><spring:message code="member.completed" text="member.completed"></spring:message></div>
							</div>
							<div class="paper">
								<form action="<c:url value="/member/signup"/>" method="post">
									<dl class="member_chk">
										<dt><spring:message code="member.member_cate" text="member.member_cate"></spring:message></dt>
										<dd>
											<ul class="chk_wrap">
												<li>
													<input type="radio" name="user_role" id="member_chk2" class="radio1" value="3" checked>
													<label for="member_chk2"><spring:message code="member.general" text="member.general"></spring:message></label>
												</li>
												<li>
													<input type="radio" name="user_role" id="member_chk3" class="radio1" value="4">
													<label for="member_chk3"><spring:message code="member.corporate" text="member.corporate"></spring:message></label>
												</li>
												<li>
													<input type="radio" name="user_role" id="member_chk1" class="radio1" value="2">
													<label for="member_chk1"><spring:message code="member.student" text="member.student"></spring:message></label>
												</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.id" text="member.id"></spring:message></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.enter_your_id" text="member.enter_your_id"></spring:message>" class="ipt1" name="login">
											<input type="hidden" id="login-valid" value="0"/>
											<p class="message error"><spring:message code="member.enter_your_id2" text="member.enter_your_id2"></spring:message></p>
											<p class="message confirm"><spring:message code="member.you_may_use_this_id" text="member.you_may_use_this_id"></spring:message></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.password" text="member.password"></spring:message></dt>
										<dd>
											<input type="password" placeholder="<spring:message code="member.enter_your_password" text="member.enter_your_password"></spring:message>" class="ipt1" name="password" autocomplete="off">
											<p class="message error"><spring:message code="member.enter_your_password2" text="member.enter_your_password2"></spring:message></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.confirm_password" text="member.confirm_password"></spring:message></dt>
										<dd>
											<input type="password" placeholder="<spring:message code="member.confirm_password" text="member.confirm_password"></spring:message>" class="ipt1" name="password_confirm" autocomplete="off">
											<p class="message error"><spring:message code="member.password_not_match" text="member.password_not_match"></spring:message></p>
											<p class="message confirm"><spring:message code="member.password_match" text="member.password_match"></spring:message></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.name" text="member.name"></spring:message></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.enter_your_name" text="member.enter_your_name"></spring:message>" class="ipt1" name="username" autocomplete="off">
											<p class="message error"><spring:message code="member.enter_your_name" text="member.enter_your_name"></spring:message></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.affiliation" text="member.affiliation"></spring:message></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.enter_your_affiliation" text="member.enter_your_affiliation"></spring:message>" class="ipt1" name="classification">
											<p class="message error"><spring:message code="member.enter_your_affiliation" text="member.enter_your_affiliation"></spring:message></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.position" text="member.position"></spring:message></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.position" text="member.position"></spring:message>" class="ipt1" name="level">
											<p class="message error"><spring:message code="member.position" text="member.position"></spring:message></p>
										</dd>
									</dl>
									<dl class="company_address">
										<dt><spring:message code="member.work_address" text="member.work_address"></spring:message></dt>
										<dd>
											<input type="button" value="<spring:message code="member.find_address" text="member.find_address"></spring:message>" class="bt2" onclick="javascript:fn_setAddr()">
											<input type="text" placeholder="<spring:message code="member.address" text="member.address"></spring:message>" class="mt-10 ipt1" readonly name="address">
											<input type="text" placeholder="<spring:message code="member.rest_address" text="member.rest_address"></spring:message>" class="mt-10 ipt1" name="addressDetail">
											<p class="message error"><spring:message code="member.enter_your_address2" text="member.enter_your_address2"></spring:message></p>
										</dd>
									</dl>
									<dl class="company_tel">
										<dt><spring:message code="member.tel" text="member.tel"></spring:message></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.tel" text="member.tel"></spring:message>" class="ipt1" name="phone">
											<p class="message error"><spring:message code="member.enter_your_num" text="member.enter_your_num"></spring:message></p>
										</dd>
									</dl>
									<dl class="email">
										<dt><spring:message code="member.email_address" text="member.email_address"></spring:message></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.email" text="member.email"></spring:message>" class="ipt1" name="email">
											<span>@</span>
										 	<input type="text" placeholder="<spring:message code="member.domain" text="member.domain"></spring:message>" class="ipt1" name="domain">
											<p class="message error"><spring:message code="member.enter_your_email" text="member.enter_your_email"></spring:message></p>
										</dd>
									</dl>
									<input type="button" value="<spring:message code="member.member_registration" text="member.member_registration"></spring:message>" class="bt3 on" id="submit">
								</form>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<!-- 회원가입 - 가입 완료 -->
						<div class="member form_complete">
							<div class="paper">
								<spring:message code="member.welcome" text="member.welcome"></spring:message>
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