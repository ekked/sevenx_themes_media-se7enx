{def $show_path = false}
{def $view_type = 'full'}



{* EXTENDS design:$explayouts.layoutTemplate *}

{* IMPORT content/macros/content_fields.tpl AS content_fields *}

{def $content_fields = array()}
{if not($content.fields.teaser_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.teaser_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{elseif not($content.fields.full_intro['empty'])}
    {def $meta_data = hash('description', saveXML($content.fields.full_intro.value.xml)|strip_tags|trim|u.truncate(152))}
{/if}

{explblock name='content'}
    <article class="view-type view-type-{$view_type} ng-recipe">
        {explblock name='article_header'}
            <header class="full-page-header{if or(not($show_path), ($path_array|count|eq(2)))} no-breadcrumbs{/if}">
                <div class="container">
                    {include uri='design:content/parts/main_topic.tpl'}

                    <h1 class="full-page-title">{ng_render_field($content.fields.title)}</h1>

                    <div class="full-page-info">
                        {include uri='design:content/parts/author.tpl'}
                    </div>
                </div>
            </header>
        {/explblock}

        {explblock name='article_media'}
            {if or(not($content.fields.image['empty']), not($content.fields.related_multimedia['empty']))}
                <div class="full-page-image">
                    {include uri='design:content/parts/related_multimedia.tpl'}
                </div>
            {/if}
        {/explblock}

        <div class="container container-narrow">
            {explblock name='article_body'}
                <div class="full-page-body">
                    {if not($content.fields.full_intro['empty'])}
                        <div class="full-page-intro">
                            {ng_render_field($content.fields.full_intro)}
                        </div>
                    {/if}

                    {if not($content.fields.body['empty'])}
                        {ng_render_field($content.fields.body)}
                    {/if}

                    {include uri='design:content/parts/tags.tpl'}
                </div>
            {/explblock}

            {* BLOCK recipe_info *}
                <div class="full-recipe-info">
                    {if not($content.fields.serving_calories['empty'])}
                        <div class="recipe-calories">
                            {ng_render_field($content.fields.serving_calories)} {$'ngsite.layout.recipe.cal'|trans}
                        </div>
                    {/if}

                    <ul class="recipe-serving-info">
                        {if not($content.fields.serving_fat['empty'])}
                            <li>{ng_render_field($content.fields.serving_fat)} <span class="tt">{$'ngsite.layout.recipe.fat'|trans}</span></li>
                        {/if}
                        {if not($content.fields.serving_carbohydrates['empty'])}
                            <li>{ng_render_field($content.fields.serving_carbohydrates)} <span class="tt">{$'ngsite.layout.recipe.carbs'|trans}</span></li>
                        {/if}
                        {if not($content.fields.serving_protein['empty'])}
                            <li>{ng_render_field($content.fields.serving_protein)} <span class="tt">{$'ngsite.layout.recipe.protein'|trans}</span></li>
                        {/if}
                    </ul>

                    {if not($content.fields.preparation_time['empty'])}
                        <div class="recipe-time">
                            {$'ngsite.layout.recipe.preparation_time'|trans}
                            <time>{ng_render_field($content.fields.preparation_time)} {$'ngsite.layout.recipe.min'|trans}</time>
                        </div>
                    {/if}
                    {include uri='design:content/parts/social_share.tpl'}
                </div>
            {* ENDBLOCK recipe_info *}
        </div>
    </article>
{/explblock}

{* BLOCK structuredData *}
{* The Recipe JSON-LD of a recipe page is printed once, in the head, by the
   recipe_schema operator (pagelayout/head/recipe_schema.tpl). It carries the
   same properties as the block that stood here (and the content license),
   built and encoded in PHP, so a title such as "</script>" cannot end the
   script element. The block that stood here was a second Recipe for the
   same page, and its bare JSON braces stopped the template engine. *}
{* ENDBLOCK structuredData *}