function validate(data){
	var result = true;
	var jsonObj = parse(data);
	console.log(jsonObj);
	
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
	
	var phoneInput = $("input[name='phone']");
	if(jsonObj['phone'] != ''){
		phoneInput.parent().find(".error").hide();
	}else{
		phoneInput.parent().find(".error").show();
		phoneInput.parent().find(".error").text('전화번호를 입력하세요.');
		phoneInput.focus();
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
	
	return result;
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
function emailCheck(input){
	var regex = /((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	return regex.test(input);
}