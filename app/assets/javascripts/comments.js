// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var MY_APP = MY_APP || {};

MY_APP.commentCtr = (function () {
	var stub = {};

	stub.init = function () {
		commentLinkListener();
	};

	var commentLinkListener = function () {
		$(".new-comment").click(function (event) {
			event.preventDefault();
			var $target = $(event.target);
			console.log($target.next());
			$target.next().toggle();
		});
	};

	return stub;
})();

document.addEventListener("turbolinks:load", function () {
	MY_APP.commentCtr.init();
})
