<meta name="generator" content="{'Exponential powered by 7x'|i18n('design/media/pagelayout')}">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2">
<meta name="theme-color" content="#ffffff">

{def $mt_meta = false()}
{if $node}
    {set $mt_meta = metadata($node.node_id)}
{/if}

{def $mt_description = ''}
{if $mt_meta}
    {if $mt_meta.description|ne('')}
        {set $mt_description = $mt_meta.description}
    {/if}
{/if}
{if $mt_description|eq('')}
    {if $node}
        {def $mt_intro = firstNonEmptyField($node.object, 'teaser_intro', 'intro', 'description')}
        {if not($mt_intro.empty)}
            {* Replace the markup with spaces before shortening. The intro
               fields hold rich text, so the description was being filled with
               escaped tags (&lt;p&gt;...) instead of prose, and shorten()
               counted those tags toward its 160 characters. Replacing rather
               than stripping keeps a word break where one paragraph ended and
               the next began. *}
            {set $mt_description = $mt_intro.value.text|preg_replace('/<[^>]+>/', ' ')|simplify|shorten(160)}
        {/if}
        {undef $mt_intro}
    {/if}
{/if}

{* Last resort: the site's own description. Without this a page whose node has
   no metadata and no intro field - the front page among them - emitted no
   description at all, which is what search engines were seeing. *}
{if $mt_description|eq('')}
    {def $mt_site_meta = ezini('SiteSettings','MetaDataArray')}
    {if and(is_set($mt_site_meta.description), $mt_site_meta.description|ne(''))}
        {set $mt_description = $mt_site_meta.description}
    {/if}
    {undef $mt_site_meta}
{/if}

{if $mt_description|ne('')}
<meta name="description" content="{$mt_description|wash}" />
{/if}

{if $mt_meta}
    {if $mt_meta.keywords|count|gt(0)}
<meta name="keywords" content="{$mt_meta.keywords|implode(', ')|wash}" />
    {/if}
    {if $mt_meta.canonical_url|ne('')}
<link rel="canonical" href="{$mt_meta.canonical_url|wash}" />
    {/if}
    {* og:image and twitter:image: the object's own Open Graph image, else the class default (xrowmetadata 1.4.7) *}
    {include uri='design:xrowmetadata/opengraph_image.tpl' meta=$mt_meta}
{/if}

{undef $mt_meta}
{undef $mt_description}

{* The content license (xrowmetadata 1.4.9): link rel="license" and the Dublin
   Core meta tag here, the schema.org "license" merged into the JSON-LD below
   as a WebPage next to the BreadcrumbList, so the head carries it once. Open
   Graph has no license property (parts/opengraph.tpl prints none). *}
{if $node}
    {def $mt_license = xrowmetadata_license($node)}
{else}
    {def $mt_license = xrowmetadata_license()}
{/if}
{include uri='design:xrowmetadata/license_head.tpl' license=$mt_license json_ld=false()}
{def $mt_license_ld = and($mt_license, $mt_license.show.json_ld)}

{def $mt_last = $path_array|count|sub(1)}
<script type="application/ld+json">
{literal}{{/literal}
    "@context": "https://schema.org",
{if $mt_license_ld}
    "@graph": [
    {literal}{{/literal}
{/if}
    "@type": "BreadcrumbList",
    "itemListElement": [
    {foreach $path_array as $mt_index => $mt_item}
        {ldelim}
            "@type": "ListItem",
            "name": "{$mt_item.text|wash}",
            {if $mt_item.url|ne(false)}"item": "https://{ezini('SiteSettings','SiteURL')}/{$mt_item.url}",{/if}
            "position": {$mt_index|sum(1)}
        {rdelim}{if $mt_index|lt($mt_last)},{/if}
    {/foreach}
    ]
{if $mt_license_ld}
    {literal}}{/literal},
    {$mt_license.json_ld_node}
    ]
{/if}
{literal}}{/literal}
</script>
{undef $mt_last}
{undef $mt_license}
{undef $mt_license_ld}
