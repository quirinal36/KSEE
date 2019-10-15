<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="baseUrl" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<script src="https://cdn.ckeditor.com/4.11.3/standard-all/ckeditor.js"></script>
	<script type="text/javascript">
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
				alert("로그인 해주세요");
				window.location.replace(loginUrl +"?loginRedirect=" + redirectUrl);
			}
		});
	});
	
	function delButtonClick(button){
		var id = $(button).val();
		$(".bt_del_img").each(function(index, item){
			if(id == $(item).val()){
				$(item).parent().remove();
				return;
			}
		});
	}
	
	function insertBoard(){
		var url = $("form").attr("action");
		
		var title = $("input[name='title']").val();
		var content = CKEDITOR.instances.editor1.getData();
		var boardType = $("input[name='board_type']").val();
		var pictures = [];
		var files = [];
		$("#picture_ul").find(".bt_del_img").each(function(i, item){
			pictures.push($(item).val());
		});
		$("#file_ul").find(".bt_del_file").each(function(i, item){
			files.push($(item).val());
		});
		console.log("content: " + content);
		
		var param = "title="+title;
		param += "&content="+ encodeURI(content);
		param += "&boardType="+boardType;
		param += "&pictures="+pictures.join(",");
		param += "&files="+files.join(",");
		console.log(param);
		
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType : "json"
		}).done(function(json){
			if(json.result > 0){
				alert("글 작성이 완료되었습니다.");
				window.location.replace($("input[name='listUrl']").val());
			}
		});
		
		$("#editor1").keyup(function(e){
			
		});
	}
	</script>
</head>
<body>
<div class="wrap">
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
				<form action="<c:url value="/board/insertBoard"/>" method="post">
					<input type="hidden" name="board_type" value="${boardType }"/>
					<input type="hidden" name="isLoginUrl" value="<c:url value="${authUrl }"/>"/>
					<input type="hidden" name="loginUrl" value="<c:url value="/member/login"/>"/>
					<input type="hidden" name="currentUrl" value="${current }"/>
					<input type="hidden" name="listUrl" value="${listUrl }"/>
					
					<div class="board_write" style="margin-top:60px;">
						<div class="board_write_title">
							<div class="title">제목</div>
							<div class="title_ipt">
								<input type="text" placeholder="제목 입력" name="title" autocomplete="off" >
							</div>
							<div class="writer">작성자</div>
							<div class="writer_ipt"><input type="text" placeholder="작성자 입력" value="${user.username }" readonly autocomplete="off"></div>
						</div>
						<div class="board_write_cont">
							<textarea name="editor1" id="editor1" rows="30" cols="80"></textarea>
	                        <script>
			                CKEDITOR.replace( 'editor1' ,{
			                	toolbarGroups: [{
			                        "name": "basicstyles",
			                        "groups": ["basicstyles"]
			                      },
			                      {
			                        "name": "links",
			                        "groups": ["links"]
			                      },
			                      {
			                        "name": "paragraph",
			                        "groups": ["list", "blocks"]
			                      },
			                      {
			                        "name": "document",
			                        "groups": ["mode"]
			                      },
			                      {
			                        "name": "insert",
			                        "groups": ["insert"]
			                      },
			                      {
			                        "name": "styles",
			                        "groups": ["styles"]
			                      },
			                      {
			                        "name": "about",
			                        "groups": ["about"]
			                      }
			                    ],
			                    // Remove the redundant buttons from toolbar groups defined above.
			                    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar,Image'
			                	,height: 400
			                });
			            	</script>
						</div>
						<div class="board_write_img" id="dropzone-img">
							<dl>
								<dt>사진</dt>
								<dd>
									<!-- 사진 목록 -->
									<ul id="picture_ul">
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
						<div class="board_write_file"  id="dropzone-file">
							<dl>
								<dt>첨부파일</dt>
								<dd>
									<!-- 첨부파일 목록 -->
									<ul id = "file_ul">
										<!-- 
										<li>
											<span>2019 하계 중국 심포지움 안내파일.hwp</span>
											<input type="button" value="삭제" class="bt_del_file">
										</li>
										 -->
									</ul>
									<input id="fileupload" type="file" name="files[]" 
										data-url="<c:url value="/upload/file"/>" multiple>
								    <div id="progress_file">
								        <div class="progress-bar" style="width: 0%;"></div>
								    </div>
								</dd>
							</dl>
						</div>
						<div class="bt_wrap">
							<a href="javascript:void(0);" onclick="javascript:insertBoard();" class="bt1 on">등록</a>
							<a href="javascript:void(0);" onClick="history.back();" class="bt1">취소</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
<script type="text/javascript">
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
<script src="<c:url value="/resources/js/jquery-1.9.1.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>