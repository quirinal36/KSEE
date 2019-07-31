<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한국효소공학연구회</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/fonts/NotoSans.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/layout.css"/>">
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<h2 class="cont_title notice">공지사항</h2>
			<div class="board_write">
				<div class="board_write_title">
                    <div class="title">제목</div>
                    <div class="title_ipt"><input type="text" placeholder="제목 입력"></div>
                    <div class="writer">작성자</div>
                    <div class="writer_ipt"><input type="text" placeholder="작성자 입력"></div>
				</div>
				<div class="board_write_cont">
					<dl>
						<dt>내용</dt>
						<dd>
							<textarea placeholder="내용 입력"></textarea>
						</dd>
					</dl>
				</div>
				<div class="board_write_img">
					<dl>
						<dt>사진</dt>
						<dd>
							<!-- 사진 목록 -->
							<ul>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
								<li style="background-image: url(/resources/img/temp/3.png);">
									<input type="button" title="삭제" class="bt_del_img">
								</li>
							</ul>
							<!-- 사진등록 버튼 -->
							<input type="button" value="사진등록" class="bt2">
						</dd>
					</dl>
				</div>
				<div class="board_write_file">
					<dl>
						<dt>첨부파일</dt>
						<dd>
							<!-- 첨부파일 목록 -->
							<ul>
								<li>
									<span>2019 하계 중국 심포지움 안내파일.hwp</span>
									<input type="button" value="삭제" class="bt_del_file">
								</li>
								<li>
									<span>2019 하계 중국 심포지움 안내파일.pdf</span>
									<input type="button" value="삭제" class="bt_del_file">
								</li>
								<li>
									<span>2019 하계 중국 심포지움 안내파일.ppt</span>
									<input type="button" value="삭제" class="bt_del_file">
								</li>
							</ul>
							<!-- 첨부하기 버튼 -->
							<input type="button" value="첨부하기" class="bt2">
						</dd>
					</dl>
				</div>
				<div class="board_write_bt">
					<a href="#" class="bt1 on w100">등록</a>
					<a href="/notice" class="bt1 w100">취소</a>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>
