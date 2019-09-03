<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
						<div class="title">2019 하계 중국 심포지움</div>
						<div class="writer">이승구</div>
						<div class="date">2019-08-11</div>						
						<div class="file">1</div>					
						<div class="view">123</div>
					</div>
					<div class="board_view_cont">
						<div class="board_view_img">
							<img src="/resources/img/temp/2.png" alt="게시글 제목">
						</div>
						과학<br>
						보편적인 진리나 법칙의 발견을 목적으로 한 체계적인 지식. 넓은 뜻으로는 학(學)을 이르고, 좁은 뜻으로는 자연 과학을 이른다.
					</div>
					<div class="board_view_file">
						<div class="title">첨부파일</div>
						<div class="file_list">
							<ul>
								<li><a href="#">2019 하계 중국 심포지움 안내파일.hwp</a></li>
								<li><a href="#">2019 하계 중국 심포지움 안내파일.pdf</a></li>
								<li><a href="#">2019 하계 중국 심포지움 안내파일.ppt</a></li>
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