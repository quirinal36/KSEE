$(document).ready(function(){
	$("input[name='login']").keyup(function(e){
		var loginInput = $(this);
		var loginVal = $(this).val();
		
		var url = "/member/get";
		var param = "login=" + loginVal;
		$.ajax({
			url : url,
			data: param,
			type: 'GET',
			dataType: 'json'
		}).done(function(json){
			if(json.result > 0){
				loginInput.parent().find(".confirm").hide();
				loginInput.parent().find(".error").show();
				loginInput.parent().find(".error").text(json.message);
			}else{
				loginInput.parent().find(".confirm").show();
				loginInput.parent().find(".error").hide();
				loginInput.parent().find(".confirm").text(json.message);
			}
		}).fail(function(xhr, status, error){
			
		}).always(function(xhr, status){
			
		});
	});
	$("input[name='password']").keyup(function(e){
		var passwordInput = $(this).val();
		var passwordConfirmInput = $("input[name='password_confirm']").val();
		
		if(passwordInput.length >= 6 && 
				passwordInput == passwordConfirmInput){
			$(this).parent().find(".error").hide();
			$(this).parent().find(".confirm").text('비밀번호가 일치합니다.');
		}else if(passwordInput.length < 6 && passwordInput.length > 0){
			// $(this).parent().find(".error").show();
			// $(this).parent().find(".error").text("6자 이상으로 입력하세요.");
		}else if(passwordInput != passwordConfirmInput
				&& passwordInput.length > 0
				&& passwordConfirmInput.length > 0){
			$(this).parent().find(".confirm").hide();
			$(this).parent().find(".error").show();
			$(this).parent().find(".error").text('비밀번호가 일치하지 않습니다.');
		}
	});
	
	$("input[name='password_confirm']").keyup(function(e){
		var passwordInput = $("input[name='password']");
		var passwordConfirmInput = $(this);
		if(passwordInput.val().length >= 6 
				&& passwordConfirmInput.val().length >= 6
				&& passwordInput.val() == passwordConfirmInput.val()){
			passwordConfirmInput.parent().find(".confirm").show();
			passwordConfirmInput.parent().find(".error").hide();
			passwordConfirmInput.parent().find(".confirm").text('비밀번호가 일치합니다.');
		}else if(passwordInput.val().length >= 6 
				&& passwordConfirmInput.val().length >= 6
				&& passwordInput.val() != passwordConfirmInput.val()){
			passwordConfirmInput.parent().find(".confirm").hide();
			passwordConfirmInput.parent().find(".error").show();
			passwordConfirmInput.parent().find(".error").text('비밀번호가 일치하지 않습니다.');
			// passwordConfirmInput.focus();
		}else if(passwordInput.val().length == 0 
				&& passwordConfirmInput.val().length == 0){
			passwordConfirmInput.parent().find(".error").hide();
		}
	});
	$("input[name='phone']").keyup(function(e){
		console.log(e.keyCode);
		if(e.keyCode >= 96 && e.keyCode <=105){
			
		}else{
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		}
	}).blur(function(e){
		var input = $(this).val();
		if(input.length >= 10){
			var regPhone = /^\d{3}\d{3,4}\d{4}$/;
			if(!regPhone.test(input)){
				$(this).parent().find(".error").show();
				$(this).parent().find(".error").text("숫자만 입력해주세요.");
			}else{
				$(this).parent().find(".error").hide();
			}
		}
	});
	$("input[name='domain']").blur(function(){
		var input = $(this).val();
		
		if(input == '' || input == 'undefined')return;
		
		if(emailCheck(input)){
			$(this).parent().find(".error").hide();
		}else{
			$(this).parent().find(".error").show();
			$(this).parent().find(".error").text("잘못된 도메인 형식입니다.");
		}
	});
	$("input[name='classification']").blur(function(){
		var input = $(this).val();
		if(input == '' || input=='undefined'){
			$(this).parent().find(".error").show();
			$(this).parent().find(".error").text("소속을 입력하세요.");
		}else{
			$(this).parent().find(".error").hide();
		}
	});
	$("input[name='level']").blur(function(){
		var input = $(this).val();
		if(input == '' || input=='undefined'){
			$(this).parent().find(".error").show();
			$(this).parent().find(".error").text("직위를 입력하세요.");
		}else{
			$(this).parent().find(".error").hide();
		}
	});
});
function emailCheck(input){
	var regex = /((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	return regex.test(input);
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

function validate(data){
	var result = true;
	var jsonObj = parse(data);

	var loginInput = $("input[name='login']");
	if(jsonObj['login'] != ''){
		loginInput.parent().find(".error").hide(); 
	}else{
		loginInput.parent().find(".confirm").hide();
		loginInput.parent().find(".error").show();
		loginInput.parent().find(".error").text('아이디를 입력해주세요.');
		loginInput.focus();
		return false;
	}
	
	var passwordInput = $("input[name='password']");
	if(jsonObj['password'] != ''){
		if(jsonObj['password'].length < 6){
			passwordInput.parent().find(".confirm").hide();
			passwordInput.parent().find(".error").show();
			passwordInput.parent().find(".error").text('6자 이상으로 입력하세요.');
			passwordInput.focus();
			return false;
		}else{
			passwordInput.parent().find(".error").hide();
		}
	}else{
		passwordInput.parent().find(".confirm").hide();
		passwordInput.parent().find(".error").show();
		passwordInput.parent().find(".error").text('비밀번호를 입력하세요.');
		passwordInput.focus();
		return false;
	}
	
	var passwordConfirmInput = $("input[name='password_confirm']");
	if(jsonObj['password_confirm'] != ''){
		if(passwordInput.val() == passwordConfirmInput.val()){
			passwordConfirmInput.parent().find(".confirm").show();
			passwordConfirmInput.parent().find(".error").hide();
			passwordConfirmInput.parent().find(".confirm").text('비밀번호가 일치합니다.');
		}else{
			passwordConfirmInput.parent().find(".confirm").hide();
			passwordConfirmInput.parent().find(".error").show();
			passwordConfirmInput.parent().find(".error").text('비밀번호가 일치하지 않습니다.');
			return false;
		}
	}else{
		passwordConfirmInput.parent().find(".confirm").hide();
		passwordConfirmInput.parent().find(".error").show();
		passwordConfirmInput.parent().find(".error").text('비밀번호가 일치하지 않습니다.');
		passwordConfirmInput.focus();
		return false;
	}
	
	var usernameInput = $("input[name='username']");
	if(jsonObj['username'].length > 0){
		usernameInput.parent().find(".error").hide();
	}else{
		usernameInput.parent().find(".error").show();
		usernameInput.parent().find(".error").text('이름을 입력하세요.');
		usernameInput.focus();
		return false;
	}
	
	var classificationInput = $("input[name='classification']");
	if(jsonObj['classification'] != ''){
		classificationInput.parent().find(".error").hide();
	}else{
		classificationInput.parent().find(".error").show();
		classificationInput.parent().find(".error").text('소속을 입력하세요.');
		classificationInput.focus();
		return false;
	}
	
	var levelInput = $("input[name='level']");
	if(jsonObj['level'] != ''){
		levelInput.parent().find(".error").hide();
	}else{
		levelInput.parent().find(".error").show();
		levelInput.parent().find(".error").text('직위를 입력하세요.');
		levelInput.focus();
		return false;
	} 
	
	
	var addressInput = $("input[name='address']");
	if(jsonObj['address'] != ''){
		addressInput.parent().find(".error").hide();
	}else{
		addressInput.parent().find(".error").show();
		addressInput.parent().find(".error").text('주소를 입력하세요.');
		addressInput.focus();
		return false;
	}
	
	var addressDetailInput = $("input[name='addressDetail']");
	if(jsonObj['addressDetail'] != ''){
		addressDetailInput.parent().find(".error").hide();
	}else{
		addressDetailInput.parent().find(".error").show();
		addressDetailInput.parent().find(".error").text('상세주소를 입력하세요.');
		addressDetailInput.focus();
		return false;
	}

	var phoneInput = $("input[name='phone']");
	if(jsonObj['phone'] != ''){
		phoneInput.parent().find(".error").hide();
	}else{
		phoneInput.parent().find(".error").show();
		phoneInput.parent().find(".error").text('전화번호를 입력하세요.');
		phoneInput.focus();
		return false;
	}
	
	var emailInput = $("input[name='email']");
	if(jsonObj['email'] != ''){
		emailInput.parent().find(".error").hide();
	}else{
		emailInput.parent().find(".error").show();
		emailInput.parent().find(".error").text('이메일 주소를 입력하세요.');
		emailInput.focus();
		return false;
	}
	
	var domainInput = $("input[name='domain']");
	if(jsonObj['domain'] != ''){
		domainInput.parent().find(".error").hide();
	} else{
		domainInput.parent().find(".error").show();
		domainInput.parent().find(".error").text('이메일 도메인을 입력하세요.');
		domainInput.focus();
		return false;
	}
	if(!emailCheck(domainInput.val())){
		domainInput.parent().find(".error").show();
		domainInput.parent().find(".error").text('잘못된 도메인 형식입니다.');
		domainInput.focus();
		return false;
	}
	return result;
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
function move(nextPage){
	if(nextPage == 1){
		var check1 = $("#term_chk1").is(":checked");
		var check2 = $("#term_chk2").is(":checked");
		
		if(check1 && check2){
			$(".form_step1").hide();
			$(".form_step2").show();
		}else {
			if(!check1){
				var message = "이용약관에 동의해주세요.";
				if(jscd.browser.indexOf('msie') != -1){
					alert(message);
				}else{
					toast({
						text : message
					});
				}
				return false;
			}
			if(!check2){
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
		}
	}else if(nextPage == 2){
		//$(".form_step2").hide();
		//$(".form_complete").show();
		location.replace("/member/signup/complete");
	}
}