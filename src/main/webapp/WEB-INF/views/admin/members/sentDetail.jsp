<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head_admin"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/list.js"/>"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<div class="admin_title">${title }</div>
				<!-- 보낸 메일함 -->
				<div class="mail_wrap">
					<table class="tbl1">
						<tbody>
							<tr>
								<th>보내는 사람</th>
								<td>한국효소공학연구회(admin@ksee.kr)</td>
							</tr>
							<tr>
								<th>받는 사람</th>
								<td>유단아(with_i5@nate.com), 유단아(with_i5@naver.com), 유단아(with_i5@daum.net)</td>
							</tr>
							<tr class="title">
								<th>제목</th>
								<td>한국효소공학연구회입니다.</td>
							</tr>
							<tr class="cont">
								<td colspan="2">안녕하세요. 효소공학연구회입니다.</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td><a href="파일다운로드링크">인사말.png</a></td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="#" class="bt1 on">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>