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
							<strong>503</strong>
							<p>
								서버에 일시적인 오류가 있습니다.<br>
								문제가 계속 발생하는 경우 관리자에게 문의해주세요.
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