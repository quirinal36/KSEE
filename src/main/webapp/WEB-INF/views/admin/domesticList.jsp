<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<style>
	
</style>
<script type="text/javascript">
function downloadAllFiles(sympId){
	window.location.replace("/admin/apply/list/"+sympId+"/download");
}
function downloadExcel(sympId){
	window.location.replace("/admin/apply/list/"+sympId+"/excel");
}
function changeStatus(dest){
	var ids = new Array();
	
	$(".applyChk").each(function(){
		if($(this).is(":checked") ){
			ids.push($(this).val());
		}
	});
	
	var param = "status="+dest;
	param += "&ids="+ids.join(",");
	
	var url = "/admin/apply/change";
	
	if(confirm("상태를 변경하시겠습니까?")){
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			alert("변경이 완료되었습니다.");
			if(json.result > 0){
				window.location.reload();
			}
		});
	}
}

$(document).ready(function(){
	$("#chk0").change(function(){
		var isChecked = $(this).is(":checked");
		$(".chk1").each(function(){
			$(this).prop("checked", isChecked);
		});
	});
});
</script>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<div>
					<div class="admin_title">${title}</div>
					<div class="admin_search">
						<form action="<c:url value="/admin/apply/list/${sympId }"/>">
							<input type="text" placeholder="검색어를 입력하세요." value="${paging.query }" name="query">
							<input type="submit" value="검색">
						</form>
					</div>
					
					<table class="tbl1 td_center">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="chk0" class="chk1">
									<label for="chk0"></label>
								</th>
								<th>상태</th>
								<th>신청일</th>
								<th>구분</th>
								<th>발표자</th>
								<th>국적</th>
								<th>이름</th>
								<th>소속</th>
								<th>직위</th>
								<th>연락처</th>
								<th>이메일 주소</th>
								<th>초록</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${applyList }" var="item" varStatus="sts">
								<tr>
									<td>
										<input type="checkbox" id="chk${sts.count }" class="chk1 applyChk" value="${item.id }">
										<label for="chk${sts.count }"></label>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.status eq 1}">접수 중</c:when>
											<c:when test="${item.status eq 2}">접수완료</c:when>
											<c:when test="${item.status eq 3}">취소완료</c:when>
										</c:choose>
									
									</td>
									<td><fmt:formatDate value="${item.mdate}" pattern="yyyy-MM-dd" /></td>
									<td>
										<c:choose>
											<c:when test="${item.memberType eq 2 }">일반</c:when>
											<c:when test="${item.memberType eq 3 }">기업</c:when>
											<c:when test="${item.memberType eq 4 }">학생</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.isSpeaker eq 1}">O</c:when>
											<c:otherwise>X</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.national eq 1 }">대한민국</c:when>
											<c:when test="${item.national eq 2 }">중국</c:when>
											<c:when test="${item.national eq 2 }">일본</c:when>
										</c:choose>
									</td>
									<td>${item.username }</td>
									<td>${item.classification }</td>
									<td>${item.level }</td>
									<td>${item.telephone }</td>
									<td>${item.email }@${item.domain }</td>
									<td>
										<c:if test="${item.fileId > 0 }">
											<a href="<c:url value="/upload/get/${item.fileId }"/>">
												<img src="/resources/img/board/board_file.png" alt="다운로드">
											</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="javascript:changeStatus(1);" class="bt1">접수 중으로 변경</a>
						<a href="javascript:changeStatus(2);" class="bt1 on" >접수완료로 변경</a>
						<a href="javascript:changeStatus(3);" class="bt1">신청취소</a>
						<a class="bt1" href="javascript:downloadExcel('${sympId}');">전체 엑셀파일로 저장</a>
						<a class="bt1" href="javascript:downloadAllFiles('${sympId}');">초록 일괄다운로드</a>
						<a class="bt1" href="javascript:history.go(-1)">이전</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>