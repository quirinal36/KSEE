<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
</head>
<body>
	<div class="wrap">
		<c:import url="/inc/header"></c:import>
		<div class="container_wrap">
			<div class="container">
				<div class="board_view">
					<div class="board_view_title">
						<div class="title">${board.title }</div>
						<div class="writer">${board.writerName }</div>
						<div class="date">
							<fmt:formatDate value="${board.wdate}" pattern="yyyy-MM-dd" />
						</div>						
						<div class="file">${fn:length(fileList) }</div>					
						<div class="view">123</div>
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
						<a href="<c:url value="/group/"/>" class="bt1 on">목록</a>
						<input type="button" class="bt1 popup_password_opener" value="수정">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>