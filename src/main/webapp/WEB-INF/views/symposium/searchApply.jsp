<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/resources/js/symposium.js"/>"></script>
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">
function applySearch(){
	var url = $("form").attr("action");
	var param = $("form").serialize();
	
	$.ajax({
		url: url,
		data: param,
		type: "POST",
		dataType: "json"
	}).done(function(json){
		$(".apply_search_result").each(function(){
			$(this).hide();
		});
		
		if(json.result > 0){
			$(".applyId").val(json.applyId);
			
			if(json.status == 1){
				$(".apply_search_result.apply").show();
			}else if(json.status == 2){
				$(".apply_search_result.complete").show();
			}
		}else{
			$(".apply_search_result.none").show();
		}
	});
}
function showView(){
	var url = $("input[name='viewUrl']").val();
	
	window.location.replace(url +"/" + $(".applyId").val());
}
$(document).ready(function(){
	$("input[name='national']").change(function(){
		$("input[name='national']").each(function(){
			var value = $(this).val();
			var checked = $(this).prop('checked');
			
			if(value == 1 && checked){
				$(".symp-title:first").attr("name","sympId");
				$(".symp-title:first").show();
				
				$(".symp-title:last").removeAttr("name");
				$(".symp-title:last").hide();
			}else if(value == 2 && checked){
				$(".symp-title:last").attr("name","sympId");
				$(".symp-title:last").show();
				
				$(".symp-title:first").removeAttr("name");
				$(".symp-title:first").hide();
			}
		});
	});
});
</script>
<style type="text/css">
.apply_search_result{
	display:none;
}
</style>
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
				<!-- 타이틀명 : 참가신청 조회 -->
				<!-- 참가신청 조회 - 정보 입력 -->
				<div class="member member_form1 form_step1">
					<div class="paper">
						<form action="<c:url value="/symposium/apply/search"/>" method="POST">
							<dl class="member_chk">
								<dt>구분</dt>
								<dd>
									<ul>
										<li>
											<input type="radio" name="national" id="dome" class="radio1" value="1" checked>
											<label for="dome">국내 학술대회</label>
										</li>
										<li>
											<input type="radio" name="national" id="inter" class="radio1" value="2">
											<label for="inter">한중일 학술대회</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>행사명</dt>
								<dd>
									<select class="select2 symp-title" name="sympId">
										<c:forEach items="${domeList }" var="item">
											<option value="${item.id }">${item.title }</option>
										</c:forEach>
									</select>
									<select class="select2 symp-title" style="display:none;">
										<c:forEach items="${interList }" var="item">
											<option value="${item.id }">${item.title }</option>
										</c:forEach>
									</select>
								</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" placeholder="이름 입력" class="ipt1" name="username" autocomplete="off" value="${user.username }">
									<p class="message error">이름을 입력하세요.</p>
								</dd>
							</dl>
							<dl class="company_tel">
								<dt>연락처</dt>
								<dd>
									<input type="text" placeholder="연락처 입력" class="ipt1" name="telephone" autocomplete="off" value="${user.telephone }">
								</dd>
							</dl>
							<input type="button" value="참가신청 조회" class="bt3 on" onclick="javascript:applySearch();">
							<!-- 검색결과 없음 -->
							<div class="apply_search_result none">
								<p>
									신청내역이 없습니다.<br>
									입력하신 정보를 확인해주세요.
								</p>
							</div>
							<!-- 접수 중 -->
							<div class="apply_search_result apply">
								<p><span>[접수 중]</span> 상태입니다.</p>
								<a href="javascript:void(0);" onclick="javascript:showView();" class="bt2 on">신청서 보기</a>
								<a href="javascript:void(0);" onclick="javascript:delete();" class="bt2">신청 취소</a>
								<input type="hidden" value="" class="applyId"/>
								<input type="hidden" name="viewUrl" value="<c:url value="/symposium/apply/view"/>"/>
							</div>
							<!-- 신청완료 -->
							<div class="apply_search_result complete">
								<p><span>[신청완료]</span> 상태입니다.</p>
								<a href="javascript:void(0);" onclick="javascript:showView();" class="bt2 on">신청서 보기</a>
							</div>
							<!-- 신청취소 -->
							
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>