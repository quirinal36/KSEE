<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css"/>" />
<script src="<c:url value="/resources/js/uploaderAdapter.js"/>" ></script>
<script src="https://cdn.ckeditor.com/ckeditor5/12.2.0/classic/ckeditor.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<meta charset="UTF-8">
<script type="text/javascript">
$(function(){
	function MyCustomUploadAdapterPlugin(editor){
		editor.plugins.get('FileRepository').createUploadAdapter = function(loader){
			
			return new MyUploadAdapter(loader);
		};
	}
	function handleBeforeunload( editor ) {
	    const pendingActions = editor.plugins.get( 'PendingActions' );

	    window.addEventListener( 'beforeunload', function(evt ){
	        if ( pendingActions.hasAny ) {
	            evt.preventDefault();
	        }
	    });
	}

	var editor;
	ClassicEditor
    .create( document.querySelector( '#editor' ),{
    	extraPlugins : [MyCustomUploadAdapterPlugin]
    	,height: 630    
    }).then(function(newEditor){
    	editor = newEditor;
    });
	
	$("input").on("click", function(){
		var data = editor.getData();
		console.log(data);
	});
});
</script>
</head>
<body>
	<div class="wrap">
		<div class="container_wrap">
			<div class="container">
				<form>
					<textarea rows="100" cols="50" name="board_content" id="editor"></textarea>
					<input type="button" value="저장" />
				</form>
			</div>
		</div>
	</div>
</body>
</html>