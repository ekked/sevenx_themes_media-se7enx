{* The map code: javascript/exp-google-maps.js (no inline script, so the page runs under a script-src 'self' policy;
   the policy must then allow the Maps API). Printed once per map; the file sets itself up once. *}
{if first_set($include_google_maps_script, false)}
    {include uri='design:parts/google_maps_script.tpl'}
{/if}
{ezscript( array( 'exp-google-maps.js' ) )}
