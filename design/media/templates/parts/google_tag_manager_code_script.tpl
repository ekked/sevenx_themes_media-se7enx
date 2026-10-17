{* Google Tag Manager with consent mode. The code is in javascript/exp-google-tag-manager.js (no inline script, so
   the page runs under a script-src 'self' policy; the policy must then allow https://www.googletagmanager.com);
   the container id goes in the meta element it reads. *}
{def $exp_config = exponential().configResolver}
{if hasParameter($exp_config, 'site_settings.google_tag_manager_code')}
    {def $google_tag_manager_code = getParameter($exp_config, 'site_settings.google_tag_manager_code')}

    {if $google_tag_manager_code|count|gt(0)}
        <!-- Google Tag Manager -->
        <meta name="exp-google-tag-manager" content="{$google_tag_manager_code|wash}" />
        {ezscript( array( 'exp-google-tag-manager.js' ) )}
        <!-- End Google Tag Manager -->
    {/if}
{/if}
