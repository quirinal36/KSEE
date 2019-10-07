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
				<table class="tbl2">
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="20%">
						<col width="40%">
					</colgroup>
					<thead>
						<tr>
							<th>직책</th>
							<th>성명</th>
							<th>소속</th>
							<th>기타</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>회장</td>
							<td>김학성</td>
							<td>KAIST</td>
							<td></td>
						</tr>
						<tr>
							<td>총무</td>
							<td>박성훈</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td rowspan="8">이사</td>
							<td>이승구</td>
							<td>KRIBB</td>
							<td></td>
						</tr>
						<tr>
							<td>김용환</td>
							<td>UNIST</td>
							<td></td>
						</tr>
						<tr>
							<td>김경진</td>
							<td>경북대</td>
							<td></td>
						</tr>
						<tr>
							<td>김형권</td>
							<td>가톨릭대</td>
							<td></td>
						</tr>
						<tr>
							<td>권인찬</td>
							<td>GIST</td>
							<td></td>
						</tr>
						<tr>
							<td>김정선</td>
							<td>전남대</td>
							<td></td>
						</tr>
						<tr>
							<td>이동선</td>
							<td>제주대</td>
							<td></td>
						</tr>
						<tr>
							<td>박진병</td>
							<td>이화여대</td>
							<td></td>
						</tr>
						<tr>
							<td rowspan="6">운영위원</td>
							<td>염수진</td>
							<td>전남대</td>
							<td></td>
						</tr>
						<tr>
							<td>주정찬</td>
							<td>KRICT</td>
							<td></td>
						</tr>
						<tr>
							<td>연영주</td>
							<td>강릉원주</td>
							<td></td>
						</tr>
						<tr>
							<td>이대희</td>
							<td>KRIBB</td>
							<td></td>
						</tr>
						<tr>
							<td>이동우</td>
							<td>연새대</td>
							<td></td>
						</tr>
						<tr>
							<td>이선구</td>
							<td>부산대</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>