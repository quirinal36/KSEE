<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>

<script type="text/javascript">
$(document).ready(function(){
	console.log("ready");
});
function sendEmail(){
	// $("form").submit();
	var url = $("form").attr("action");
	var param = $("form").serialize();
	
	$.ajax({
		url : url,
		data: param,
		type: 'POST',
		dataType: 'json'
	}).done(function(json){
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
								<dt>아이디</dt>
								<dd>
									<input type="text" placeholder="아이디 입력" class="ipt1" name="login">
									<p class="message error">아이디를 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>이메일</dt>
								<dd>
									<input type="text" placeholder="이메일 입력" class="ipt1" name="email">
									<p class="message error">이메일을 입력하세요.</p>
								</dd>
							</dl>
							
							<input type="button" value="비밀번호 찾기" class="bt3 on" onclick="javascript:sendEmail();">
						</form>
						<div class="result" id="result_msg">
							<p>
								회원님의 이메일 주소(${user.email }@${user.domain })로<br>
								비밀번호 변경 링크를 보내드렸습니다.<br>
								메일이 오지 않는 경우 스팸/광고메일함을 확인해주세요.
							</p>
							<p style="display:none;">
								메일 발송 횟수(10회) 초과로 인해 메일을 보낼 수 없습니다.<br>
								내일 다시 시도하시거나 관리자에게 문의하세요.
							</p>
							<div class="bt_wrap">
								<a href="<c:url value="/member/login"/>">로그인</a>
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