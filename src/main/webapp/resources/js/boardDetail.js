$(document).ready(function(){
	$(".btn_edit").on('click', function(){
		var editUrl = $(this).closest(".bt_wrap").find("input[name='edit_url']").val();
		window.location.replace(editUrl);
	});
});
