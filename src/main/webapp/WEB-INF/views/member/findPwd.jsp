<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>

<script type="text/javascript">
function sendEmail(button){
	$(button).removeClass("on");
	$(button).attr("disabled", true);
	
	var url = $("form").attr("action");
	var param = $("form").serialize();
	
	$.ajax({
		url : url,
		data: param,
		type: 'POST',
		dataType: 'json'
	}).done(function(json){
		console.log(json);
		
		if(json.result > 0){
			$("#result_msg p").text(json.msg);
			
			$("form").hide();
			$("#result_msg").show();
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
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<!-- 비밀번호 찾기 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/member/findPwd/submit"/>" method="POST">
							<dl>
								<dt><spring:message code="member.id" text="member.id"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.id" text="member.id"></spring:message>" class="ipt1" name="login">
									<p class="message error"><spring:message code="member.enter_your_id" text="member.enter_your_id"></spring:message></p>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.email" text="member.email"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.email" text="member.email"></spring:message>" class="ipt1" name="email">
									<p class="message error"><spring:message code="member.enter_your_email" text="member.enter_your_email"></spring:message></p>
								</dd>
							</dl>
							
							<input type="button" value="<spring:message code="member.find_password" text="member.find_password"></spring:message>" class="bt3 on" onclick="javascript:sendEmail(this);">
						</form>
						<div class="result" id="result_msg">
							<p>
								${user.email }<br>
								<spring:message code="member.send_email" text="member.send_email"></spring:message><br>
								<spring:message code="member.send_email2" text="member.send_email2"></spring:message>
							</p>
							<p style="display:none;">
								메일 발송 횟수(10회) 초과로 인해 메일을 보낼 수 없습니다.<br>
								내일 다시 시도하시거나 관리자에게 문의하세요.
							</p>
							<div class="bt_wrap">
								<a href="<c:url value="/member/login"/>"><spring:message code="member.login" text="member.login"></spring:message></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>