<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="baseUrl" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" href="<c:url value="/resources/css/css.css"/>">
	<script type="text/javascript" src="<c:url value="/resources/js/service/HuskyEZCreator.js"/>" charset="utf-8"></script>
	
	<script type="text/javascript">
	function replaceAll(str, searchStr, replaceStr){
		var arr = str.split(searchStr);
		return str.split(searchStr).join(replaceStr);
	}
	
	$(document).ready(function(){
		var url = $("#clearUrl").val();
		
		var isLoginUrl = $("input[name='isLoginUrl']").val();
		var loginUrl = $("input[name='loginUrl']").val();
		var redirectUrl = $("input[name='currentUrl']").val();
		$.ajax({
			url : isLoginUrl,
			type: "GET",
			dataType: 'json'
		}).done(function(json){
			if(json.result){
				
			}else{
				alert("로그인하세요.");
				window.location.replace(loginUrl +"?loginRedirect=" + redirectUrl);
			}
		});
	});
	
	function delButtonClick(button){
		var id = $(button).val();
		var btnWhich = $(button).hasClass("btn_del_img");
		if(btnWhich){
			$(".bt_del_img").each(function(index, item){
				if(id == $(item).val()){
					var url = "/delete/img/"+id;
					// console.log("delete: "+url);
					
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
		}else{
			$(".bt_del_file").each(function(index, item){
				if(id == $(item).val()){
					// var url = $(button).parent().find("input[name='del_url']").val();
					// console.log("delete: "+url);
					var url = "/delete/file/"+id;
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
	}
	function replaceAll(str, searchStr, replaceStr){
		var arr = str.split(searchStr);
		return str.split(searchStr).join(replaceStr);
	}
	function editBoard(){
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		
		var textContent = document.getElementById("ir1").value;
		textContent = replaceAll(textContent, "'", "&apos;");
		textContent = replaceAll(textContent, "&nbsp;", " ");
		textContent = replaceAll(textContent, "&", "%26");
		
		var url = $("form").attr("action");
		
		var title = $("input[name='title']").val();
		title = replaceAll(title, "'", "&apos;");
		title = replaceAll(title, "&nbsp;", " ");
		title = replaceAll(title, "&", "%26");
		
		var title_en = $("input[name='title_en']").val();
		title_en = replaceAll(title_en, "'", "&apos;");
		title_en = replaceAll(title_en, "&nbsp;", " ");
		title_en = replaceAll(title_en, "&", "%26");
		
		var content = textContent;
		var boardType = $("input[name='board_type']").val();
		var pictures = [];
		var files = [];
		$("#picture_ul").find(".bt_del_img").each(function(i, item){
			pictures.push($(item).val());
		});
		$("#file_ul").find(".bt_del_file").each(function(i, item){
			files.push($(item).val());
		});
		
		var param = "title="+encodeURI(title);
		param += "&title_en="+title_en;
		param += "&id="+ $("form").find("input[name='id']").val();
		param += "&viewCount" + $("form").find("input[name='view_count']").val();
		param += "&content="+content;
		param += "&boardType="+boardType;
		param += "&pictures="+pictures.join(",");
		param += "&files="+files.join(",");
		
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType : "json"
		}).done(function(json){
			if(json.result > 0){
				alert(jQuery.i18n.prop("board.edit.submit.complete"));
				window.location.replace($("input[name='detailUrl']").val());
			}
		});
	}
	<%-- --%>
	</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div class="container_wrap">
		<div class="container">
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<form action="<c:url value="/board/editBoard"/>" method="post">
					<input type="hidden" name="board_type" value="${board.boardType }"/>
					<input type="hidden" name="id" value="${board.id }"/>
					<input type="hidden" name="view_count" value="${board.viewCount }"/>
					<input type="hidden" name="isLoginUrl" value="<c:url value="${authUrl }"/>"/>
					<input type="hidden" name="loginUrl" value="<c:url value="/member/login"/>"/>
					<input type="hidden" name="currentUrl" value="${current }"/>
					<input type="hidden" name="detailUrl" value="${detailUrl }"/>
					
					<div class="board_write" style="margin-top:60px;">
						<div class="board_write_title">
							<div class="title"><spring:message code="board.title"/></div>
							<div class="title_ipt">
								<input type="text" placeholder="<spring:message code="board.title"/>" name="title" autocomplete="off" value="${board.title }">
							</div>
							<div class="writer"><spring:message code="board.user"/></div>
							<div class="writer_ipt"><input type="text" placeholder="<spring:message code="board.user"/>" value="${board.writerName }" readonly autocomplete="off"></div>
						</div>
						
						<div class="board_write_title en">
							<div class="title"><spring:message code="board.title" text="board.title"></spring:message>(en)</div>
							<div class="title_ipt">
								<input type="text" placeholder="title" name="title_en" autocomplete="off" value="${board.title_en }">
							</div>
						</div>
						
						<div class="board_write_cont">
							<textarea name="content" id="ir1" rows="10" style="width:100%; height:412px; display:none;"></textarea>
						</div>
						<div class="board_write_img">
							<dl>
								<dt><spring:message code="board.image"/></dt>
								<dd>
									<!-- 사진 목록 -->
									<ul id="picture_ul">
										<c:forEach items="${photoList }" var="item">
											<li style="background-image: url(${item.url});">
												<input type="button" title="삭제" class="bt_del_img" value="${item.id }" 
													onclick="javascript:delButtonClick(this);">
											</li>
										</c:forEach>
									</ul>
									<!-- 첨부하기 버튼 -->
									<input id="imageupload" type="file" name="files[]" 
										accept="image/*" data-url="<c:url value="/upload/image"/>" multiple>
									<div id="dropzone" class="fade well" style="display:none;">Drop files here</div>
								    <div id="progress">
								        <div style="width: 0%;"></div>
								    </div>
								</dd>
							</dl>
						</div>
						<div class="board_write_file">
							<dl>
								<dt><spring:message code="board.attachment"/></dt>
								<dd>
									<!-- 첨부파일 목록 -->
									<ul id="file_ul">
										<c:forEach items="${fileList }" var="item">
											<li>
												<span>${item.name }</span>
												<input type="button" title="삭제" class="bt_del_file" value="${item.id }"
													onclick="javascript:delButtonClick(this);">
											</li>
										</c:forEach>
									</ul>
									<input id="fileupload" type="file" name="files[]" 
										data-url="<c:url value="/upload/file"/>" multiple>
									<div id="dropzone" class="fade well" style="display:none;">Drop files here</div>
								    <div id="progress">
								        <div style="width: 0%;"></div>
								    </div>
								</dd>
							</dl>
						</div>
						<div class="bt_wrap">
							<a href="javascript:void(0);" onclick="javascript:editBoard();" class="bt1 on"><spring:message code="board.submit"/></a>
							<a href="javascript:void(0);" onClick="history.back();" class="bt1"><spring:message code="board.cancel"/></a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
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
		oEditors.getById["ir1"].exec("PASTE_HTML", ['${board.content}']);
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
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        },
 
        dropZone: $('#dropzone')
    });
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
           				.attr("onclick", "delButtonClick(this);").val(file.id)
           		)
           	);
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        },
 
        dropZone: $('#dropzone')
    });
});

</script>

<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>