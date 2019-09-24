<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
	<script type="text/javascript" src="<c:url value="/resources/js/boardDetail.js"/>"></script>
</head>
<body>
<div class="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div class="board_view" style="margin-top:60px;">
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
					<div class="board_view_img">
						<c:forEach items="${photoList }" var="item">
							<img src="/picture/${item.id }" alt="게시글 제목">
						</c:forEach>
					</div>
					${board.content }
				</div>
				<div class="board_view_file">
					<div class="title">첨부파일</div>
					<div class="file_list">
						<ul>
							<c:forEach items="${fileList }" var="item">
								<li><a href="/upload/get/${item.id }">${item.name }</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="bt_wrap">
					<a href="${listUrl }" class="bt1 on">목록</a>
					<input type="hidden" name="edit_url" value="${edit_url }${board.id}"/>
					<input type="button" class="bt1 btn_edit" value="수정">
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>