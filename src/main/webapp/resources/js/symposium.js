function move(nextPage){
	if(nextPage == 1){
		var check1 = $("#term_chk1").is(":checked");
		if(check1){
			$(".form_step1").hide();
			$(".form_step2").show();
		}else{
			var message = "개인정보처리방침에 동의해주세요.";
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