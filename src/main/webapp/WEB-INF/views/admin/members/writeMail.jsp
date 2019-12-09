<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/list.js"/>"></script>
<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<c:url value="/resources/js/service/HuskyEZCreator.js"/>" charset="utf-8"></script>
<script type="text/javascript">
function submitForm(){
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var files = [];
	$("#file_ul").find(".bt_del_file").each(function(i, item){
		files.push($(item).val());
	});
	
	var param = files.join(",");
	$("input[name='fileIds']").val(param);
	
	if(confirm("메일을 전송하시겠습니까?")){
		$.ajax({
			url : $("form").attr("action"),
			data: $("form").serialize(),
			type: "POST",
			dataType : "json"
		}).done(function(json){
			if(json.result > 0){
				window.location.replace("/admin/members/")
			}
		});
	}
}
function delFileClick(button){
	var id = $(button).val();
	$(".bt_del_file").each(function(index, item){
		if(id == $(item).val()){
			$(item).parent().remove();
			return;
		}
	});
}
</script>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<div class="admin_title">${title }</div>
				<!-- 메일 보내기 -->
				<div class="mail_wrap">
					<form action="/admin/members/mail/write" method="POST">
						<table class="tbl1">
							<tbody>
								<tr>
									<th width="15%">보내는 사람</th>
									<td>한국효소공학연구회(${sender })</td>
								</tr>
								<tr>
									<th>받는 사람</th>
									<td>
										<c:forEach items="${list }" var="item" varStatus="sts">
											<input type="hidden" name="userId" value="${item.id }"/>
											${item.username }(${item.email }@${item.domain })
											<c:if test="${not sts.last }">,</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr class="title">
									<th>제목</th>
									<td>
										<input type="text" placeholder="제목 입력" name="title">
									</td>
								</tr>
								<tr class="cont">
									<td colspan="2">
										<textarea name="content" id="ir1" rows="10" style="width:100%; height:412px; display:none;"></textarea>
									</td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td>
										<ul id = "file_ul">
										</ul>
										<input id="fileupload" type="file" value="파일 등록" data-url="<c:url value="/upload/file"/>" multiple>
										<div id="progress_file">
									        <div class="progress-bar" style="width: 0%;"></div>
									    </div>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="bt_wrap">
							<a href="javascript:submitForm();" class="bt1 on">발송</a>
							<a href="#" class="bt1">취소</a>
						</div>
						<input type="hidden" name="sender" value="${sender }"/>
						<input type="hidden" name="fileIds"/>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var oEditors = [];

var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "/seSkin",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		},
		I18N_LOCALE : sLang
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

$(document).ready(function(){
	$('#fileupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	
        	var file = data.result.file;
            
           	$("#file_ul").append(
           		$("<li>").append(
           			$("<span>").text(file.name)
           		).append(
           			$("<input>").attr("type","button").addClass("bt_del_file").attr("title","삭제")
           				.attr("onclick", "delFileClick(this);").val(file.id)
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
});	
</script>
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>