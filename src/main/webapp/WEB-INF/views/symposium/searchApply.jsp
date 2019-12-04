<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
	
	if($("input[name='username']").val().length == 0) {
		alert(jQuery.i18n.prop("symposium.search.empty.name"));
	} else if($("input[name='telephone']").val().length == 0) {
		alert(jQuery.i18n.prop("symposium.search.empty.telephone"));
	} else {
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
}
function showView(){
	var url = $("input[name='viewUrl']").val();
	window.location.replace(url +"/" + $(".applyId").val());
}
function deleteApply(){
	if(confirm(jQuery.i18n.prop("symposium.to_cancel"))){
		var url = $("input[name='deleteUrl']").val();
		var param = "id="+$(".applyId").val();
		
		$.ajax({
			url: url,
			data: param,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			if(json.result > 0 && confirm(jQuery.i18n.prop("symposium.canceled"))){
				window.location.replace(json.move);
			}
		});
	}
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
								<dt><spring:message code="symposium.category"/></dt>
								<dd>
									<ul>
										<li>
											<input type="radio" name="national" id="dome" class="radio1" value="1" checked>
											<label for="dome"><spring:message code="symposium.korean"/></label>
										</li>
										<li>
											<input type="radio" name="national" id="inter" class="radio1" value="2">
											<label for="inter"><spring:message code="symposium.kcj"/></label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.name_of_event"/></dt>
								<dd>
									<select class="select2 symp-title" name="sympId">
										<c:forEach items="${domeList }" var="item">
											<option value="${item.id }">
												<c:choose>
													<c:when test="${locale.language eq 'en' }">
														${item.title_en }
													</c:when>
													<c:otherwise>
														${item.title }
													</c:otherwise>
												</c:choose>
											</option>
										</c:forEach>
									</select>
									<select class="select2 symp-title" style="display:none;">
										<c:forEach items="${interList }" var="item">
											<option value="${item.id }">
												<c:choose>
													<c:when test="${locale.language eq 'en' }">
														${item.title_en }
													</c:when>
													<c:otherwise>
														${item.title }
													</c:otherwise>
												</c:choose>
											</option>
										</c:forEach>
									</select>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.name"/></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="symposium.name"/>" class="ipt1" name="username" autocomplete="off" value="${user.username }">
									<p class="message error"><spring:message code="symposium.apply.search.please_input_name"/></p>
								</dd>
							</dl>
							<dl class="company_tel">
								<dt><spring:message code="symposium.tel"/></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="symposium.tel"/>" class="ipt1" name="telephone" autocomplete="off" value="${user.telephone }">
								</dd>
							</dl>
							<input type="button" value="<spring:message code="symposium.find_button"/>" class="bt3 on" onclick="javascript:applySearch();">
							<!-- 검색결과 없음 -->
							<div class="apply_search_result none">
								<p>
									<spring:message code="symposium.apply.search.no_result"/>
								</p>
							</div>
							<!-- 접수 중 -->
							<div class="apply_search_result apply">
								<p>
									<spring:message code="symposium.apply.search.being_processing"/>
								</p>
								<a href="javascript:void(0);" onclick="javascript:showView();" class="bt2 on">
									<spring:message code="symposium.apply.search.show_my_application"/>
								</a>
								<a href="javascript:void(0);" onclick="javascript:deleteApply();" class="bt2">
									<spring:message code="symposium.apply.search.cancel_apply"/>
								</a>
								<input type="hidden" value="" class="applyId"/>
								<input type="hidden" name="viewUrl" value="<c:url value="/symposium/apply/view"/>"/>
								<input type="hidden" name="deleteUrl" value="<c:url value="/symposium/apply/delete"/>"/>
							</div>
							<!-- 신청완료 -->
							<div class="apply_search_result complete">
								<p>
									<spring:message code="symposium.is_completed"/>
								</p>
								<a href="javascript:void(0);" onclick="javascript:showView();" class="bt2 on">
									<spring:message code="symposium.apply.search.show_my_application"/>
								</a>
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