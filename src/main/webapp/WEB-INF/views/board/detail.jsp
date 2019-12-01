<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% 
pageContext.setAttribute("LF", "\n"); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script src="https://cdn.ckeditor.com/4.11.3/standard-all/ckeditor.js"></script>
<script type="text/javascript">
function writeReply(){
	var url = $("#replyForm").attr("action");
	var param = $("#replyForm").serialize();
	var jsonObj = parse($("#replyForm").serializeArray());
	
	if(jsonObj['content'].length == 0){
		alert("댓글을 입력 해주세요.");
		return false;
	}
	if(confirm("댓글을 등록하시겠습니까?")){
		$.ajax({
			url : url,
			data: param,
			dataType : 'json',
			type : 'POST'
		}).done(function(json){
			if(json.result > 0){
				window.location.reload();
			}else{
				alert(json.msg);
			}
		});		
	}
}
function updateReply(replyId){
	var form = $("#reply-edit-"+replyId).find("form");
	var url = $(form).attr("action");
	var param = $(form).serialize();
	
	$.ajax({
		url : url,
		data: param,
		dataType : 'json',
		type : 'POST'
	}).done(function(json){
		if(json.result > 0){
			window.location.reload();
		}else{
			alert(json.msg);
		}
	});
}
function deleteReply(replyId){
	var url = "/reply/delete";
	var param = "id="+replyId;
	
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			url : url,
			data: param,
			dataType: 'json',
			type: 'POST'
		}).done(function(json){
			if(json.result > 0){
				window.location.reload();
			}
		});
	}
}
function showEditView(replyId){
	$("#reply-"+replyId).hide();
	$("#reply-edit-"+replyId).show();
}
function hideEditView(replyId){
	$("#reply-"+replyId).show();
	$("#reply-edit-"+replyId).hide();
}
function parse(data){
	var jsonObj = {};
	data.forEach(function(item, index, arr){
		var name = item.name;
		var value = item.value;
		
		jsonObj[name] = value;
	});
	return jsonObj;
}
$(document).ready(function(){
	$(".repl_content").on('keyup', function(e){
		if(e.keyCode == 13){
			e.preventDefault();
			var text = $(this).val().slice(0, -1);
			$(this).val(text);
			writeReply();
		}
	});
});
function deleteBoard(id){
	var url = "${del_url}"+id;
	
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			url : url,
			dataType: 'json',
			type: 'POST'
		}).done(function(json){
			if(json.result > 0){
				window.history.go(-1);
			}
		});
	}
}

</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<div class="board_view" style="margin-top: 60px;">
					<div class="board_view_title">
						<div class="title">${board.title }</div>
						<div class="writer">${board.writerName }</div>
						<div class="date">
							<fmt:formatDate value="${board.wdate}" pattern="yyyy-MM-dd" />
						</div>
						<div class="file">${fn:length(fileList) }</div>
						<div class="view">${board.viewCount}</div>
					</div>
					<div class="board_view_cont">
						<c:if test="${fn:length(photoList) > 0}">
							<div class="board_view_img">
								<c:forEach items="${photoList }" var="item">
									<img src="<c:url value="/picture/${item.id }"/>" alt="게시글 제목">
								</c:forEach>
							</div>
						</c:if>
						${board.content }
					</div>
					<c:if test="${fn:length(fileList) gt 0}">					
						<div class="board_view_file">
							<div class="title">첨부파일</div>
							<div class="file_list">
								<ul>
									<c:forEach items="${fileList }" var="item">
										<li><a href="<c:url value="/upload/get/${item.id }"/>">${item.name }</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</c:if>
					<div class="repl_wrap">
						<!-- 댓글 보기 -->
						<ol class="repl_list">
							<!-- 기본 -->
							<c:forEach items="${replyList }" var="reply">
								<li id="reply-${reply.id }">
									<div class="top">
										<span class="repl_writer">${reply.writerName }</span>
										<span class="repl_date">(<fmt:formatDate value="${reply.mdate}" pattern="yyyy-MM-dd" />)</span>
										<c:if test="${user.id eq reply.writer }">
											<input type="button" value="수정" class="bt_repl_edit" onclick="javascript:showEditView('${reply.id }');">
											<input type="button" value="삭제" class="bt_repl_del" onclick="javascript:deleteReply('${reply.id}')">
										</c:if>
										<input type="hidden" name="user-id" value="${user.id }"/>
									</div>
									<p class="repl_cont">${fn:replace(reply.content, LF, "<br/>") }</p>
								</li>
								
								<!-- 수정 눌렀을 때 -->
								<li id="reply-edit-${reply.id }" style="display:none;">
									<form action="<c:url value="/reply/update"/>" method="post">
										<div class="top">
											<span class="repl_writer">${reply.writerName }</span>
											<span class="repl_date">(<fmt:formatDate value="${reply.mdate}" pattern="yyyy-MM-dd" />)</span>
										</div>
										<div class="repl_edit">
											<textarea placeholder="댓글을 입력하세요." name="content" rows="1" class="repl_content">${reply.content }</textarea>
											<input type="hidden" name="id" value="${reply.id }"/>
											<input type="button" value="저장" class="on" onclick="javascript:updateReply('${reply.id}');">
											<input type="button" value="취소" onclick="javascript:hideEditView('${reply.id}')">
										</div>
									</form>
								</li>
							</c:forEach>
						</ol>
						<form id="replyForm" action="<c:url value="/reply/insert"/>" method="POST">
							<c:choose>
								<c:when test="${not empty user.id and locale.language eq 'en'}">
									<c:set value="input reply." var="reply_placeholder"/>
								</c:when>
								<c:when test="${not empty user.id and locale.language ne 'en'}">
									<c:set value="댓글을 입력하세요." var="reply_placeholder"/>
								</c:when>
								<c:when test="${empty user.id and locale.language eq 'en' }">
									<c:set value="login to write reply." var="reply_placeholder"/>
								</c:when>
								<c:otherwise>
									<c:set value="로그인 후 댓글을 작성하실 수 있습니다." var="reply_placeholder"/>
								</c:otherwise>
							</c:choose>
							<!-- 댓글 작성 -->
							<div class="repl_add">
								<input type="hidden" name="writer" value="${user.id }"/>
								<textarea placeholder="${reply_placeholder }" name="content" rows="1" class="repl_content" <c:if test="${empty user.id }">readonly</c:if>></textarea>
								<input type="button" value="<spring:message code="board.submit"/>" class="bt_repl_add" onclick="javascript:writeReply();"  <c:if test="${empty user.id }">disabled</c:if>>
							</div>
							<input type="hidden" name="parent" value="0"/>
							<input type="hidden" name="boardId" value="${board.id }"/>
						</form>
					</div>
					<div class="bt_wrap">
						<a href="<c:url value="${listUrl }"/>" class="bt1 on">
							<spring:message code="board.detail.list"/>
						</a> 
						<input type="hidden" name="edit_url" value="${edit_url }${board.id}" />
						<input type="hidden" name="del_url" value="${del_url }${board.id}" />
						<input type="hidden" name="list_url" value="${listUrl }" />
						<input type="hidden" value="${user.id }" />
						<input type="hidden" value="${board.writer }" />
						<c:choose>
							<c:when test="${user.id eq board.writer }">
								<input type="button" class="bt1 btn_edit" value="<spring:message code="board.detail.edit"/>" onclick="window.location.replace('${edit_url}/${board.id }')">
								<input type="button" class="bt1 btn_del" value="<spring:message code="board.detail.delete"/>" onclick="javascript:deleteBoard('${board.id}');">
							</c:when>
							<c:otherwise>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<input type="button" class="bt1 btn_del" value="<spring:message code="board.detail.delete"/>" onclick="javascript:deleteBoard('${board.id}');">
								</sec:authorize>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>