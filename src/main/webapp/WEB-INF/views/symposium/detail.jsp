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
			<c:import url="/inc/lnb_wrap"></c:import>
			<c:import url="/inc/contentsTitle"></c:import>
			<div class="board_view symposium">
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
						<c:choose>
							<c:when test="${tab eq 1}">
								<div class="symposium_intro">
									<div class="detail_title">
										<strong>행사개요</strong>
										<p>제8회 한국효소공학연구회 하계심포지엄에 여러분을 초대합니다.</p>
									</div>
									<div class="detail_cont">
										<div>
											<img src="/resources/img/contents/symposium/main_8th.png" style="width: 100%;" alt="제8회 한국효소공학연구회 심포지엄">
										</div>
										<div>
										
										</div>
									</div>
									<!--
									<div class="detail_title">
										<strong>투어안내</strong>
										<p>
											심포지엄 등록 양식으로 포스트 컨퍼런스 투어를 예약하세요.<br>
											컨퍼런스 후 투어요금 : ₩300,000
										</p>
									</div>
									<div class="detail_cont">
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
									 -->
								</div>
							</c:when>
							<c:when test="${tab eq 2}">
								<div class="detail_title">
									<strong>인사말</strong>
								</div>
								<div class="detail_cont">
									학회 회원 여러분!<br><br>
									1973년 창립된 본 학회는 그동안 우리나라의 미생물학과 생명공학 분야의 학술활동을 선도적으로 주도하여 왔으며, 현재, 약 7천명에 가까운 회원을 보유하고 있습니다. 우리 학회가 국내에서 이와 같은 대표적 위상을 갖는 규모와 수준을 갖게 성장한 것은 여러 선배님들과 동료 및 후배 회원님의 노력 덕분입니다. 저는 2019년도 제 39대 회장으로서 우리 학회의 지속적 발전을 위해 최선을 다하겠습니다. 저와 함께 봉사해주실 임원진, 간사진 그리고, 앞에 드러나지는 않지만 뒤에서 학회 발전을 위하여 물심양면으로 큰 도움을 주시는 회원 여러분께 깊은 감사를 드립니다.<br><br>
									현재 미생물·생명공학은 인접 유관 분야와의 학술적, 기술적 융합에 바탕을 둔 통합 방식으로 더욱 빠르게 발전하고 있습니다. 이에 맞춰, 본 학회는 기존의 학술 분야를 넘어 그 외연을 더욱 크게 확장할 수 있는 개방적 자세를 갖고 새로운 신융합 분야의 창출을 위한 장소가 될수 있어야 합니다. 그 노력의 일환으로 학회는 새로운 학술분과를 신설하고 새로운 분야를 받아들이는데 더 적극적인 노력을 기울일 것이며, 이러한 학술 활동을 최대한 지원할 것입니다. <br><br>
									2019년 학회 활동으로서 우선 1월 14일~16일에 걸쳐 용평에서 동계심포지움을 개최할 것이며, 정기학술대회는 6월 23일~25일 제주도에서 개최할 예정입니다. 특히, 우수한 연사진이 참여하는 학술대회를 계획 중이어서, 좋은 강연과 토론, 그리고, 이어지는 휴식을 즐길 수 있는 축제의 장이 되도록 할 것입니다. 그리고, 이어지는 생명공학연합회와 가을의 미생물학연합회에도 참여할 예정입니다. <br><br>
									우리 학회는 SCI급 학술지인 Journal of Microbiology and Biotechnology (JMB)와 SCOPUS 등재지인 Microbiology and Biotechnology Letters (MBL)을 보유하고 있습니다. 2019년부터 이 두 학술지를 각기 독립 운영하여 서로 다른 특성을 보유한 전문 학술지로 발전시켜 나아갈 계획입니다. 이를 위하여, JMB 편집위원장은 서강대 이규호 교수께서 계속 맡아주실 것이며, MBL 편집위원장은 경북대학교 이동건 교수께서 맡으실 예정입니다. 학술지 발전은 학회의 간판이 되는 주된 업무입니다. 각 학술지가 뚜렷한 정체성을 확립하고 그 해당 분야를 대표하는 전문지로 더욱 크게 발전해 나아갈 수 있는 발판이 이제 마련되었다고 봅니다. 이어지는 학술지의 고급화는 단기간의 사업이 아니라 지속적으로 진행되어야 하는 업무이므로 학회는 임원진과의 논의를 거쳐 편집위원회의 편집활동을 적극 지원할 계획입니다.<br><br> 
									우리 학회는 전통적으로 임원진으로 구성된 이사회에서 학회 운영에 관한 사항을 의결하고 평의원회의의 논의를 거쳐 총회에서 결정하며, 학회 운영을 간사장 중심의 간사진이 집행하는 특징을 갖고 있습니다. 따라서, 학계의 중견 연구자를 대표하는 간사장과 간사진의 역동성이 학회 발전의 큰 원동력이 되어 왔습니다. 2019년에 저와 함께 수고해주실 인하대학교의 김응수 간사장과 가톨릭대학교의 김필 총무, 그리고, 여러 간사께 깊은 감사를 드립니다. 우리 학회는 그동안 고비가 있을 때마다 그 어려움을 슬기롭게 극복해 왔습니다. 이는 회원간 그리고 선후배로 이어지는 상호 신뢰가 있었기 때문에 가능했다고 봅니다. 이와 같은 저력이 있는 학회이므로 2019년에도 우리 학회는 계속 발전해 나아가리라 확신합니다. 2019년 새해에 회원 여러분의 가정에 즐거움과 행복이 가득하시길 빌며, 앞으로도 많은 도움을 부탁드립니다. 
									감사합니다.
								</div>
							</c:when>
							<c:when test="${tab eq 3}">
								<div class="detail_title">
									<strong>조직위원회</strong>
								</div>
								<div class="detail_cont">
									<img src="/resources/img/contents/symposium/organization.png" alt="제8회 한국효소공학연구회 심포지엄">
								</div>
							</c:when>
							<c:when test="${tab eq 4}">
								<div class="detail_title">
									<strong>프로그램</strong>
								</div>
								<div class="detail_cont">
									<img src="/resources/img/contents/symposium/temp1.png" style="width: 100%;" alt="제8회 한국효소공학연구회 심포지엄">
								</div>
							</c:when>
							<c:when test="${tab eq 5}">
								<div class="detail_title">
									<strong></strong>
								</div>
								<div class="detail_cont">
									
								</div>
							</c:when>
							<c:when test="${tab eq 6}">
								<div class="detail_cont">
									<img style="width: 100%;" src="/resources/img/contents/symposium/temp2.png" alt="제8회 한국효소공학연구회 심포지엄">
								</div>
							</c:when>
							<c:when test="${tab eq 7}">
								<div class="detail_cont">
									<img style="width: 100%;" src="/resources/img/contents/symposium/temp3.png" alt="제8회 한국효소공학연구회 심포지엄">
								</div>
							</c:when>
							<c:when test="${tab eq 8}">
								<div class="detail_cont">
									<img style="width: 100%;" src="/resources/img/contents/symposium/temp4.png" alt="제8회 한국효소공학연구회 심포지엄">
								</div>
							</c:when>
							<c:when test="${tab eq 9}">
								<div class="detail_cont">
									<img style="width: 100%;" src="/resources/img/contents/symposium/temp5.png" alt="제8회 한국효소공학연구회 심포지엄">
								</div>
							</c:when>
							<c:when test="${tab eq 10}">
								<div class="detail_cont">
									<img style="width: 100%;" src="/resources/img/contents/symposium/temp6.png" alt="제8회 한국효소공학연구회 심포지엄">
								</div>
							</c:when>
						</c:choose>
					</div>
				</div>
				<div class="bt_wrap">
					<a href="<c:url value="/symposium/"/>" class="bt1 on">목록</a>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>
