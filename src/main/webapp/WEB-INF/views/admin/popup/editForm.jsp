<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/popup.css"/>"/>
<script type="text/javascript">
$(document).ready(function(){
	var options = {
			"opens": 'left',
			"autoApply": true,
			 "minYear": 2019,
			 "locale": {
			        "format": "YYYY-MM-DD",
			        "separator": " - ",
			        "customRangeLabel": "Custom",
			        "weekLabel": "W",
			        "daysOfWeek": [
			            "일",
			            "월",
			            "화",
			            "수",
			            "목",
			            "금",
			            "토"
			        ],
			        "monthNames": [
			            "1월",
			            "2월",
			            "3월",
			            "4월",
			            "5월",
			            "6월",
			            "7월",
			            "8월",
			            "9월",
			            "10월",
			            "11월",
			            "12월"
			        ]
			 }
		};
	$('#symposium_date_btn').daterangepicker(
			options
			, function(start, end, label) {
				$(".date_chk").find("input[name='startDate']").val(start.format('YYYY-MM-DD'));
				$(".date_chk").find("input[name='finishDate']").val(end.format('YYYY-MM-DD'));
				$(".date_chk").find("input[name='period']").val(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
	});

	$('#imageupload').fileupload({
		imageCrop: true,
	    dataType: 'json',
	    done: function (e, data) {
	    	var file = data.result.file;
	    	
	    	$("#picture_ul").empty();
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
function submit(){
	if(confirm("저장 하시겠습니까?")){
		var url = $("form").attr("action");
		var param = $("form").serialize();
		
		var pictures = [];
		$("#picture_ul").find(".bt_del_img").each(function(i, item){
			pictures.push($(item).val());
		});
		param += "&pictures="+pictures.join(",");
		
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			if(json.result > 0){
				window.location.replace("/admin/popup");
			}else{
				alert(json.msg);
			}
		});
	}
}
</script>
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<!-- 여기부터 팝업 수정화면 -->
				<div class="admin_title">팝업 수정</div>
				<form action="/popup/edit" method="POST">
					<table class="tbl1">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th>팝업 이름</th>
								<td>
									<input type="text" placeholder="팝업 이름 입력" class="w90 ipt2" name="symposiumTitle" value="${popup.symposiumTitle }">
								</td>
								<th>등록기간</th>
								<td>
									<div class="date_chk">
										<input type="hidden" value="${popup.startDate }" name="startDate">
										<input type="hidden" value="${popup.finishDate }" name="finishDate">
										<input type="text" value="${popup.startDate } ~ ${popup.finishDate }" class="ipt_date" name="period" readonly="">
										<input type="button" value="${popup.startDate } - ${popup.finishDate }" class="bt_date_chk" id="symposium_date_btn">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="board_write_img popup_write_img" id="dropzone-img">
						<dl>
							<dt>사진</dt>
							<dd>
								<!-- 사진 목록 -->
								<ul id="picture_ul">
									<c:if test="${not empty photo}">
										<li style="background-image: url(${photo.url});">
											<input type="button" title="삭제" class="bt_del_img">
										</li>
									</c:if>
									<!-- 
									<li style="background-image: url(/resources/img/temp/3.png);">
										<input type="button" title="삭제" class="bt_del_img">
									</li>
									 -->
								</ul>
								<!-- 첨부하기 버튼 -->
								<input id="imageupload" type="file" name="files[]" accept="image/*" data-url="/upload/image" multiple="">
							    <div id="progress_img" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
							        <div class="progress-bar" style="width: 0%;"></div>
							    </div>
							</dd>
						</dl>
					</div>
					
					<p class="popup_img_guide">팝업 이미지의 사이즈는 624*337이며, 좌우 여백 90px이 확보되어야 합니다.</p>
					
					<div class="bt_wrap">
						<a href="javascript:void(0)" class="bt1 on" onclick="javascript:submit();">수정</a>
						<a href="history.go(-1)" class="bt1">취소</a>
					</div>
					<input type="hidden" name="id" value="${popup.id }"/>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>