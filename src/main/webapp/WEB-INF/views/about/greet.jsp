<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
				<div class="greet_title">
					<div>
						<div>
							<span>Bio-based Economy의 핵심</span>
							<strong>효소공학연구회 회원님들께</strong>
						</div>
					</div>
				</div>
				<div class="greet_txt">
					안녕하십니까?<br>
					무더운 여름도 끝나고 이제 계절이 바뀌고 있다는 것을 느끼고 있습니다.<br><br>
					
					효소공학연구회가 창립된 지 어느덧 4년 가까이 되었습니다.<br> 
					그동안 회원 여러분들과 이사님들의 노고와 열정 덕분에 오늘의 연구회가 있게 되었습니다.<br> 
					다시 한번 감사의 말씀을 드립니다.<br><br>
					
					아시다시피 효소는 생명현상을 유지하는 가장 기본적인 분자이며 Bio-based Economy에서 가장 핵심적인 역할을 합니다.<br> 
					이런 관점에서 효소공학연구회는 효소의 기본적인 기능과 특성을 이해하고<br>
					이를 바탕으로 효소를 효과적으로 활용할 수 있는 기술에 대한 심도 있는 논의와 정보 교환을 위해 창립되었습니다.<br><br>
					
					매년 두 차례 개최된 심포지엄에서는 중요한 연구 주제에 대한 전문가들이 연구동향과 중요 이슈에 대한 강연을 해주셨고<br>
					참석자들과 향후 발전에 대한 논의를 하였습니다.<br>
					이를 통해 기존 학회와는 다른 형식의 연구회가 성공적으로 정착되었다고 자부합니다.<br><br>
					
					또한, 최근에는 연구회의 홈페이지를 새롭게 단장하여 회원 여러분들이 보다 신속하고 편리하게 의견을 교환하고 관련 소식을 접할 수 있도록 하였습니다.<br>
					효소공학 연구회가 새로운 도약을 시도할 시기가 되었습니다. 회원 여러분들의 적극적인 참여와 도움을 간곡히 부탁드립니다.<br>
					감사합니다.<br><br>
					
					<p class="writer">
						효소공학연구회 회장<br>
						<span>김학성</span>
					</p>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>