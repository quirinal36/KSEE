$(document).ready(function(){
	$(".btn_edit").on('click', function(){
		var editUrl = $(this).closest(".bt_wrap").find("input[name='edit_url']").val();
		window.location.replace(editUrl);
	});
	
	$(".btn_del").on('click', function(){
		if(confirm("삭제하시겠습니까?")){
			var delUrl = $(this).closest(".bt_wrap").find("input[name='del_url']").val();
			var listUrl = $(this).closest(".bt_wrap").find("input[name='list_url']").val();
			$.ajax({
				url : delUrl,
				type: "GET",
				dataType: 'json'
			}).done(function(json){
				window.location.replace(listUrl);
			});
		}
	});
});
