<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
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
					<div class="repl_wrap" style="display:none">
						<!-- 댓글 보기 -->
						<ol class="repl_list">
							<!-- 기본 -->
							<li>
								<div class="top">
									<span class="repl_writer">이형구</span>
									<span class="repl_date">(2019-10-08)</span>
									<input type="button" value="수정" class="bt_repl_edit">
									<input type="button" value="삭제" class="bt_repl_del">
								</div>
								<p class="repl_cont">효소 관련 뉴스나 중요 논문 게시를 자유게시판에서 하면 될 까요?</p>
							</li>
							<!-- 수정 눌렀을 때 -->
							<li>
								<div class="top">
									<span class="repl_writer">이형구</span>
									<span class="repl_date">(2019-10-08)</span>
								</div>
								<div class="repl_edit">
									<textarea placeholder="댓글을 입력하세요.">효소 관련 뉴스나 중요 논문 게시를 자유게시판에서 하면 될 까요?</textarea>
									<input type="button" value="수정" class="on">
									<input type="button" value="취소">
								</div>
							</li>
						</ol>
						<!-- 댓글 작성 -->
						<div class="repl_add">
							<textarea placeholder="댓글을 입력하세요."></textarea>
							<input type="button" value="등록" class="bt_repl_add">
						</div>
					</div>
					<div class="bt_wrap">
						<a href="<c:url value="${listUrl }"/>" class="bt1 on">목록</a> 
						<input type="hidden" name="edit_url" value="${edit_url }${board.id}" />
						<input type="hidden" name="del_url" value="${del_url }${board.id}" />
						<input type="hidden" name="list_url" value="${listUrl }" />
						<input type="hidden" value="${user.id }" />
						<input type="hidden" value="${board.writer }" />
						<c:if test="${user.id eq board.writer }">
							<input type="button" class="bt1 btn_edit" value="수정">
							<input type="button" class="bt1 btn_del" value="삭제">
						</c:if>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<input type="button" class="bt1 btn_del" value="삭제">
						</sec:authorize>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>