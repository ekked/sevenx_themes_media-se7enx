/*
 * Registers the navigation cache, the Exponential Service Workers Index
 * (/index.js), for anonymous visitors (media design).
 *
 * Printed by pagelayout/script_bottom.tpl at the end of every page, after the
 * data block #exp-sw-config, which carries the name of the session cookie this
 * siteaccess signs people in with ({"sessionCookie": "..."}). The reasons for
 * each step are in that template's comment; in short:
 *
 *   - a session cookie means the page is somebody's: the worker is told so and
 *     steps aside (it is not removed), and nothing is registered;
 *   - otherwise /index.js is registered after the page's load, falling back to
 *     /sw.js for an installation older than the rename.
 *
 * A failure here must never affect the page.
 */
(function () {
	'use strict';

	if (window.expServiceWorkerSetUp || !('serviceWorker' in navigator)) return;
	window.expServiceWorkerSetUp = true;

	var sessionCookie = '';
	try {
		var conf = document.getElementById('exp-sw-config');
		sessionCookie = (conf && JSON.parse(conf.textContent).sessionCookie) || '';
	} catch (e) { /* no name: nobody is taken for signed in, as before when the name was empty */ }

	var jar = document.cookie || '';
	// Exactly that cookie, anchored, and the '=' must follow the name immediately.
	var personal = sessionCookie !== ''
		&& new RegExp('(?:^|;\\s*)' + sessionCookie + '=[^;]+').test(jar);

	function tell(signedIn) {
		if (navigator.serviceWorker.controller) {
			navigator.serviceWorker.controller.postMessage(
				{ type: 'session', signedIn: signedIn });
		}
	}

	tell(personal);
	navigator.serviceWorker.ready.then(function () { tell(personal); })
		.catch(function () {});

	if (personal) return;

	function register() {
		navigator.serviceWorker.register('/index.js', { scope: '/' })
			.catch(function () { return navigator.serviceWorker.register('/sw.js', { scope: '/' }); })
			.then(function () { tell(false); })
			.catch(function () { /* a failure here must never affect the page */ });
	}

	if (document.readyState === 'complete') register();
	else window.addEventListener('load', register);
}());
