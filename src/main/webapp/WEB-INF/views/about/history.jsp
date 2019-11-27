<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				<img src="/resources/img/contents/history.jpg" style="display: none; width: 90%; max-width: 1000px; margin: 60px auto;">
				<div class="history_wrap">
					<div class="item">
						<div class="cont">
							<strong>2019</strong>
							<dl>
								<dt>01월</dt>
								<dd>제7회 동계 효소공학연구회 경주 심포지엄</dd>
							</dl>
							<dl>
								<dt>07월</dt>
								<dd>제8회 하계 효소공학연구회 속초 심포지엄</dd>
							</dl>
						</div>
						<div class="image"><img src="/resources/img/contents/history_2019.png" alt="2019"></div>
					</div>
					<div class="item">
						<div class="cont">
							<strong>2018</strong>
							<dl>
								<dt>02월</dt>
								<dd>제6회 동계 효소공학연구회 부산 심포지엄</dd>
							</dl>
							<dl>
								<dt>06월</dt>
								<dd>15th JCK-enzyme engineering conference, 일본 교토대</dd>
							</dl>
						</div>
						<div class="image"><img src="/resources/img/contents/history_2018.png" alt="2018"></div>
					</div>
					<div class="item">
						<div class="cont">
							<strong>2017</strong>
							<dl>
								<dt>02월</dt>
								<dd>제4회 동계 효소공학연구회 경주 심포지엄</dd>
							</dl>
							<dl>
								<dt>07월</dt>
								<dd>제5회 하계 효소공학연구회 광주 심포지엄</dd>
							</dl>
						</div>
						<div class="image"><img src="/resources/img/contents/history_2017.png" alt="2017"></div>
					</div>
					<div class="item">
						<div class="cont">
							<strong>2016</strong>
							<dl>
								<dt>02월</dt>
								<dd>제2회 동계 효소공학연구회 제주 심포지엄</dd>
							</dl>
							<dl>
								<dt>07월</dt>
								<dd>제3회 하계 효소공학연구회 여수 심포지엄</dd>
							</dl>
							<dl>
								<dt>11월</dt>
								<dd>14th CJK-enzyme engineering conference, 중국 난닝</dd>
							</dl>
						</div>
						<div class="image"><img src="/resources/img/contents/history_2016.png" alt="2016"></div>
					</div>
					<div class="item">
						<div class="cont">
							<strong>2015</strong>
							<dl>
								<dt>08월</dt>
								<dd>제1회 하계 효소공학연구회 부여 심포지엄</dd>
							</dl>
						</div>
						<div class="image"><img src="/resources/img/contents/history_2015.png" alt="2015"></div>
					</div>
					
				</div>
				
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>