<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>${title }</title>
	<c:import url="/inc/head_admin"></c:import>
	<style>
	
	</style>
	<script type="text/javascript">
	function showEditContent(id, lang){
		$("#write_form").find("input[name='id']").val(id);
		$("#write_form").find("input[name='lang']").val(lang);
		
		window.open("/admin/domestic/write/content/"+id+"/"+lang+"/${symposium.id}", "_blank");
	}
	function deleteSymposium(){
		var url = $("input[name='deleteUrl']").val();
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				url : url,
				dataType: 'json',
				type : 'POST'
			}).done(function(json){
				if(json.result> 0){
					alert("삭제되었습니다.");
					history.go(-1);
				}
			});
		}
	}
	</script>
</head>
<body>
	<div id="wrap">
	<c:import url="/inc/header_admin"></c:import>
	<div id="container_wrap">
		<c:import url="/admin/sidebar"></c:import>
		<div id="container">
			<div id="contentsPrint">
				<div>
					<div class="admin_title">학술대회 등록</div>
					<table class="tbl1">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th>행사명</th>
								<td>
									${symposium.title }
								</td>
								<th>장소</th>
								<td>
									${symposium.place }
								</td>
							</tr>
							<tr>
								<th>행사명(영문)</th>
								<td>
									${symposium.title_en }
								</td>
								<th>장소(영문)</th>
								<td>
									${symposium.place_en }
								</td>
							</tr>
							<tr>
								<th>행사기간</th>
								<td>
									${symposium.startDate } ~ ${symposium.finishDate }
								</td>
								<th>접수기간</th>
								<td>
									${symposium.applyStart } ~ ${symposium.applyFinish }
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div>
					<div class="admin_title">학술대회 상세내용</div>
					<table class="tbl1 mb-60">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<c:forEach items="${types }" begin="0" end="${fn:length(types)/2 - 1}" varStatus="sts">
								<c:set value="${types[sts.index].id}" var="type1"/>
								<c:set value="${types[fn:length(types)/2 + sts.index].id}" var="type2"/>
								
								<c:forEach items="${details }" var="detail">
									<c:choose>
										<c:when test="${detail.stype eq sts.count or detail.stype eq sts.count+5}">
											<c:if test="${detail.stype eq sts.count and detail.lang eq 'ko_KR' }">
												<c:set var="exist1" value="true"/>
											</c:if>
											<c:if test="${detail.stype eq sts.count and detail.lang eq 'en_US' }">
												<c:set var="exist2" value="true"/>
											</c:if>
											<c:if test="${detail.stype eq sts.count+5 and detail.lang eq 'ko_KR' }">
												<c:set var="exist3" value="true"/>
											</c:if>
											<c:if test="${detail.stype eq sts.count+5 and detail.lang eq 'en_US' }">
												<c:set var="exist4" value="true"/>
											</c:if>
										</c:when>
										<c:otherwise>
										
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<tr>
									<th>${types[sts.index].title }</th>
									<td>
										<a href="javascript:void(0);" class="bt2 <c:if test="${exist1 eq true }">on</c:if>" onclick="javascript:showEditContent(${type1}, 'ko_KR')">
											<c:choose>
												<c:when test="${exist1 eq true }">
													국문 수정
												</c:when>
												<c:otherwise>
													국문 작성
												</c:otherwise>
											</c:choose>
										</a>
										<a href="javascript:void(0);" class="bt2 <c:if test="${exist2 eq true }">on</c:if>" onclick="javascript:showEditContent(${type1}, 'en_US')">
											<c:choose>
												<c:when test="${exist2 eq true }">
													영문 수정
												</c:when>
												<c:otherwise>
													영문 작성
												</c:otherwise>
											</c:choose>
										</a>
									</td>
									<th>${types[fn:length(types)/2 + sts.index].title }</th>
									<td>
										<a href="javascript:void(0);" class="bt2 <c:if test="${exist3 eq true }">on</c:if>" onclick="javascript:showEditContent(${type2}, 'ko_KR')">
											<c:choose>
												<c:when test="${exist3 eq true }">
													국문 수정
												</c:when>
												<c:otherwise>
													국문 작성
												</c:otherwise>
											</c:choose>
										</a>
										<a href="javascript:void(0);" class="bt2 <c:if test="${exist4 eq true }">on</c:if>" onclick="javascript:showEditContent(${type2}, 'en_US')">
											<c:choose>
												<c:when test="${exist4 eq true }">
													영문 수정
												</c:when>
												<c:otherwise>
													영문 작성
												</c:otherwise>
											</c:choose>
										</a>
									</td>
								</tr>
								<c:set var="exist1" value="false"/>
								<c:set var="exist2" value="false"/>
								<c:set var="exist3" value="false"/>
								<c:set var="exist4" value="false"/>
							</c:forEach>
						</tbody>
					</table>
					
					<div class="bt_wrap">
						<input type="hidden" name="deleteUrl" value="<c:url value="/admin/symposium/delete/${symposium.id }"/>"/>
						<a href="<c:url value="/admin/${where }/write/${symposium.id }"/>" class="bt1">수정</a>
						<a href="javascript:void(0)" onclick="javascript:deleteSymposium();" class="bt1">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>