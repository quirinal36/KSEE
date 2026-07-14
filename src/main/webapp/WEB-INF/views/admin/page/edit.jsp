<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>${title }</title>
	<c:import url="/inc/head_admin"></c:import>
	<script type="text/javascript" src="<c:url value="/resources/js/service/HuskyEZCreator.js"/>" charset="utf-8"></script>
	<style>
		.pc_mode { margin:12px 0; }
		.pc_mode label { margin-right:20px; cursor:pointer; }
		#fileSection .file_preview { margin-top:12px; }
		#fileSection .file_preview img { max-width:100%; border:1px solid #ddd; }
		.pc_help { color:#888; font-size:13px; margin:6px 0 12px; }
	</style>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<div class="admin_title">페이지 관리 - ${pageTitle }</div>

				<%-- 에디터 초기 내용(안전하게 escape 되어 담김; JS 에서 value 로 읽어 PASTE_HTML) --%>
				<textarea id="init_content" style="display:none;"><c:out value="${content.content }"/></textarea>

				<form id="pageForm" action="<c:url value='/admin/page/save'/>" method="post" onsubmit="return false;">
					<input type="hidden" name="pageKey" value="${pageKey }"/>
					<input type="hidden" name="fileId" id="fileId" value="${content.fileId }"/>
					<input type="hidden" name="fileType" id="fileType" value="${content.fileType }"/>

					<div class="pc_mode">
						<strong>표시 방식:</strong>
						<label><input type="radio" name="viewType" value="HTML"
							<c:if test="${empty content.viewType or content.viewType ne 'FILE'}">checked</c:if>> 에디터로 작성</label>
						<label><input type="radio" name="viewType" value="FILE"
							<c:if test="${content.viewType eq 'FILE'}">checked</c:if>> 이미지/PDF 파일 업로드</label>
					</div>

					<!-- 에디터 모드 -->
					<div id="htmlSection">
						<p class="pc_help">글 작성 후 [저장]을 누르면 공개 페이지에 바로 반영됩니다. 에디터 안에서 이미지도 삽입할 수 있습니다.</p>
						<textarea name="content" id="ir1" rows="10" style="width:100%; height:412px;"></textarea>
					</div>

					<!-- 파일 모드 -->
					<div id="fileSection" style="display:none;">
						<p class="pc_help">이미지(JPG/PNG 등) 또는 PDF 파일을 올리면 공개 페이지가 해당 파일을 표시합니다.</p>
						<input type="file" id="fileInput" accept="image/*,application/pdf">
						<div class="file_preview" id="filePreview">
							<c:if test="${content.viewType eq 'FILE' and not empty content.fileId}">
								<c:choose>
									<c:when test="${content.fileType eq 'IMAGE'}">
										<img src="<c:url value='/picture/${content.fileId}'/>" alt="현재 이미지">
									</c:when>
									<c:otherwise>
										<a href="<c:url value='/upload/get/${content.fileId}'/>" target="_blank">현재 PDF 보기</a>
									</c:otherwise>
								</c:choose>
							</c:if>
						</div>
					</div>

					<div class="bt_wrap mb-60" style="margin-top:20px;">
						<a href="javascript:savePage();" class="bt1 on">저장</a>
						<a href="<c:url value='/admin/page/'/>" class="bt1">취소</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var oEditors = [];
var sLang = "ko_KR";

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "<c:url value='/seSkin'/>",
	htParams : {
		bUseToolbar : true,
		bUseVerticalResizer : true,
		bUseModeChanger : true,
		I18N_LOCALE : sLang
	},
	fOnAppLoad : function(){
		var initHtml = document.getElementById('init_content').value;
		if(initHtml && initHtml.length > 0){
			oEditors.getById["ir1"].exec("PASTE_HTML", [initHtml]);
		}
	},
	fCreator: "createSEditor2"
});

function toggleSections(){
	var v = $('input[name="viewType"]:checked').val();
	if(v === 'FILE'){
		$('#htmlSection').hide();
		$('#fileSection').show();
	}else{
		$('#htmlSection').show();
		$('#fileSection').hide();
	}
}

function savePage(){
	var viewType = $('input[name="viewType"]:checked').val();
	if(viewType === 'HTML'){
		// 에디터 내용 -> textarea 동기화
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	}else{
		if(!$('#fileId').val()){
			alert('이미지 또는 PDF 파일을 업로드하세요.');
			return;
		}
	}
	if(!confirm('저장할까요?')) return;

	$.ajax({
		url : $('#pageForm').attr('action'),
		data : $('#pageForm').serialize(),
		type : 'POST',
		dataType : 'json'
	}).done(function(json){
		if(json.result >= 0){
			alert('저장되었습니다.');
			location.href = "<c:url value='/admin/page/'/>";
		}else{
			alert(json.msg || '저장에 실패했습니다.');
		}
	}).fail(function(){
		alert('저장 중 오류가 발생했습니다.');
	});
}

$(function(){
	$('input[name="viewType"]').on('change', toggleSections);
	toggleSections();

	$('#fileInput').on('change', function(){
		var f = this.files[0];
		if(!f) return;
		var isImage = f.type.indexOf('image/') === 0;
		var isPdf = (f.type === 'application/pdf') || /\.pdf$/i.test(f.name);
		if(!isImage && !isPdf){
			alert('이미지 또는 PDF 파일만 업로드할 수 있습니다.');
			this.value = '';
			return;
		}
		var endpoint = isImage ? "<c:url value='/upload/image'/>" : "<c:url value='/upload/file'/>";
		var fd = new FormData();
		fd.append('file', f);

		$.ajax({
			url : endpoint,
			type : 'POST',
			data : fd,
			processData : false,
			contentType : false,
			dataType : 'json'
		}).done(function(res){
			if(res && res.file && res.file.id){
				$('#fileId').val(res.file.id);
				$('#fileType').val(isImage ? 'IMAGE' : 'PDF');
				if(isImage){
					$('#filePreview').html($('<img>').attr('src', res.file.url));
				}else{
					$('#filePreview').html($('<a>').attr('href', res.url || res.file.url).attr('target','_blank').text(f.name + ' (PDF)'));
				}
			}else{
				alert('업로드에 실패했습니다.');
			}
		}).fail(function(){
			alert('업로드 중 오류가 발생했습니다.');
		});
	});
});
</script>
</body>
</html>
