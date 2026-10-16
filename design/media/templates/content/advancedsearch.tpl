{* Advanced search in the media theme (#514). Without it the design chain fell back to
   ezwebin's unstyled form, whose size=40 inputs scrolled sideways on phones. Same logic,
   fields and navigator as ezwebin's content/advancedsearch.tpl; the look comes from
   content/search.tpl and stylesheets/exp-advanced-search.css. *}
{def $search=false()}
{if $use_template_search}
    {set $page_limit=10}
    {switch match=$search_page_limit}
    {case match=1}
        {set $page_limit=5}
    {/case}
    {case match=2}
        {set $page_limit=10}
    {/case}
    {case match=3}
        {set $page_limit=20}
    {/case}
    {case match=4}
        {set $page_limit=30}
    {/case}
    {case match=5}
        {set $page_limit=50}
    {/case}
    {/switch}
    {set $search=fetch(content,search,
                      hash(text,$search_text,
                           section_id,$search_section_id,
                           subtree_array,$search_sub_tree,
                           class_id,$search_contentclass_id,
                           class_attribute_id,$search_contentclass_attribute_id,
                           offset,$view_parameters.offset,
                           publish_date,$search_date,
                           limit,$page_limit))}
    {set $search_result=$search['SearchResult']}
    {set $search_count=$search['SearchCount']}
    {set $stop_word_array=$search['StopWordArray']}
    {set $search_data=$search}
{/if}

<form action={"/content/advancedsearch/"|ezurl} method="get" class="form-search exp-advanced-search">
    <header class="full-page-header full-search-header no-breadcrumbs">
        <div class="container">
            <div class="search-inputs">
                <h1 class="exp-advanced-search-title">{'Advanced search'|i18n( 'design/ezwebin/content/advancedsearch' )}</h1>

                <div class="exp-advanced-search-fields">
                    <div class="exp-advanced-search-field exp-advanced-search-field-wide">
                        <label class="form-label" for="exp-adv-search-text">{'Search all the words'|i18n( 'design/ezwebin/content/advancedsearch' )}</label>
                        <input class="form-control" type="text" id="exp-adv-search-text" name="SearchText" value="{$full_search_text|wash}" />
                    </div>

                    <div class="exp-advanced-search-field exp-advanced-search-field-wide">
                        <label class="form-label" for="exp-adv-search-phrase">{'Search the exact phrase'|i18n( 'design/ezwebin/content/advancedsearch' )}</label>
                        <input class="form-control" type="text" id="exp-adv-search-phrase" name="PhraseSearchText" value="{$phrase_search_text|wash}" />
                    </div>

                    <div class="exp-advanced-search-field">
                        <label class="form-label" for="exp-adv-search-date">{'Published'|i18n( 'design/ezwebin/content/advancedsearch' )}</label>
                        <select class="form-select" id="exp-adv-search-date" name="SearchDate">
                            <option value="-1" {if eq( $search_date, '-1' )}selected="selected"{/if}>{'Any time'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="1" {if eq( $search_date, '1' )}selected="selected"{/if}>{'Last day'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="2" {if eq( $search_date, '2' )}selected="selected"{/if}>{'Last week'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="3" {if eq( $search_date, '3' )}selected="selected"{/if}>{'Last month'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="4" {if eq( $search_date, '4' )}selected="selected"{/if}>{'Last three months'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="5" {if eq( $search_date, '5' )}selected="selected"{/if}>{'Last year'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                        </select>
                    </div>

                    {if $use_template_search}
                    <div class="exp-advanced-search-field">
                        <label class="form-label" for="exp-adv-search-limit">{'Display per page'|i18n( 'design/ezwebin/content/advancedsearch' )}</label>
                        <select class="form-select" id="exp-adv-search-limit" name="SearchPageLimit">
                            <option value="1" {if eq( $search_page_limit, 1 )}selected="selected"{/if}>{'5 items'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="2" {if or( array( 1, 2, 3, 4, 5 )|contains( $search_page_limit )|not, eq( $search_page_limit, 2 ) )}selected="selected"{/if}>{'10 items'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="3" {if eq( $search_page_limit, 3 )}selected="selected"{/if}>{'20 items'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="4" {if eq( $search_page_limit, 4 )}selected="selected"{/if}>{'30 items'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                            <option value="5" {if eq( $search_page_limit, 5 )}selected="selected"{/if}>{'50 items'|i18n( 'design/ezwebin/content/advancedsearch' )}</option>
                        </select>
                    </div>
                    {/if}
                </div>

                {foreach $search_sub_tree as $sub_tree}
                <input type="hidden" name="SubTreeArray[]" value="{$sub_tree}" />
                {/foreach}

                <div class="exp-advanced-search-actions">
                    <button type="submit" class="btn btn-dark" name="SearchButton" value="{'Search'|i18n( 'design/ezwebin/content/advancedsearch' )}">{'Search'|i18n( 'design/ezwebin/content/advancedsearch' )}<i class="icon-search" aria-hidden="true"></i></button>
                </div>

                {if or( $search_text, eq( ezini( 'SearchSettings', 'AllowEmptySearch', 'site.ini' ), 'enabled' ) )}
                    {if $search_count|eq( 0 )}
                        <div class="result-message result-message-error">
                            <p role="status" class="search-text">{'No results were found when searching for "%1"'|i18n( 'design/ezwebin/content/advancedsearch', , array( $search_text|wash ) )}</p>
                        </div>
                    {else}
                        <div class="result-message result-message-success">
                            <p role="status" class="search-text">{'Search for "%1" returned %2 matches'|i18n( 'design/ezwebin/content/advancedsearch', , array( $search_text|wash, $search_count ) )}</p>
                        </div>
                    {/if}
                {/if}
            </div>
        </div>
    </header>

    <div class="full-search-results">
        <div class="container">
            {if and( or( $search_text, eq( ezini( 'SearchSettings', 'AllowEmptySearch', 'site.ini' ), 'enabled' ) ), $search_result|count() )}
                <div id="search-result" class="search-result">
                    {foreach $search_result as $search_item}
                        {ng_view_content( $search_item, 'search' )}
                    {/foreach}
                </div>
            {/if}

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri='/content/advancedsearch'
                     page_uri_suffix=concat('?SearchText=',$search_text|urlencode,'&PhraseSearchText=',$phrase_search_text|urlencode,'&SearchContentClassID=',$search_contentclass_id,'&SearchContentClassAttributeID=',$search_contentclass_attribute_id,'&SearchSectionID=',$search_section_id,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)),$search_sub_tree|gt(0)|choose( '', concat( '&', 'SubTreeArray[]'|urlencode, '=', $search_sub_tree|implode( concat( '&', 'SubTreeArray[]'|urlencode, '=' ) ) ) ),'&SearchDate=',$search_date,'&SearchPageLimit=',$search_page_limit)
                     item_count=$search_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}
        </div>
    </div>
</form>
