<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="baseUrl" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
	<link href="<c:url value="/resources/css/bootstrap.css"/>" type="text/css" rel="stylesheet" />
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<script src="https://cdn.ckeditor.com/4.11.3/standard-all/ckeditor.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		var url = $("#clearUrl").val();
		/*
		$.ajax({
			url : url,
			type : "GET"
		}).done(function(resp){
			alert("clear ok~!");
		});
		*/
		
		var isLoginUrl = $("input[name='isLoginUrl']").val();
		var loginUrl = $("input[name='loginUrl']").val();
		var redirectUrl = $("input[name='currentUrl']").val();
		$.ajax({
			url : isLoginUrl,
			type: "GET",
			dataType: 'json'
		}).done(function(json){
			console.log(json);
			
			if(json.result){
				
			}else{
				alert("로그인 해주세요");
				window.location.replace(loginUrl +"?loginRedirect=" + redirectUrl);
			}
		});
	});
	</script>
</head>
<body>
	<div class="wrap">
		<c:import url="/inc/header"></c:import>
		<div class="container_wrap">
			<div class="container">
				<form>
				<input type="hidden" name="isLoginUrl" value="<c:url value="/member/isLogin"/>"/>
				<input type="hidden" name="loginUrl" value="<c:url value="/member/login"/>"/>
				<input type="hidden" name="currentUrl" value="${current }"/>
				
				<div class="board_write">
					<div class="board_write_title">
						<div class="title">제목</div>
						<div class="title_ipt"><input type="text" placeholder="제목 입력"></div>
						<div class="writer">작성자</div>
						<div class="writer_ipt"><input type="text" placeholder="작성자 입력"></div>
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
		                	,height: 630
		                });
		            	</script>
					</div>
					<div class="board_write_img">
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
								<input id="fileupload" type="file" name="files[]" 
									accept="image/x-png, image/gif, image/jpeg" data-url="<c:url value="/upload"/>" multiple>
							    <div id="progress">
							        <div style="width: 0%;"></div>
							    </div>
							    <input type="hidden" value="<c:url value="/upload/get"/>" name="uploadUrl">
								<input type="hidden" value="<c:url value="/upload/clear"/>" name="clearUrl">
							</dd>
						</dl>
					</div>
					<div class="board_write_file">
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<!-- 첨부파일 목록 -->
								<ul>
									<li>
										<span>2019 하계 중국 심포지움 안내파일.hwp</span>
										<input type="button" value="삭제" class="bt_del_file">
									</li>
								</ul>
							</dd>
						</dl>
					</div>
					<div class="bt_wrap">
						<a href="#" class="bt1 on">등록</a>
						<a href="#" onClick="history.back();" class="bt1">취소</a>
					</div>
				</div>
				</form>
			</div>
		</div>
		<c:import url="/inc/footer"></c:import>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
	    $('#fileupload').fileupload({
	    	imageCrop: true,
	        dataType: 'json',
	        done: function (e, data) {
	        	console.log(data);
	        	
	        	var url = $("input[name='uploadUrl']").val();
	        	if(data.result > 0){
	        		$("#picture_ul").append($("<li>").attr("style", "background-image: url(" + data.url + ");"));
	        	}else{
	        		alert("업로드 실패");
	        	}
	            // $("#uploaded-files tr:has(td)").remove();
	            /*
	            $.each(data.result, function (index, file) {
	            	console.log(file);
	            	
	                $("#uploaded-files").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(file.fileName))
	                        .append($('<td/>').text(file.fileSize))
	                        .append($('<td/>').text(file.fileType))
	                        )//end $("#uploaded-files").append()
	                */
	            }); 
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
	<script src="<c:url value="/resources/js/jquery-1.9.1.min.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>