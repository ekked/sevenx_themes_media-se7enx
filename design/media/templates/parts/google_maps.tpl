{include uri='design:parts/google_maps_init.tpl'}

{def $container_id = first_set($container_id, 0)}
{def $latitude = first_set($latitude, parameter($ibexa.configResolver, 'google_maps.latitude', 'ngsite'))}
{def $longitude = first_set($longitude, parameter($ibexa.configResolver, 'google_maps.longitude', 'ngsite'))}
{def $zoom = first_set($zoom, parameter($ibexa.configResolver, 'google_maps.zoom', 'ngsite'))}
{def $map_type = first_set($map_type, parameter($ibexa.configResolver, 'google_maps.map_type', 'ngsite'))}

<script type="text/javascript">
    google.maps.event.addDomListener(window, 'load', function(){
        // the map's height is per map (map_height, 560 by default); exp-page-parts.css has the rest
        var mapCanvas = document.getElementById("map-canvas-{$container_id|wash('js')}");
        if (mapCanvas) mapCanvas.style.height = parseInt(mapCanvas.getAttribute('data-map-height'), 10) + 'px';
        initializeGoogleMaps({
            containerId: "{$container_id|wash('js')}",
            latitude: {$latitude|wash('js')},
            longitude: {$longitude|wash('js')},
            zoom: {$zoom|wash('js')},
            mapType: "{$map_type|wash('js')}"
        });
    });
</script>

<div
    id="map-canvas-{$container_id|wash('html_attr')}"
    class="google-maps"
    data-map-height="{first_set($map_height, 560)|wash('html_attr')}">
</div>