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
			${tab}
			
			<div class="board_view">
					<div class="board_view_title">
						<div class="title">2019 하계 중국 심포지엄</div>
						<div class="file">1</div>
						<div class="view">123</div>
					</div>
					<div class="board_view_tab">
						<div class="tab">
							<ul>
								<li><a href="<c:url value="/symposium/domestic/view/1/1"/>" <c:if test="${tab eq 1}">class="on"</c:if>>행사개요</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/2"/>" <c:if test="${tab eq 2}">class="on"</c:if>>인사말</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/3"/>" <c:if test="${tab eq 3}">class="on"</c:if>>조직위원회</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/4"/>" <c:if test="${tab eq 4}">class="on"</c:if>>프로그램</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/5"/>" <c:if test="${tab eq 5}">class="on"</c:if>>발표요강</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/6"/>" <c:if test="${tab eq 6}">class="on"</c:if>>등록 및 숙박</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/7"/>" <c:if test="${tab eq 7}">class="on"</c:if>>투어안내</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/8"/>" <c:if test="${tab eq 8}">class="on"</c:if>>후원</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/9"/>" <c:if test="${tab eq 9}">class="on"</c:if>>학회장소 및 교통</a></li>
								<li><a href="<c:url value="/symposium/domestic/view/1/10"/>" <c:if test="${tab eq 10}">class="on"</c:if>>문의</a></li>
							</ul>
						</div>
						<div class="cont">
							<div class="symposium_intro">
								<div class="title">
									<strong>행사개요</strong>
									<p>2019년 KSEE 중국 심포지엄에 여러분을 초대합니다.</p>
								</div>
								<div class="title">
									<strong>투어안내</strong>
									<p>
										심포지엄 등록 양식으로 포스트 컨퍼런스 투어를 예약하세요.<br>
										컨퍼런스 후 투어요금 : ₩300,000
									</p>
								</div>
								<div class="cont">
									<div class="cont_section">
										<div class="cont_title">
											참고사항
										</div>
										<div class="cont_txt">
											심포지엄 참가신청 시 투어프로그램 신청에 체크해주시면 신청이 완료됩니다.<br>
											예약은 선착순으로 처리되며 이용 가능한 좌석 수에 따라 심포지엄 장소에서 예약이 가능할 수 있습니다.<br>
											투어 프로그램은 주최측의 사정 또는 진행할 수 없는 불가피한 사유로 인해 변경 될 수 있습니다.<br>
											날짜 : 2019년 11월 15일(금)
										</div>
									</div>
									<div class="cont_section">
										<div class="cont_title">
											투어안내
										</div>
										<div class="cont_txt">
											<div class="tour_item">
												<img src="">
												<img src="">
												<img src="">
												<div class="tour_title">
													<strong>김광석 거리(김광석 다시 그리기 길)</strong>
													<a href="#" target="_blank">지도보기</a>
												</div>
												<p>
													김광석 다시 그리기 길은 차갑고 어두웠던 거리를 밝게 꾸미는 프로젝트인 방천시장 문전성시 프로젝트로 만들어진 대구의 거리입니다. ‘노래하는 철학자’ 김광석의 삶과 음악이 예술작품으로 거리 곳곳에 새겨졌는데요. 김광석의 삶과 노래를 주제로 그려진 벽화를 포함한 다양한 벽화를 볼 수 있고 거리에서는 김광석의 음악을 들을 수 있어요. 매월 김광석 거리 야외 콘서트홀에서 다양한 공연도 진행하고 있으니 거리에 울려 퍼지는 대구의 예술 감성을 느껴보는 것도 추천합니다.
												</p>
											</div>
											<div class="tour_item">
												<img src="">
												<img src="">
												<img src="">
												<div class="tour_title">
													<strong>향촌문학관 &amp; 대구문학관</strong>
													<a href="#" target="_blank">지도보기</a>
												</div>
												<p>
													대구 향촌문화관은 역사가 살아 숨 쉬는 향촌동에 자리했습니다. 향촌동은 1970년대까지 대구 최고의 상가지역이자 예술인들의 거리로 음악가와 화가 등 많은 예술가들이 열정을 쏟았던 곳인데요. 향촌문화관에서는 예술가들은 물론 당시 사람들의 생활과 추억을 엿볼 수 있습니다.
												</p>
											</div>
											<div class="tour_item">
												<img src="">
												<img src="">
												<img src="">
												<div class="tour_title">
													<strong>향촌문학관 &amp; 대구문학관</strong>
													<a href="#" target="_blank">지도보기</a>
												</div>
												<p>
													김광석 다시 그리기 길은 차갑고 어두웠던 거리를 밝게 꾸미는 프로젝트인 방천시장 문전성시 프로젝트로 만들어진 대구의 거리입니다. ‘노래하는 철학자’ 김광석의 삶과 음악이 예술작품으로 거리 곳곳에 새겨졌는데요. 김광석의 삶과 노래를 주제로 그려진 벽화를 포함한 다양한 벽화를 볼 수 있고 거리에서는 김광석의 음악을 들을 수 있어요. 매월 김광석 거리 야외 콘서트홀에서 다양한 공연도 진행하고 있으니 거리에 울려 퍼지는 대구의 예술 감성을 느껴보는 것도 추천합니다.
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
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
						<a href="<c:url value="/symposium/"/>" class="bt1 on">목록</a>
						<input type="button" class="bt1 popup_password_opener" value="수정">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
