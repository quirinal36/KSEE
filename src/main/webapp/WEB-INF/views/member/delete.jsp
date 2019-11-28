<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">
function deleteUser(){
	if(!$("#term_chk1").is(":checked")){
		alert("안내사항에 동의해주세요.");
		return false;
	}
	if(confirm("정말 탈퇴하시겠습니까?")){
		var url = $("form").attr("action");
		var data = $("form").serialize();
		
		$.ajax({
			url : url,
			data: data,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			if(json.result > 0){
				window.location.replace(json.logout);
			}else{
				$(".error").text(json.msg);
				$(".error").show();
			}
		});
	}
}
$(document).ready(function(){
	$("#term_chk1").change(function(){
		var isChecked = $(this).is(":checked");
		$("#confirm-btn").attr("disable", isChecked);
		if(isChecked){
			$("#confirm-btn").addClass("on");
		}else{
			$("#confirm-btn").removeClass("on");
		}
	});
	
	$("input[name='password']").keyup(function(){
		$(".error").hide();
	});
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
					<h2><spring:message code="member.terminate_membership" text="member.terminate_membership"></spring:message></h2>
				</div>
			</div>
			<div id="contentsPrint">
				<!-- 회원탈퇴 -->
				<form action="<c:url value="/member/delete"/>" method="POST">
					<div class="member form_step1">
						<div class="paper">
							<strong><spring:message code="member.instructions" text="member.instructions"></spring:message></strong>
							<div class="term">
								<spring:message code="member.delete_message1" text="member.delete_message1"></spring:message>
							</div>
							<div class="chk_wrap">
								<input type="checkbox" id="term_chk1" class="chk1">
								<label for="term_chk1"><spring:message code="member.i_agree" text="member.i_agree"></spring:message></label>
							</div>
							<dl>
								<dt><spring:message code="member.password" text="member.password"></spring:message></dt>
								<dd>
									<input type="password" placeholder="<spring:message code="member.password" text="member.password"></spring:message>" class="ipt1" autocomplete="false" name="password">
									<p class="message error"><spring:message code="member.password_not_match" text="member.password_not_match"></spring:message></p>
								</dd>
							</dl>
							<input id="confirm-btn" type="button" value="<spring:message code="member.terminate_membership" text="member.terminate_membership"></spring:message>" class="bt3" onclick="javascript:deleteUser();">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>