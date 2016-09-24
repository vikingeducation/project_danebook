// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
var MY_APP = MY_APP || {};

MY_APP.photoCtr = (function () {
	var stub = {};

	stub.init = function () {
		newPhotoLinkListener();
		closeLightBoxListener();
	};

	var newPhotoLinkListener = function () {
		$('.new-photo-link').click(function (event) {
			event.preventDefault();
			$('.new-photo').show();
		});
	};

	var closeLightBoxListener = function () {
		$('.closeLightBox').click(function (event) {
			event.preventDefault();
			$('.new-photo').hide();
		});
	};

	return stub;
})();

document.addEventListener("turbolinks:load", function () {
	if ($("body").data("controller") === 'photos') {
		MY_APP.photoCtr.init();
	};
})
