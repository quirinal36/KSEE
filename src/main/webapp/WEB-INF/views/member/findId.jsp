<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
			$("#result-text").text("회원님의 아이디는 [" + json.login);
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
			<div id="contentsTitle">
				<div>
					<h2><spring:message code="member.find_id" text="member.find_id"></spring:message></h2>
				</div>
			</div>
			<div id="contentsPrint">
				<!-- 아이디 찾기 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/member/findId"/>" id="find-id-form">
							<dl>
								<dt><spring:message code="member.name" text="member.name"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.name" text="member.name"></spring:message>" class="ipt1" name="username">
									<p class="message error"><spring:message code="member.enter_your_name" text="member.enter_your_name"></spring:message></p>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.tel" text="member.tel"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.tel" text="member.tel"></spring:message>" class="ipt1" name="phone">
									<p class="message error"><spring:message code="member.enter_your_num" text="member.enter_your_num"></spring:message></p>
								</dd>
							</dl>
							<input type="button" value="<spring:message code="member.find_id" text="member.find_id"></spring:message>" class="bt3 on" onclick="findId()">
						</form>
						<div class="result">
							<p id="result-text"></p>
							<div class="bt_wrap">
								<a href="<c:url value="/member/login"/>"><spring:message code="member.login" text="member.login"></spring:message></a>
								<a href="<c:url value="/member/findPwd"/>"><spring:message code="member.find_password" text="member.find_password"></spring:message></a>
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