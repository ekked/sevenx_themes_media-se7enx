/*
 * The Facebook JavaScript SDK (media design), loaded as Facebook's own snippet
 * does. Printed by parts/facebook_api.tpl after #exp-facebook-sdk, whose
 * data-app-id and data-locale configure it.
 */
(function () {
	'use strict';

	var conf = document.getElementById('exp-facebook-sdk');
	if (!conf || window.expFacebookSdkSetUp) return;
	window.expFacebookSdkSetUp = true;

	window.fbAsyncInit = function () {
		window.FB.init({
			appId: conf.getAttribute('data-app-id'),
			autoLogAppEvents: true,
			xfbml: true,
			version: 'v2.12'
		});
	};

	(function (d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) { return; }
		js = d.createElement(s); js.id = id;
		js.src = 'https://connect.facebook.net/' + encodeURIComponent(conf.getAttribute('data-locale') || 'en_US') + '/sdk.js';
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
}());
