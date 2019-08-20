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
			<div id="contentsPrint">
				<div class="error_wrap">
					<div>
						<div>
							<strong>404</strong>
							<p>
								페이지의 주소가 잘못되었거나 변경 혹은 삭제되어<br>
								요청하신 페이지를 찾을 수 없습니다.<br>
								입력하신 주소가 정확한지 다시 한번 확인해주시기 바랍니다.
							</p>
							<a href="#" class="bt1">HOME</a>
							<a href="#" onclick="history.back();" class="bt1 on">이전 페이지로 이동</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>