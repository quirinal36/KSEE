<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/notice.js"/>"></script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap"></c:import>
			<c:import url="/inc/contentsTitle"></c:import>
			<div id="contentsPrint">
				<div class="board_search">
					<div class="search_ipt">
						<input type="text" placeholder="검색어를 입력하세요.">
						<input type="button" value="검색">
					</div>
				</div>
				<div class="search_result_message">
					<p><span>“연구회”</span> 검색 결과입니다.</p>
				</div>
				
				<div class="board_list board_list_typeA">
					<ul>
						<c:forEach begin="0" end="9" step="1">
							<li>
								<a href="<c:url value="/group/notice/view/121"/>">
									<div class="top">
										<span class="num">No. 121</span>
										<span class="file">1</span>
										<span class="view">123</span>
									</div>
									<div class="cont">
										<strong class="title">한국효소공학연구회 공지사항입니다.</strong>
										<div class="info">
											<span class="writer">이승구</span>
											<span class="date">2019-08-11</span>
										</div>								   
										<p class="content">한국효소공학연구회 공지사항입니다. 한국효소공학연구회 공지사항입니다. 한국효소공학연구회 공지사항입니다.</p>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
					<div class="page">
						<a href="#" class="bt first">맨 처음 페이지로 가기</a>
						<a href="#" class="bt prev">이전 페이지로 가기</a>
						<a href="#" class="num on">1</a>
						<a href="#" class="num">2</a>
						<a href="#" class="num">3</a>
						<a href="#" class="bt next">다음 페이지로 가기</a>
						<a href="#" class="bt last">마지막 페이지로 가기</a>
					</div>
					<div class="bt_wrap">
						<input type="hidden" name="write_url" value="<c:url value="/group/notice/write"/>"/>
						<input type="button" class="bt1 bt_write popup_password_opener" value="글쓰기">
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>