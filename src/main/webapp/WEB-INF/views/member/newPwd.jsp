<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		
		if(pwd.length * pwdConfirm.length > 0){
			if(pwd == pwdConfirm){
				$(".message").hide();
				$(".confirm").show();
				buttonEnable();
			}else{
				$(".message").hide();
				$(".error").show();
				buttonDisable();
			}
		}else{
			$(".message").hide();
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
			location.replace(myInfoUrl);
		}else{
			alert(json.message);
		}
	}).fail(function(xhr, status, error){
		
	}).always(function(xhr, status){
		
	});
}
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap">
				
			</c:import>
			<c:import url="/inc/contentsTitle">
				
			</c:import>
			<form action="<c:url value="/member/newPwd/send"/>" method="POST">
				<div id="contentsPrint">
					<!-- 새 비밀번호 -->
					<div class="member member_form1">
						<div class="paper">
							<dl>
								<dt>새 비밀번호</dt>
								<dd>
									<input type="password" placeholder="새 비밀번호 입력" class="ipt1" name="password">
									<p class="message six-letters">6자리 이상 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>비밀번호 확인</dt>
								<dd>
									<input type="password" placeholder="비밀번호 재입력" class="ipt1" name="password_confirm">
									<p class="message error">비밀번호가 일치하지 않습니다.</p>
									<p class="message confirm">비밀번호가 일치합니다.</p>
								</dd>
							</dl>
							<input type="hidden" name="login" value="${user.login }"/>
							<input type="hidden" name="my-info-url" value="<c:url value="/member/myinfo"/>"/>
							<input type="button" value="비밀번호 변경" class="bt3" onclick="javascript:changePwd();" disabled>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>