{include uri='design:parts/google_maps_init.tpl'}

{def $container_id = first_set($container_id, 0)}
{def $latitude = first_set($latitude, parameter($ibexa.configResolver, 'google_maps.latitude', 'ngsite'))}
{def $longitude = first_set($longitude, parameter($ibexa.configResolver, 'google_maps.longitude', 'ngsite'))}
{def $zoom = first_set($zoom, parameter($ibexa.configResolver, 'google_maps.zoom', 'ngsite'))}
{def $map_type = first_set($map_type, parameter($ibexa.configResolver, 'google_maps.map_type', 'ngsite'))}

{* drawn after the page's load by exp-google-maps.js from data-exp-map; the map's height is per map (map_height,
   560 by default); exp-page-parts.css has the rest *}
<div
    id="map-canvas-{$container_id|wash}"
    class="google-maps"
    data-exp-map="{json_encode( hash( 'containerId', $container_id, 'latitude', $latitude, 'longitude', $longitude, 'zoom', $zoom, 'mapType', $map_type ) )|wash}"
    data-map-height="{first_set($map_height, 560)|wash}">
</div>
