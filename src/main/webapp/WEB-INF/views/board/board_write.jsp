<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한국효소공학연구회</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/fonts/NotoSans.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/layout.css"/>">
<script src="https://cdn.ckeditor.com/4.11.3/standard-all/ckeditor.js"></script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<h2 class="cont_title notice">공지사항</h2>
			<div class="board_write">
				<div class="board_write_title">
                    <div class="title">제목</div>
                    <div class="title_ipt"><input type="text" placeholder="제목 입력"></div>
                    <div class="writer">작성자</div>
                    <div class="writer_ipt"><input type="text" placeholder="작성자 입력"></div>
				</div>
				<div class="board_write_cont">
					<dl>
						<dt>내용</dt>
						<dd>
							<textarea name="editor1" id="editor1" rows="30" cols="80">
                            </textarea>
                            <script>
			                // Replace the <textarea id="editor1"> with a CKEditor
			                // instance, using default configuration.
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
						</dd>
					</dl>
				</div>
				<div class="board_write_img">
					<dl>
						<dt>사진</dt>
						<dd>
							<!-- 사진 목록 -->
							<ul>
								<!-- 
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								 -->
							</ul>
							<!-- 사진등록 버튼 -->
							<input id="fileupload" type="file" name="files[]" 
								accept="image/x-png,image/gif,image/jpeg" data-url="<c:url value="/upload"/>" multiple>
						    <div id="progress">
						        <div style="width: 0%;"></div>
						    </div>
						    <table id="uploaded-files">
						    	<thead>
						    		<tr>
										<th colspan="3">사진업로드</th>
									</tr>
								</thead>
								<tbody>
							        <tr>
							            <th>파일명</th>
							            <th>Size</th>
							            <th>Type</th>
							        </tr>
						        </tbody>
						    </table>
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
								<li>
									<span>2019 하계 중국 심포지움 안내파일.pdf</span>
									<input type="button" value="삭제" class="bt_del_file">
								</li>
								<li>
									<span>2019 하계 중국 심포지움 안내파일.ppt</span>
									<input type="button" value="삭제" class="bt_del_file">
								</li>
							</ul>
							<!-- 첨부하기 버튼 -->
							<input type="button" value="첨부하기" class="bt2">
						</dd>
					</dl>
				</div>
				<div class="board_write_bt">
					<a href="#" class="bt1 on w100">등록</a>
					<a href="/notice" class="bt1 w100">취소</a>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
<script type="text/javascript">
	$(function () {
	    $('#fileupload').fileupload({
	    	imageCrop: true,
	        dataType: 'json',
	        done: function (e, data) {
	        	var url = $("input[name='uploadUrl']").val();
	        	
	            $("#uploaded-files tr:has(td)").remove();
	            $.each(data.result, function (index, file) {
	                $("#uploaded-files").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(file.fileName))
	                        .append($('<td/>').text(file.fileSize))
	                        .append($('<td/>').text(file.fileType))
	                        )//end $("#uploaded-files").append()
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
