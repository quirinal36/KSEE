function pageGo(pageNum){
	$("input[name='pageNo']").val(pageNum);
	$("form").submit();
}
function search(form){
	$(form).submit();
}
function arangeList(sortBy){
	var url = $("form").attr("action");
	url = url + "?sortBy="+sortBy;
	window.location.replace(url);
}