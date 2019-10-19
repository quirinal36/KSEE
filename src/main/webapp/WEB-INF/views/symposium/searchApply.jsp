<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/resources/js/symposium.js"/>"></script>
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
				<!-- 타이틀명 : 참가신청 조회 -->
				<!-- 참가신청 조회 - 정보 입력 -->
				<div class="member member_form1 form_step1">
					<div class="paper">
						<form action="<c:url value="/symposium/apply"/>" id="applyForm">
							<input type="hidden" name="sympId" value="${symposium.id }"/>
							<dl class="member_chk">
								<dt>구분</dt>
								<dd>
									<ul>
										<li>
											<input type="radio" name="" id="" class="radio1" value="" checked>
											<label for="">국내 학술대회</label>
										</li>
										<li>
											<input type="radio" name="" id="" class="radio1" value="">
											<label for="">한중일 학술대회</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>행사명</dt>
								<dd>
									<select class="select2">
										<option>제5회 국내학술대회</option>
										<option>제4회 국내학술대회</option>
										<option>제3회 국내학술대회</option>
										<option>제2회 국내학술대회</option>
										<option>제1회 국내학술대회</option>
									</select>
								</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" placeholder="이름 입력" class="ipt1" name="username" autocomplete="off" value="${user.username }">
									<p class="message error">이름을 입력하세요.</p>
								</dd>
							</dl>
							<dl class="company_tel">
								<dt>연락처</dt>
								<dd>
									<input type="text" placeholder="연락처 입력" class="ipt1" name="telephone" autocomplete="off" value="${user.telephone }">
								</dd>
							</dl>
							<input type="button" value="참가신청 조회" class="bt3 on" id="submit" onclick="javascript:applySubmit();">
							<!-- 검색결과 없음 -->
							<div class="apply_search_result">
								<p>
									신청내역이 없습니다.<br>
									입력하신 정보를 확인해주세요.
								</p>
							</div>
							<!-- 접수 중 -->
							<div class="apply_search_result">
								<p><span>[접수 중]</span> 상태입니다.</p>
								<a href="#" class="bt2 on">신청서 보기</a>
								<a href="#" class="bt2">신청 취소</a>
							</div>
							<!-- 신청완료 -->
							<div class="apply_search_result">
								<p><span>[신청완료]</span> 상태입니다.</p>
								<a href="#" class="bt2 on">신청서 보기</a>
							</div>
							<!-- 신청취소 -->
							
						</form>
					</div>
				</div>
				
				<!-- 타이틀명 : 신청서 보기 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/symposium/apply"/>" id="applyForm">
							<dl>
								<dt>상태</dt>
								<dd>접수 중 / 신청 완료 / 신청 취소</dd>
							</dl>
							<dl>
								<dt>참가자 구분</dt>
								<dd>일반</dd>
							</dl>
							<dl>
								<dt>발표자 여부</dt>
								<dd>발표자가 아닙니다</dd>
							</dl>
							<dl>
								<dt>국적</dt>
								<dd>대한민국</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>이형구</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>한국효소공학연구회</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>학생</dd>
							</dl>
							<dl>
								<dt>연락처</dt>
								<dd>01056790072</dd>
							</dl>
							<dl>
								<dt>이메일 주소</dt>
								<dd>turboguy@naver.com</dd>
							</dl>
							<dl>
								<dt>학술대회 초록</dt>
								<dd>
									<a href="#">파일명(다운로드 링크)</a>
								</dd>
							</dl>
							<!-- 수정 가능할 때 (접수 중) -->
							<div class="bt3_item2">
								<a href="#" class="bt3 on">신청서 수정</a>
								<a href="#" class="bt3">이전 페이지로 이동</a>
							</div>
							<!-- 수정 불가능할 때 (신청 완료 / 신청 취소) -->
							<a href="#" class="bt3 on">이전 페이지로 이동</a>
						</form>
					</div>
				</div>
				
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
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>