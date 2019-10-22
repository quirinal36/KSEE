<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<script type="text/javascript">
function edit(id){
	window.location.replace($("input[name='edit-url']").val() + id);
}
function deletePopup(id){
	var url = $("input[name='del-url']").val();
	url = url + "/" + id;
	
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			url : url,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			if(json.result > 0){
				alert("삭제되었습니다.");
				window.location.reload();
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
				<div class="admin_title">팝업 관리</div>
				<table class="tbl1 td_center">
					<thead>
						<tr>
							<th>번호</th>
							<th>팝업 이름</th>
							<th>등록기간</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="item">
							<tr>
								<td>${item.id }</td>
								<td>${item.symposiumTitle }</td>
								<td>${item.startDate } ~ ${item.finishDate }</td>
								<td>
									<input type="button" value="수정" class="bt2 on" onclick="javascript:edit('${item.id}')">
									<input type="button" value="삭제" class="bt2" onclick="javascript:deletePopup('${item.id }')">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="bt_wrap">
					<a href="<c:url value="/admin/popup/insertForm"/>" class="bt1 on">팝업 등록</a>
					<input type="hidden" name="del-url" value="<c:url value="/admin/popup/delete"/>"/>
					<input type="hidden" name="edit-url" value="<c:url value="/admin/popup/editForm/"/>"/>
				</div>
				
				
			</div>
		</div>
	</div>
</div>
</body>
</html>