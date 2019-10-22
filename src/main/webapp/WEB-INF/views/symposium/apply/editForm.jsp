<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/resources/js/symposium.js"/>"></script>
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">

</script>
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
				<!-- 타이틀명 : 신청서 수정 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/symposium/apply"/>" id="applyForm">
							<input type="hidden" name="sympId" value="${symposium.id }"/>
							<dl class="member_chk">
								<dt>참가자 구분</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="memberType" id="member_chk1" class="radio1" value="2" checked>
											<label for="member_chk1">일반</label>
										</li>
										<li>
											<input type="radio" name="memberType" id="member_chk2" class="radio1" value="3">
											<label for="member_chk2">기업</label>
										</li>
										<li>
											<input type="radio" name="memberType" id="member_chk3" class="radio1" value="4">
											<label for="member_chk3">학생</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt>발표자 여부</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="isSpeaker" id="speaker_chk1" class="radio1" value="1">
											<label for="speaker_chk1">발표자입니다</label>
										</li>
										<li>
											<input type="radio" name="isSpeaker" id="speaker_chk2" class="radio1" value="2" checked>
											<label for="speaker_chk2">발표자가 아닙니다</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt>국적</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="national" id="national_chk1" class="radio1" value="1" checked>
											<label for="national_chk1">대한민국</label>
										</li>
										<li>
											<input type="radio" name="national" id="national_chk2" class="radio1" value="2">
											<label for="national_chk2">중국</label>
										</li>
										<li>
											<input type="radio" name="national" id="national_chk3" class="radio1" value="3">
											<label for="national_chk3">일본</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" placeholder="이름 입력" class="ipt1" name="username" autocomplete="off" value="${user.username }">
									<p class="message error">이름을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>
									<input type="text" placeholder="소속 입력" class="ipt1" name="classification" autocomplete="off" value="${user.classification }">
									<p class="message error">소속을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>
									<input type="text" placeholder="직위 입력" class="ipt1" name="level" autocomplete="off" value="${user.level }">
									<p class="message error">직위를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="company_tel">
								<dt>연락처</dt>
								<dd>
									<input type="text" placeholder="연락처 입력" class="ipt1" name="telephone" autocomplete="off" value="${user.telephone }">
								</dd>
							</dl>
							<dl class="email">
								<dt>이메일 주소</dt>
								<dd>
									<input type="text" placeholder="이메일 아이디 입력" class="ipt1" name="email" autocomplete="off" value="${user.email }">
									<span>@</span>
									<input type="text" placeholder="도메인 입력" class="ipt1" name="domain" autocomplete="off" value="${user.domain }">
									<p class="message error">이메일 아이디를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="file">
								<dt>학술대회 초록</dt>
								<dd>
									<div class="board_write_file"  id="dropzone-file">
										<!-- 첨부파일 목록 -->
										<ul id = "file_ul">
											<!-- 
											<li>
												<span>2019 하계 중국 심포지움 안내파일.hwp</span>
												<input type="button" value="삭제" class="bt_del_file">
											</li>
											 -->
										</ul>
										<input id="fileupload" type="file" name="files[]" 
											data-url="<c:url value="/upload/file"/>" multiple>
									    <div id="progress_file">
									        <div class="progress-bar" style="width: 0%;"></div>
									    </div>
									</div>
								</dd>
							</dl>
							<div class="bt3_item2">
								<input type="button" value="수정완료" class="bt3 on" id="submit" onclick="javascript:applySubmit();">
								<a href="#" class="bt3">이전 페이지로 이동</a>
							</div>
						</form>
					</div>
				</div>
			
			</div>
		</div>
	</div>
</div>
</body>
</html>