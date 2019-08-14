$(function(){
	// gnb 메뉴
	$(".gnb_wrap").hover(function(){
		$(this).find(".gnb_menu").stop().slideDown(300);
	}, function(){
		$(this).find(".gnb_menu").stop().slideUp(300);
	});
	// gnb dep1 메뉴 색상변경
	$(".gnb_wrap > ul > li, .gnb_menu .dep1 > li").hover(function(){
		var idx = $(this).index();
		$(".gnb_wrap > ul >li:eq("+idx+") a").css("color","#0d2880");
	}, function(){
		var idx = $(this).index();
		$(".gnb_wrap > ul >li:eq("+idx+") a").css("color","#000");
	});
	
	// lnb 1차메뉴
	$(".dep1 > a").click(function(){
		$(".dep2 > a").removeClass("on");
		$(this).toggleClass("on");
		$("#lnb_wrap ul").stop().slideUp(300);
		$(this).find("+ ul").stop().slideToggle(300);
	});
	// lnb 2차메뉴
	$(".dep2 > a").click(function(){
		$(".dep1 > a").removeClass("on");
		$(this).toggleClass("on");
		$("#lnb_wrap ul").stop().slideUp(300);
		$(this).find("+ ul").stop().slideToggle(300);
	});
	// 다른 곳 클릭 시 숨기기

	// 스크롤 시 lnb 고정
	$(window).scroll(function(){
		var num = $(this).scrollTop();
		if( num > 120 ){
			$("#lnb_wrap").addClass("fix");
		} else{
			$("#lnb_wrap").removeClass("fix");
		}
	});
	
	// 검색버튼 누르면 검색 레이어 열림
	$(".bt_header_search").click(function(){
		$(".header_search").show();
	});
	$(".bt_header_search_close").click(function(){
		$(".header_search").fadeOut(1000);
	});
});


// index slider
$(function(){
	// section2_slider
	$('.idx_popup').bxSlider({
		controls: true,
		auto: true,
		pager: false,
		pause: 8000
	});
});

// 정관
$(function(){
	$(".term_bt").click(function(){
		$(this).toggleClass("on");
		$(this).parent().find("+ .content").slideToggle();
	});
});

















