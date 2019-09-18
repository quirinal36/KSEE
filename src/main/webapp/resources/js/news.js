$(document).ready(function(){
	$(".bt_write").on('click', function(){
		var boardWriteUrl = $(this).closest(".bt_wrap").find("input[name='write_url']").val();
		window.location.replace(boardWriteUrl);
	});
});