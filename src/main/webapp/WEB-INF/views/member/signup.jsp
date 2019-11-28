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
				if(confirm(jQuery.i18n.prop("member.signup.confirm"))){
					submitSignup();
				}
			}else{
				swal({
					text : jQuery.i18n.prop("member.signup.confirm"),
					showCancelButton: true,
					focusConfirm: true,
					confirmButtonText: jQuery.i18n.prop("member.confirm"),
					cancelButtonText: jQuery.i18n.prop("member.cancel"),
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
					if(confirm(jQuery.i18n.prop("member.signup.complete"))){
						move(2);
					}
				}else{
					swal({
						text : jQuery.i18n.prop("member.signup.complete"),
						showCancelButton: false,
						focusConfirm: true,
						confirmButtonText: jQuery.i18n.prop("member.confirm"),
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
		var msg = jQuery.i18n.prop("member.signup.before_leave");
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
			<div id="contentsTitle">
				<div>
					<h2><spring:message code="member.member_registration" text="member.member_registration"></spring:message></h2>
				</div>
			</div>
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
									<c:import url="/inc/term"></c:import>
								</div>
								<div class="chk_wrap">
									<input type="checkbox" id="term_chk1" class="chk1">
									<label for="term_chk1"><spring:message code="member.i_agree" text="member.i_agree"></spring:message></label>
								</div>
								<strong><spring:message code="member.personal_info" text="member.personal_info"></spring:message></strong>
								<div class="term">
									<c:import url="/inc/privacy"></c:import>
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
											<input type="text" placeholder="<spring:message code="member.address" text="member.address"></spring:message>" class="mt-10 ipt1" name="address">
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