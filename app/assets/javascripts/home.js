
$(document).ready(function(){
	var str = location.href.toLowerCase();
	$(".btn-group a button").each(function() {
		if (str.indexOf(this.href.toLowerCase()) > -1) {
			$("button.active").removeClass("active");
		  $(this).parent().addClass("active");
		}
	});
})
