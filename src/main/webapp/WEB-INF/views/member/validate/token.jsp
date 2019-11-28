<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">
$(document).ready(function(){
	$("input[name='password']").keyup(function(e){
		var pwd = $(this).val();
		if(pwd.length < 6){
			$(".message").hide();
			$(".six-letters").show();
			
			buttonDisable();
		}else{
			var pwdConfirm = $("input[name='password_confirm']").val();
			
			if(pwdConfirm.length > 0){
				if(pwd == pwdConfirm){
					$(".message").hide();
					$(".confirm").show();
					buttonEnable();
				}else{
					$(".message").hide();
					$(".error").show();
					buttonDisable();
				}
			}
		}
	});
	$("input[name='password_confirm']").keyup(function(e){
		var pwd = $("input[name='password']").val();
		var pwdConfirm = $(this).val();
		
		if(pwd.length >= 6 && pwdConfirm.length >= 6){
			if(pwd == pwdConfirm){
				$(".message").hide();
				$(".confirm").show();
				buttonEnable();
			}else{
				$(".message").hide();
				$(".error").text(jQuery.i18n.prop("member.signup.not_matched_pwd"))
				$(".error").show();
				buttonDisable();
			}
		}else{
			$(".error").text(jQuery.i18n.prop("member.new_pwd.over_six"));
			$(".error").show();
			buttonDisable();
		}
	});
});
function buttonDisable(){
	$(".bt3").removeClass('on');
	$(".bt3").attr('disabled', true);
}
function buttonEnable(){
	$(".bt3").addClass('on');
	$(".bt3").attr('disabled', false);
}
function changePwd(){
	buttonDisable();
	
	if(valid()){
		var url = $("form").attr("action");
		var param = $("form").serialize();
		
		$.ajax({
			url : url,
			data: param,
			type: 'POST',
			dataType: 'json'
		}).done(function(json){
			if(json.result > 0){
				var myInfoUrl = $("input[name='my-info-url']").val();
				if(confirm(jQuery.i18n.prop("member.change_pwd.complete"))){
					location.replace(myInfoUrl);
				}
			}else{
				alert(json.message);
			}
		}).fail(function(xhr, status, error){
			
		}).always(function(xhr, status){
			
		});
	}
}
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<div id="contentsTitle">
				<div>
					<h2><spring:message code="member.change_password" text="member.change_password"></spring:message></h2>
				</div>
			</div>
			
			<c:choose>
				<c:when test="${not empty user}">
					<form action="<c:url value="/member/newPwd/send/${user.id }"/>" method="POST">
						<div id="contentsPrint">
							<!-- 새 비밀번호 -->
							<div class="member member_form1">
								<div class="paper">
									<dl>
										<dt><spring:message code="member.new_pwd"/></dt>
										<dd>
											<input type="password" placeholder="<spring:message code="member.new_pwd"/>" class="ipt1" name="password">
											<p class="message six-letters"><spring:message code="member.new_pwd.over_six"/></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.new_pwd.confirm"/></dt>
										<dd>
											<input type="password" placeholder="<spring:message code="member.new_pwd.confirm.hint"/>" class="ipt1" name="password_confirm">
											<p class="message error"><spring:message code="member.password_not_match"/></p>
											<p class="message confirm"><spring:message code="member.password_match"/></p>
										</dd>
									</dl>
									<input type="hidden" name="login" value="${user.login }"/>
									<input type="hidden" name="my-info-url" value="<c:url value="/member/login"/>"/>
									<input type="button" value="<spring:message code="member.new_pwd.submit"/>" class="bt3" onclick="javascript:changePwd();" disabled>
								</div>
							</div>
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<div id="contentsPrint">
						<spring:message code="member.new_pwd.expired_token"/>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>