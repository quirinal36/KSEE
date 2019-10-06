<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<!-- 회원탈퇴 -->
				<form action="<c:url value="/member/delete"/>" method="POST">
					<div class="member form_step1">
						<div class="paper">
							<strong>안내사항</strong>
							<div class="term"></div>
							<div class="chk_wrap">
								<input type="checkbox" id="term_chk1" class="chk1">
								<label for="term_chk1">동의합니다.</label>
							</div>
							<dl>
								<dt>비밀번호</dt>
								<dd>
									<input type="password" placeholder="비밀번호 입력" class="ipt1" autocomplete="false" name="password">
									<p class="message error">비밀번호가 일치하지 않습니다.</p>
								</dd>
							</dl>
							<input id="confirm-btn" type="button" value="회원탈퇴" class="bt3" onclick="javascript:deleteUser();">
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