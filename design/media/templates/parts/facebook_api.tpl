{* The Facebook JavaScript SDK. The code is in javascript/exp-facebook-sdk.js (no inline script, so the page runs
   under a script-src 'self' policy; the policy must then allow https://connect.facebook.net); the app id and the
   locale go in the data attributes of the element it reads. *}
{if and(hasParameter($ibexa.configResolver, 'site_settings.facebook_api', 'ngsite'), hasParameter($ibexa.configResolver, 'facebook_app_id', 'netgen_open_graph'))}
    {def $facebook_api = getParameter($ibexa.configResolver, 'site_settings.facebook_api', 'ngsite')}

    {if $facebook_api}
        {def $facebook_app_id = getParameter($ibexa.configResolver, 'facebook_app_id', 'netgen_open_graph')}
        {def $facebook_locale = 'en_US'}
        {if hasParameter($ibexa.configResolver, 'site_settings.facebook_locale', 'ngsite')}
            {set $facebook_locale = parameter($ibexa.configResolver, 'site_settings.facebook_locale', 'ngsite')}
        {/if}

        {if and( $facebook_app_id|count|gt( 0 ), $facebook_locale|count|gt( 0 ) )}
            <div id="exp-facebook-sdk" hidden data-app-id="{$facebook_app_id|wash}" data-locale="{$facebook_locale|wash}"></div>
            {ezscript( array( 'exp-facebook-sdk.js' ) )}
        {/if}
    {/if}
{/if}
