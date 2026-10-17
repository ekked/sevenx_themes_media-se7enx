/*
 * Google Maps for the map fields (media design).
 *
 * Printed by parts/google_maps_init.tpl (once per map; it sets itself up
 * once). Every .google-maps[data-exp-map] element is drawn after the page's
 * load, from its data-exp-map JSON:
 *   {"containerId": "...", "latitude": .., "longitude": .., "zoom": .., "mapType": "ROADMAP"}
 * and data-map-height (560 by default; exp-page-parts.css has the rest).
 * The Maps API itself is loaded by parts/google_maps_script.tpl.
 *
 * window.initializeGoogleMaps( options ) stays a global, as it was when this
 * code stood inline in the template.
 */
(function () {
	'use strict';

	if (window.expGoogleMapsSetUp) return;
	window.expGoogleMapsSetUp = true;

	// used where a value is out of range (the inline code named this object but never defined it)
	var defaults = { latitude: 0, longitude: 0, zoom: 14 };

	window.initializeGoogleMaps = function (options) {
		var mapCenter = new google.maps.LatLng(
			options.latitude > 90 || options.latitude < -90 ? defaults.latitude : options.latitude,
			options.longitude > 180 || options.longitude < -180 ? defaults.longitude : options.longitude
		);

		var mapOptions = {
			zoom: options.zoom > 21 || options.zoom < 0 ? defaults.zoom : options.zoom,
			center: mapCenter,
			mapTypeId: google.maps.MapTypeId[options.mapType]
		};

		var map = new google.maps.Map(document.getElementById('map-canvas-' + options.containerId), mapOptions);

		return new google.maps.Marker({
			position: mapCenter,
			map: map
		});
	};

	function drawAll() {
		if (!window.google || !google.maps) return;
		var canvases = document.querySelectorAll('.google-maps[data-exp-map]');
		for (var i = 0; i < canvases.length; i++) {
			var canvas = canvases[i];
			if (canvas.getAttribute('data-exp-map-drawn')) continue;
			canvas.setAttribute('data-exp-map-drawn', '1');
			try {
				canvas.style.height = parseInt(canvas.getAttribute('data-map-height'), 10) + 'px';
				var options = JSON.parse(canvas.getAttribute('data-exp-map'));
				// numbers, as the inline code printed them (a field value may arrive as a string)
				options.latitude = parseFloat(options.latitude);
				options.longitude = parseFloat(options.longitude);
				options.zoom = parseInt(options.zoom, 10);
				window.initializeGoogleMaps(options);
			} catch (e) { /* one broken map must not stop the others */ }
		}
	}

	if (document.readyState === 'complete') drawAll();
	else window.addEventListener('load', drawAll);
}());
