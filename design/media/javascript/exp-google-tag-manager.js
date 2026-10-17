/*
 * Google Tag Manager with consent mode (media design).
 *
 * Printed by parts/google_tag_manager_code_script.tpl in the head, right after
 * <meta name="exp-google-tag-manager" content="GTM-XXXX">, which names the
 * container. Sets the default consent from the cookie banner's stored choice,
 * follows a choice made on the page, then loads gtm.js from Google as the
 * standard snippet does.
 *
 * window.dataLayer, window.gtag and window.getCookieStatus stay globals, as
 * they were when this code stood inline in the template.
 */
(function () {
	'use strict';

	if (window.expGoogleTagManagerSetUp) return;
	var meta = document.querySelector('meta[name="exp-google-tag-manager"]');
	var id = meta ? meta.getAttribute('content') : '';
	if (!id) return;
	window.expGoogleTagManagerSetUp = true;

	// DataLayer and the gtag function.
	window.dataLayer = window.dataLayer || [];
	window.gtag = function () { window.dataLayer.push(arguments); };

	// Granted or denied for a category of the cookie banner. The banner
	// (exp-cookie-consent.js) keeps the visitor's choice in one cookie,
	// ng-cc-consent = "v<version>.rejected" or "v<version>.<name>+<name>".
	// The banner offers "analytics" and "marketing" only once they are
	// added to it with a handler; until then both stay denied here.
	window.getCookieStatus = function (category) {
		var match = document.cookie.match(/(?:^|;\s*)ng-cc-consent=v[^.;]*\.([^;]*)/);
		var accepted = match && match[1] !== 'rejected' ? match[1].split('+') : [];
		return accepted.indexOf(category) !== -1 ? 'granted' : 'denied';
	};

	function consent() {
		return {
			'ad_storage': window.getCookieStatus('marketing'),
			'ad_user_data': window.getCookieStatus('marketing'),
			'ad_personalization': window.getCookieStatus('marketing'),
			'analytics_storage': window.getCookieStatus('analytics')
		};
	}

	// Default consent from the stored choice, then follow a choice made on this page.
	window.gtag('consent', 'default', consent());
	document.addEventListener('exp:cookie-consent', function () {
		window.gtag('consent', 'update', consent());
	});

	// Google Tag Manager (the standard snippet).
	(function (w, d, s, l, i) {
		w[l] = w[l] || [];
		w[l].push({ 'gtm.start': new Date().getTime(), event: 'gtm.js' });
		var f = d.getElementsByTagName(s)[0],
			j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : '';
		j.async = true;
		j.src = 'https://www.googletagmanager.com/gtm.js?id=' + encodeURIComponent(i) + dl;
		f.parentNode.insertBefore(j, f);
	})(window, document, 'script', 'dataLayer', id);
}());
