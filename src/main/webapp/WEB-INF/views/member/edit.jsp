<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script src="<c:url value="/resources/js/memberEdit.js"/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#submit").on('click', function(){
		
		var result = validate($("form").serializeArray());
		if(result == true){
			if(jscd.browser.indexOf('msie') != -1  ){
				if(confirm(jQuery.i18n.prop("symposium.edit_confirm"))){
					submitEdit();
				}
			}else{
				swal({
					text : jQuery.i18n.prop("symposium.edit_confirm"),
					showCancelButton: true,
					focusConfirm: true,
					confirmButtonText: jQuery.i18n.prop("member.confirm"),
					cancelButtonText: jQuery.i18n.prop("member.cancel"),
					animation: false
				}).then(function(result){
					if(result.value){
						submitEdit();
					}
				});
			}
		}
	});
});
function submitEdit(){
	var url = $("form").attr("action");
	var param = $("form").serialize();
	
	$.ajax({
		url : url,
		data: param,
		type: 'POST',
		dataType: 'json'
	}).done(function(json){
		if(json.result > 0){
			var redirectUrl = $("input[name='myinfo-url']").val();
			location.replace(redirectUrl);
		}
	}).fail(function(xhr, status, error){
		
	}).always(function(xhr, status){
		
	});
}		
function fn_setAddr(){
	var width=500;
	var height=600;
		
	daum.postcode.load(function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	var addressText = "["+data.zonecode+"]" + data.address;
	        	$("input[name='address']").val(addressText);
	        	$("input[name='addressDetail']").val(data.buildingName);
	        }
	    }).open({
	    	left : (window.screen.width / 2) - (width / 2),
	    	top : (window.screen.height / 2) - (height / 2),
	    });
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
					<h2><spring:message code="member.edit_my_info" text="member.edit_my_info"></spring:message></h2>
				</div>
			</div>
			<div id="contentsPrint">
				<form action="<c:url value="/member/edit"/>" method="post">
					<!-- 회원가입 - 내 정보 수정 -->
					<div class="member member_form1">
						<div class="paper">
							<dl class="member_chk">
								<dt><spring:message code="member.member_cate" text="member.member_cate"></spring:message></dt>
								<dd>
									<ul class="chk_wrap">
										<c:if test="${user.user_role eq 1 }">
											<li>
												<input type="radio" id="member_chk0" class="radio1" value="1" name="member_chk"
													<c:if test="${user.user_role eq 1 }">checked</c:if>
												>
												<label for="member_chk0"><spring:message code="member.admin" text="member.admin"></spring:message></label>
											</li>
										</c:if>
										<li>
											<input type="radio" id="member_chk1" class="radio1" value="2" name="member_chk"
												<c:if test="${user.user_role eq 2 }">checked</c:if>
											>
											<label for="member_chk1"><spring:message code="member.student" text="member.student"></spring:message></label>
										</li>
										<li>
											<input type="radio" id="member_chk2" class="radio1" value="3" name="member_chk"
												<c:if test="${user.user_role eq 3 }">checked</c:if>
											>
											<label for="member_chk2"><spring:message code="member.general" text="member.general"></spring:message></label>
										</li>
										<li>
											<input type="radio" id="member_chk3" class="radio1" value="4" name="member_chk"
												<c:if test="${user.user_role eq 4 }">checked</c:if>
											>
											<label for="member_chk3"><spring:message code="member.corporate" text="member.corporate"></spring:message></label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.id" text="member.id"></spring:message></dt>
								<dd>${user.login }</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.name" text="member.name"></spring:message></dt>
								<dd>${user.username }</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.affiliation" text="member.affiliation"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.enter_your_affiliation" text="member.enter_your_affiliation"></spring:message>" value="${user.classification }" class="ipt1" name="classification">
									<p class="message error"><spring:message code="member.enter_your_affiliation" text="member.enter_your_affiliation"></spring:message></p>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.position" text="member.position"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.enter_your_position" text="member.enter_your_position"></spring:message>" value="${user.level }" class="ipt1" name="level">
									<p class="message error"><spring:message code="member.enter_your_position" text="member.enter_your_position"></spring:message></p>
								</dd>
							</dl>
							<dl class="company_address">
								<dt><spring:message code="member.work_address" text="member.work_address"></spring:message></dt>
								<dd>
									<input type="button" value="<spring:message code="member.find_address" text="member.find_address"></spring:message>" class="bt2" onclick="javascript:fn_setAddr()">
									<input type="text" placeholder="<spring:message code="member.address" text="member.address"></spring:message>" value="${user.address }" class="mt-10 ipt1" name="address">
									<input type="text" placeholder="<spring:message code="member.rest_address" text="member.rest_address"></spring:message>" value="${user.addressDetail }" class="mt-10 ipt1" name="addressDetail">
									<p class="message error"><spring:message code="member.enter_your_address2" text="member.enter_your_address2"></spring:message></p>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.tel" text="member.tel"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.tel" text="member.tel"></spring:message>" value="${user.phone }" class="ipt1" name="phone">
									<p class="message error"><spring:message code="member.enter_your_num" text="member.enter_your_num"></spring:message></p>
								</dd>
							</dl>
							<dl class="email">
								<dt><spring:message code="member.email" text="member.email"></spring:message></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.email" text="member.email"></spring:message>" value="${user.email }" class="ipt1" name="email">
									<span>@</span>
								 	<input type="text" placeholder="<spring:message code="member.domain" text="member.domain"></spring:message>" value="${user.domain }" class="ipt1" name="domain">
									<p class="message error"><spring:message code="member.enter_your_email" text="member.enter_your_email"></spring:message></p>
								</dd>
							</dl>
							<input type="hidden" value="${user.id }" name="id"/>
							<input type="hidden" value="<c:url value="/member/myinfo"/>" name="myinfo-url"/>
							<input type="button" value="<spring:message code="member.edit_complete" text="member.edit_complete"></spring:message>" class="bt3 on" id="submit">
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