<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>${title }</title>
	<c:import url="/inc/head_admin"></c:import>
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value="/resources/js/service/HuskyEZCreator.js"/>" charset="utf-8"></script>
	
	<script type="text/javascript">
	function replaceAll(str, searchStr, replaceStr){
		var arr = str.split(searchStr);
		return str.split(searchStr).join(replaceStr);
	}
	function registContent(){
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		
		var url = $("form").attr("action");
		var pictures = [];
		$("#picture_ul").find(".bt_del_img").each(function(i, item){
			pictures.push($(item).val());
		});
		var param = $("form").serialize();
		
		param += "&pictures="+pictures.join(",");
		
		if(confirm("저장할까요?")){
			$.ajax({
				url : url,
				data: param,
				type: "POST",
				dataType: "json"
			}).done(function(json){
				if(json.result > 0){
					alert("저장되었습니다.");
					opener.location.reload();
					window.open('','_self','');
					window.close();
				}
			});
		}
	}
	function deleteContent(){
		var url = $("form").find("input[name='del_url']").val();
		var param = $("form").serialize();
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				url : url,
				data: param,
				type: "POST",
				dataType: "json"
			}).done(function(json){
				if(json.result > 0){
					alert("삭제되었습니다.");
					opener.location.reload();
					window.open('','_self','');
					window.close();
				}
			});
		}
	}
	function delButtonClick(button){
		var id = $(button).val();
		$(".bt_del_img").each(function(index, item){
			if(id == $(item).val()){
				var url = "/delete/img/"+id;
				
				$.ajax({
					url : url,
					type: "POST",
					dataType : "json"
				}).done(function(json){
					console.log(json);
				});
				
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
				<div class="admin_title">${detail.sympTitle } - ${detail.typeTitle }</div>
				<form action="<c:url value="/admin/domestic/write/content"/>" method="post">
					<input type="hidden" name="id" value="${detail.id }"/>
					<input type="hidden" name="writer" value="${user.id }"/>
					<input type="hidden" name="lang" value="${detail.lang }"/>
					<input type="hidden" name="symposiumId" value="${detail.symposiumId }"/>
					<input type="hidden" name="stype" value="${detail.stype }"/>
					<input type="hidden" name="del_url" value="<c:url value="/admin/domestic/delete/content"/>"/>
					<div>
						<textarea name="content" id="ir1" rows="10" style="width:100%; height:412px; display:none;"></textarea>
					</div>
					<div class="board_write_img" id="dropzone-img">
						<dl>
							<dt>사진</dt>
							<dd>
								<!-- 사진 목록 -->
								<ul id="picture_ul">
									<c:forEach items="${photos }" var="item">
										<li style="background-image: url(${item.url});">
											<input type="button" title="삭제" class="bt_del_img" value="${item.id }" 
												onclick="javascript:delButtonClick(this);">
										</li>
									</c:forEach>
									<!-- 
									<li style="background-image: url(/resources/img/temp/3.png);">
										<input type="button" title="삭제" class="bt_del_img">
									</li>
									 -->
								</ul>
								<!-- 첨부하기 버튼 -->
								<input id="imageupload" type="file" name="files[]" 
									accept="image/*" data-url="<c:url value="/upload/image"/>" multiple>
							    <div id="progress_img" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
							        <div class="progress-bar" style="width: 0%;" ></div>
							    </div>
							</dd>
						</dl>
					</div>
					<div class="bt_wrap mb-60">
						<a href="javascript:registContent();" class="bt1 on">저장</a>
						<c:if test="${detail.id gt 0 }">
							<a href="javascript:deleteContent();" class="bt1">삭제</a>
						</c:if>
						<a href="javascript:history.go(-1)" class="bt1">취소</a>
					</div>
				</form>
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
		oEditors.getById["ir1"].exec("PASTE_HTML", ['${detail.content}']);
	},
	fCreator: "createSEditor2"
});

$(document).ready(function(){
    $('#imageupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	
        	var file = data.result.file;
        	$("#picture_ul").append(
       			$("<li>").attr("style", "background-image: url(" + file.url + ");")
       				.append(
       						$("<input>").attr("type","button").attr("title","삭제").addClass("bt_del_img")
       						.attr("onclick", "delButtonClick(this);").val(file.id)
       				)
       			);

        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_img .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_img .progress-bar').css('width','0%');
            }
        },
 
        dropZone: $('#dropzone-img')
    });
});
</script>

<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>