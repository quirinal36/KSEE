<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>${title }</title>
	<c:import url="/inc/head_admin"></c:import>
	<style>
		
	</style>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/symposium.js"/>"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		// var end = moment();
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
			$(".date_chk_symposium").find("input[name='startDate']").val(start.format('YYYY-MM-DD'));
			$(".date_chk_symposium").find("input[name='finishDate']").val(end.format('YYYY-MM-DD'));
			$(".date_chk_symposium").find("input[name='period']").val(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
		});
		
		$('#apply_date_btn').daterangepicker(
				options
		, function(start, end, label) {
			$(".date_chk_apply").find("input[name='applyStart']").val(start.format('YYYY-MM-DD'));
			$(".date_chk_apply").find("input[name='applyFinish']").val(end.format('YYYY-MM-DD'));
			$(".date_chk_apply").find("input[name='period']").val(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
		});
	});
	
	function deleteSymposium(){
		var url = $("input[name='deleteUrl']").val();
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				url : url,
				dataType: 'json',
				type : 'POST'
			}).done(function(json){
				if(json.result> 0){
					alert("삭제되었습니다.");
					history.go(-1);
				}
			});
		}
	}
	
	function updateSymposium(){
		var url = $("input[name='updateUrl']").val();
		if(confirm("수정하시겠습니까?")){
			var param = $("form").serialize();
			$.ajax({
				url : url,
				data : param,
				dataType: 'json',
				type : 'POST'
			}).done(function(json){
				if(json.result> 0){
					alert("완료되었습니다.");
					history.go(-1);
				}
			});
		}
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
				<div class="admin_title">학술대회 등록</div>
				
				<form action="<c:url value="/admin/${where }/write"/>" method="POST">
					<input type="hidden" name="listUrl" value="${listUrl }"/>
					<table class="tbl1">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th>행사명</th>
								<td>
									<input type="text" placeholder="행사명 입력" class="w90 ipt2" name="title" value="${symposium.title }">
								</td>
								<th>장소</th>
								<td>
									<input type="text" placeholder="장소 입력" class="w90 ipt2" name="place" value="${symposium.place }">
								</td>
							</tr>
							<tr>
								<th>행사명(영문)</th>
								<td>
									<input type="text" placeholder="행사명 입력" class="w90 ipt2" name="title_en" value="${symposium.title_en }">
								</td>
								<th>장소(영문)</th>
								<td>
									<input type="text" placeholder="장소 입력" class="w90 ipt2" name="place_en" value="${symposium.place_en }">
								</td>
							</tr>
							<tr>
								<th>행사기간</th>
								<td>
									<div class="date_chk date_chk_symposium">
										<input type="hidden" value="${symposium.startDate }" name="startDate"/>
										<input type="hidden" value="${symposium.finishDate }" name="finishDate"/>
										<input type="text" value="${symposium.startDate } ~ ${symposium.finishDate }" class="ipt_date" name="period" readonly>
										<input type="button" value="날짜 선택" class="bt_date_chk" id="symposium_date_btn">
									</div>
								</td>
								<th>접수기간</th>
								<td>
									<div class="date_chk date_chk_apply">
										<input type="hidden" value="${symposium.applyStart }" name="applyStart"/>
										<input type="hidden" value="${symposium.applyFinish }" name="applyFinish"/>
										<input type="text" value="${symposium.applyStart } ~ ${symposium.applyFinish }" class="ipt_date" name="period" readonly>
										<input type="button" value="날짜 선택" class="bt_date_chk" id="apply_date_btn">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap mb-60">
						<c:if test="${empty symposium }">
							<a href="javascript:void(0);" class="bt1" onclick="javascript:registSymposium();">등록</a>
						</c:if>
						<c:if test="${not empty symposium }">
							<input type="hidden" name="deleteUrl" value="<c:url value="/admin/symposium/delete/${symposium.id }"/>"/>
							<input type="hidden" name="updateUrl" value="<c:url value="/admin/symposium/update/${symposium.id }"/>"/>
							<input type="hidden" name="id" value="${symposium.id }"/>
							<a href="javascript:void(0);" class="bt1" onclick="javascript:updateSymposium();">수정</a>
							<a href="javascript:void(0);" class="bt1" onclick="javascript:deleteSymposium();">삭제</a>
						</c:if>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>