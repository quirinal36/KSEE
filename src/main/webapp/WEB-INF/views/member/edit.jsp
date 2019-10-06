<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script src="<c:url value="/resources/js/memberEdit.js"/>"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#submit").on('click', function(){
		
		var result = validate($("form").serializeArray());
		if(result == true){
			if(jscd.browser.indexOf('msie') != -1  ){
				if(confirm("수정 하시겠습니까?")){
					submitEdit();
				}
			}else{
				swal({
					text : "수정 하시겠습니까?",
					showCancelButton: true,
					focusConfirm: true,
					confirmButtonText: "확인",
					cancelButtonText: "취소",
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
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<form action="<c:url value="/member/edit"/>" method="post">
					<!-- 회원가입 - 내 정보 수정 -->
					<div class="member member_form1">
						<div class="paper">
							<dl class="member_chk">
								<dt>회원구분</dt>
								<dd>
									<ul class="chk_wrap">
										<c:if test="${user.user_role eq 1 }">
											<li>
												<input type="radio" id="member_chk0" class="radio1" value="1" name="member_chk"
													<c:if test="${user.user_role eq 1 }">checked</c:if>
												>
												<label for="member_chk0">관리자</label>
											</li>
										</c:if>
										<li>
											<input type="radio" id="member_chk1" class="radio1" value="2" name="member_chk"
												<c:if test="${user.user_role eq 2 }">checked</c:if>
											>
											<label for="member_chk1">학생</label>
										</li>
										<li>
											<input type="radio" id="member_chk2" class="radio1" value="3" name="member_chk"
												<c:if test="${user.user_role eq 3 }">checked</c:if>
											>
											<label for="member_chk2">일반</label>
										</li>
										<li>
											<input type="radio" id="member_chk3" class="radio1" value="4" name="member_chk"
												<c:if test="${user.user_role eq 4 }">checked</c:if>
											>
											<label for="member_chk3">기업</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>아이디</dt>
								<dd>${user.login }</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>${user.username }</dd>
							</dl>
							<dl class="email">
								<dt>이메일 주소</dt>
								<dd>
									<input type="text" placeholder="이메일 아이디 입력" value="${user.email }" class="ipt1" name="email">
									<span>@</span>
								 	<input type="text" placeholder="도메인 입력" value="${user.domain }" class="ipt1" name="domain">
									<p class="message error">이메일 아이디를 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>
									<input type="text" placeholder="소속 입력" value="${user.classification }" class="ipt1" name="classification">
									<p class="message error">소속을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>
									<input type="text" placeholder="직위 입력" value="${user.level }" class="ipt1" name="level">
									<p class="message error">직위를 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>전화번호</dt>
								<dd>
									<input type="text" placeholder="전화번호 입력" value="${user.phone }" class="ipt1" name="phone">
									<p class="message error">휴대전화 번호를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="company_address">
								<dt>직장주소</dt>
								<dd>
									<input type="button" value="주소찾기" class="bt2" onclick="javascript:fn_setAddr()">
									<input type="text" placeholder="주소" value="${user.address }" class="mt-10 ipt1" name="address" readonly>
									<input type="text" placeholder="상세주소 입력" value="${user.addressDetail }" class="mt-10 ipt1" name="addressDetail">
									<p class="message error">상세주소가 입력되지 않았습니다.</p>
								</dd>
							</dl>
							<input type="hidden" value="${user.id }" name="id"/>
							<input type="hidden" value="<c:url value="/member/myinfo"/>" name="myinfo-url"/>
							<input type="button" value="수정완료" class="bt3 on" id="submit">
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