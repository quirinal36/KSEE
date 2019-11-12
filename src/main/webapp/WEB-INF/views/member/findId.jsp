<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">
function findId(){
	var form = document.getElementById("find-id-form");
	var param = $(form).serialize();
	var url = $(form).attr("action");
	
	$.ajax({
		url : url,
		data: param,
		dataType : "json",
		type: "POST"
	}).done(function(json){
		console.log(json);
		$(".result").show();
		
		if(json.result > 0){
			$("#result-text").text("회원님의 아이디는 [" + json.login +" ]입니다.");
		}else{
			$("#result-text").text("아이디를 찾지 못했습니다.");
		}
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
				<!-- 아이디 찾기 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/member/findId"/>" id="find-id-form">
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" placeholder="이름 입력" class="ipt1" name="username">
									<p class="message error">이름을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>휴대전화 번호</dt>
								<dd>
									<input type="text" placeholder="휴대전화번호 입력" class="ipt1" name="phone">
									<p class="message error">휴대전화 번호를 입력하세요.</p>
								</dd>
							</dl>
							<input type="button" value="아이디 찾기" class="bt3 on" onclick="findId()">
						</form>
						<div class="result">
							<p id="result-text">회원님의 아이디는 <span id="result-id">withi5</span>입니다.</p>
							<div class="bt_wrap">
								<a href="<c:url value="/member/login"/>">로그인</a>
								<a href="<c:url value="/member/findPwd"/>">비밀번호 찾기</a>
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