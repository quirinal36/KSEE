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
$(document).ready(function(){
	$('#fileupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	
        	var file = data.result.file;
            
        	$("#file_ul").empty();
           	$("#file_ul").append(
           		$("<li>").append(
           			$("<span>").text(file.name)
           		).append(
           			$("<input>").attr("type","button").addClass("bt_del_file").attr("title","삭제")
           				.attr("onclick", "delButtonClick(this);").val(file.id)
           		)
           	);
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_file .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_file .progress-bar').css('width','0%');
            }
        },
 
        dropZone: $('#dropzone-file')
    });
	
	$("input[name='isSpeaker']").on('change', function(){
		var isSpeaker = parseInt($(this).val()) == 1? true : false;
		if(isSpeaker){
			$(".file").show();
		}else{
			$(".file").hide();
			$("#file_ul").empty();
		}
	});
});
function editSubmit(){
	var url = $("#applyForm").attr("action");
	var files = [];
	$("#file_ul").find(".bt_del_file").each(function(i, item){
		files.push($(item).val());
	});
	
	var isSpeaker = parseInt($("input[name='isSpeaker']:checked").val())== 1? true : false;
	
	if(files.length == 0 && isSpeaker){
		alert(jQuery.i18n.prop("symposium.submit_form"));
		return false;
	}
	
	var param = $("#applyForm").serialize();
	
	if(isSpeaker){
		param += "&fileId="+files.join(",");
	}
	
	if(confirm(jQuery.i18n.prop("symposium.to_register"))){
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: 'json'
		}).done(function(json){
			if(json.result > 0){
				window.location.replace(json.move);
			}
		});
	}
}
function delButtonClick(button){
	var id = $(button).val();
	$(".bt_del_file").each(function(index, item){
		if(id == $(item).val()){
			$(item).parent().remove();
			return;
		}
	});
}
</script>	
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
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
				<!-- 타이틀명 : 신청서 수정 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/symposium/apply/edit"/>" id="applyForm">
							<dl class="member_chk">
								<dt><spring:message code="symposium.attendee"/></dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="memberType" id="member_chk1" class="radio1" value="2" <c:if test="${apply.memberType eq 2 }">checked</c:if>>
											<label for="member_chk1"><spring:message code="symposium.general"/></label>
										</li>
										<li>
											<input type="radio" name="memberType" id="member_chk2" class="radio1" value="3" <c:if test="${apply.memberType eq 3 }">checked</c:if>>
											<label for="member_chk2"><spring:message code="symposium.apply.view.company"/></label>
										</li>
										<li>
											<input type="radio" name="memberType" id="member_chk3" class="radio1" value="4" <c:if test="${apply.memberType eq 4 }">checked</c:if>>
											<label for="member_chk3"><spring:message code="symposium.apply.view.student"/></label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt><spring:message code="symposium.apply.view.is_speaker"/></dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="isSpeaker" id="speaker_chk1" class="radio1" value="1" <c:if test="${apply.isSpeaker eq 1 }">checked</c:if>>
											<label for="speaker_chk1"><spring:message code="symposium.apply.view.speaker"/></label>
										</li>
										<li>
											<input type="radio" name="isSpeaker" id="speaker_chk2" class="radio1" value="2" <c:if test="${apply.isSpeaker eq 2 }">checked</c:if>>
											<label for="speaker_chk2"><spring:message code="symposium.apply.view.no_speaker"/></label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt><spring:message code="symposium.nationality"/></dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="national" id="national_chk1" class="radio1" value="1" <c:if test="${apply.national eq 1 }">checked</c:if>>
											<label for="national_chk1"><spring:message code="symposium.korea"/></label>
										</li>
										<li>
											<input type="radio" name="national" id="national_chk2" class="radio1" value="2" <c:if test="${apply.national eq 2 }">checked</c:if>>
											<label for="national_chk2"><spring:message code="symposium.china"/></label>
										</li>
										<li>
											<input type="radio" name="national" id="national_chk3" class="radio1" value="3" <c:if test="${apply.national eq 3 }">checked</c:if>>
											<label for="national_chk3"><spring:message code="symposium.japan"/></label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.name"/></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.enter_your_name"/>" class="ipt1" name="username" autocomplete="off" value="${apply.username }">
									<p class="message error"><spring:message code="member.enter_your_name"/></p>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="member.affiliation"/></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.enter_your_affiliation"/>" class="ipt1" name="classification" autocomplete="off" value="${apply.classification }">
									<p class="message error"><spring:message code="member.enter_your_affiliation"/></p>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code="symposium.position"/></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.enter_your_position"/>" class="ipt1" name="level" autocomplete="off" value="${apply.level }">
									<p class="message error"><spring:message code="member.enter_your_position"/></p>
								</dd>
							</dl>
							<dl class="company_tel">
								<dt><spring:message code="symposium.tel"/></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="symposium.tel.hint"/>" class="ipt1" name="telephone" autocomplete="off" value="${apply.telephone }">
								</dd>
							</dl>
							<dl class="email">
								<dt><spring:message code="symposium.email"/></dt>
								<dd>
									<input type="text" placeholder="<spring:message code="member.enter_your_email"/>" class="ipt1" name="email" autocomplete="off" value="${apply.email }">
									<span>@</span>
									<input type="text" placeholder="<spring:message code="member.enter_your_domain"/>" class="ipt1" name="domain" autocomplete="off" value="${apply.domain }">
									<p class="message error"><spring:message code="member.enter_your_email"/></p>
								</dd>
							</dl>
							<dl class="file" <c:if test="${apply.fileId eq 0 }">style="display:none;"</c:if>>
								<dt><spring:message code="symposium.form"/></dt>
								<dd>
									<div class="board_write_file"  id="dropzone-file">
										<!-- 첨부파일 목록 -->
										<ul id = "file_ul">
											<c:if test = "${apply.fileId gt 0 }">
												<li>
													<span>${apply.filename }</span>
													<input type="button" value="${apply.fileId }" class="bt_del_file" text="삭제" onclick="javascript:delButtonClick(this);">
												</li>
											</c:if>
										</ul>
										<input id="fileupload" type="file" name="files[]" 
											data-url="<c:url value="/upload/file"/>">
									    <div id="progress_file">
									        <div class="progress-bar" style="width: 0%;"></div>
									    </div>
									</div>
								</dd>
							</dl>
							<div class="bt3_item2">
								<input type="button" value="<spring:message code="member.edit_complete"/>" class="bt3 on" id="submit" onclick="javascript:editSubmit();">
								<a href="<c:url value="/symposium/apply/view/${apply.id }"/>" class="bt3"><spring:message code="symposium.apply.view.prev_page"/></a>
							</div>
							<input type="hidden" name="id" value="${apply.id }"/>
							<input type="hidden" name="sympId" value="${apply.sympId }"/>
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