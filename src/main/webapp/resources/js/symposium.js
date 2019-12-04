function move(nextPage){
	if(nextPage == 1){
		var check1 = $("#term_chk1").is(":checked");
		if(check1){
			$(".form_step1").hide();
			$(".form_step2").show();
		}else{
			var message = jQuery.i18n.prop("member.signup.policy");
			if(jscd.browser.indexOf('msie') != -1){
				alert(message);
			}else{
				toast({
					text : message
				});
			}
			return false;
		}
	}else if(nextPage == 2){
		// 빈칸 체크
		$(".form_step2").hide();
		$(".form_complete").show();
	}	
}
function fn_setAddr(){
	var width=500;
	var height=600;
		
	daum.postcode.load(function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	var addressText = "["+data.zonecode+"]" + data.address;
	        	$("input[name='address']").val(addressText);
	        	$("input[name='addressDetail']").val(data.buildingName);
	        }
	    }).open({
	    	left : (window.screen.width / 2) - (width / 2),
	    	top : (window.screen.height / 2) - (height / 2),
	    });
	});
}
function registSymposium(){
	var url = $("form").attr("action");
	var param = $("form").serialize();
	var jsonObj = parse($("form").serializeArray());
	
	if(jsonObj['title'] != ''){
		
	}else{
		alert("행사명을 입력해주세요.");
		return false;
	}
	
	if(jsonObj['place'] != ''){
		
	}else{
		alert("장소를 입력해주세요.");
		return false;
	}
	
	if(jsonObj['startDate'] != '' && jsonObj['finishDate'] != ''){
		
	}else{
		alert("행사기간을 선택해주세요.");
		return false;
	}
	
	if(jsonObj['applyStart'] != '' && jsonObj['applyFinish'] != ''){
		
	}else{
		alert("접수기간을 선택해주세요.");
		return false;
	}
	
	if(!confirm("등록하시겠습니까?")){
		return false;
	}
	
	$.ajax({
		url : url,
		data: param,
		type: 'POST',
		dataType: 'json'
	}).done(function(json){
		if(json.result > 0){
			var listUrl = $("form").find("input[name='listUrl']").val();
			alert("등록되었습니다.");
			location.replace(listUrl);
		}
	}).fail(function(xhr, status, error){
		
	}).always(function(xhr, status){
		
	});
}
function parse(data){
	var jsonObj = {};
	data.forEach(function(item, index, arr){
		var name = item.name;
		var value = item.value;
		
		jsonObj[name] = value;
	});
	return jsonObj;
}