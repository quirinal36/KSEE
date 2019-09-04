function pageGo(pageNum){
	$("input[name='pageNo']").val(pageNum);
	$("form").submit();
}
function search(){
	$("form").submit();
}