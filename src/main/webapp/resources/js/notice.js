$(document).ready(function(){
	console.log("ready");
	$(".bt_write").on('click', function(){
		console.log("click");
		var boardWriteUrl = $(this).closest(".bt_wrap").find("input[name='write_url']").val();
		window.location.replace(boardWriteUrl);
	});
});