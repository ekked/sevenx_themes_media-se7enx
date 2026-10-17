/*
 * Small page actions of the media design, as listeners instead of inline code
 * (so the pages run under a script-src 'self' policy). Loaded deferred on every
 * page (pagelayout/head/script.tpl); every listener is delegated, so markup
 * added later works too.
 *
 *   a[data-exp-history-back]           goes back one page (error pages, "Go back")
 *   a[data-exp-reload]                 reloads the page (error pages, "Try again")
 *   input[data-exp-check-all="<css>"]  ticks or unticks every checkbox the selector
 *                                      finds (notification settings, "Select all")
 *   form[data-exp-disable-on-submit="<id> <id>"]
 *                                      disables those buttons once the form is sent,
 *                                      so it cannot be sent twice. On the next tick,
 *                                      never inside the submit event: a submit button
 *                                      disabled while the event still runs is left out
 *                                      of the posted data, and the module would not
 *                                      see which button was pressed.
 */
(function () {
	'use strict';

	if (window.expPageActionsSetUp) return;
	window.expPageActionsSetUp = true;

	function closest(el, selector) {
		while (el && el.nodeType === 1) {
			if (el.matches(selector)) return el;
			el = el.parentNode;
		}
		return null;
	}

	document.addEventListener('click', function (e) {
		var back = closest(e.target, 'a[data-exp-history-back]');
		if (back) {
			e.preventDefault();
			history.back();
			return;
		}
		var reload = closest(e.target, 'a[data-exp-reload]');
		if (reload) {
			e.preventDefault();
			location.reload();
		}
	});

	// change, not click: it also follows the keyboard (space) and label clicks
	document.addEventListener('change', function (e) {
		var box = e.target;
		if (!box || !box.matches || !box.matches('input[data-exp-check-all]')) return;
		var boxes = document.querySelectorAll(box.getAttribute('data-exp-check-all'));
		for (var i = 0; i < boxes.length; i++) {
			if (boxes[i] !== box) boxes[i].checked = box.checked;
		}
	});

	document.addEventListener('submit', function (e) {
		var form = e.target;
		if (!form || !form.hasAttribute || !form.hasAttribute('data-exp-disable-on-submit')) return;
		var ids = form.getAttribute('data-exp-disable-on-submit').split(/\s+/);
		window.setTimeout(function () {
			for (var i = 0; i < ids.length; i++) {
				var button = ids[i] && document.getElementById(ids[i]);
				if (button) button.disabled = true;
			}
		}, 0);
	});
}());
