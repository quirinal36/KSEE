<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한국효소공학연구회</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/fonts/NotoSans.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/layout.css"/>"/>
</head>
<body>
<div id="wrap">
	<div id="header_wrap">
		<div class="top_line">
			<div class="left"></div>
			<div class="right"></div>
		</div>
		<div id="header">
			<div class="logo">
				<h1><a href="/"><img src="<c:url value="/resources/img/comm/logo.png"/>" alt="한국효소공학연구회"></a></h1>
			</div>
			<div class="gnb_wrap">
				<ul>
					<li><a href="<c:url value="/company"/>">연구회소개</a></li>
					<li><a href="<c:url value="/notice"/>">공지사항</a></li>
					<li><a href="<c:url value="/symposium"/>">심포지움</a></li>
					<li><a href="<c:url value="/information"/>">정보광장</a></li>
					<li><a href="<c:url value="/picture"/>">사진뉴스</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="container_wrap">
		<div id="container">
			<h2 class="cont_title notice">공지사항</h2>
			<div class="board_write">
				<div class="board_write_title">
                    <div class="title">제목</div>
                    <div class="title_ipt"><input type="text" placeholder="제목 입력" value="2019 하계 중국 심포지움"></div>
                    <div class="writer">작성자</div>
                    <div class="writer_ipt"><input type="text" placeholder="작성자 입력" value="이승구"></div>
				</div>
				<div class="board_write_cont">
					<dl>
						<dt>내용</dt>
						<dd>
<textarea placeholder="내용 입력">
과학
보편적인 진리나 법칙의 발견을 목적으로 한 체계적인 지식. 넓은 뜻으로는 학(學)을 이르고, 좁은 뜻으로는 자연 과학을 이른다.
</textarea>
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
					<a href="/board_view" class="bt1 w100">취소</a>
				</div>
			</div>
		</div>
	</div>
	<div id="footer_wrap">
		<div class="footer">
			<ul>
				<li>사단법인 한국효소공학연구회</li>
				<li>대전광역시 유성구 대학로 291, 생명과학과 3201호(구성동, 한국과학기술원)</li>
				<li>대표이사 : 김학성</li>
			</ul>
			<p>COPYRIGHT <span>KSEE</span>. ALL RIGHTS RESERVED.</p>
		</div>
	</div>
</div>
</body>
</html>
