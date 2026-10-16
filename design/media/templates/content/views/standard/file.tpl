


{* IMPORT macros.tpl AS toolbar_macros *}

{def $toolbar_macros = array()}
<article {item_params($toolbar_macros, $content, $location)} class="view-type view-type-{$view_type} file vl1">
    <header class="article-header">
        <h3 class="title">
            <a href="{exp_path($location)}">
                {$content.name|wash}
            </a>
        </h3>
    </header>
</article>