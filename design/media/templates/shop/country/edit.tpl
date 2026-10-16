{* Country selector for the media design.

   The same as design/standard/templates/shop/country/edit.tpl apart from the
   select carrying the class form-control unless the caller passes
   select_class (pass select_class='' to opt out), so the field matches the
   rest of the form.

   The options come from the kernel's shared design:country/options.tpl: the
   most used countries first, then all countries A-Z, each in an <optgroup>.
   An option posts the country's name, or its code with use_country_code, and
   autocomplete names the address field for the browser (country-name, or
   country for codes; select_autocomplete overrides it).

   Country names are not truncated: the select is full width, and a shortened
   name is no longer the name a browser's autofill looks for. Pass max_len to
   shorten them again. *}
{default $max_len = 0
    $select_size = 1
    $select_class = 'form-control'
    $use_country_code = false()}
{if is_set( $current_val )}
    {def $country_select_current = $current_val}
{else}
    {def $country_select_current = ''}
{/if}
{if is_set( $select_autocomplete )}
    {def $country_select_autocomplete = $select_autocomplete}
{else}
    {def $country_select_autocomplete = cond( $use_country_code, 'country', 'country-name' )}
{/if}

<select name="{$select_name}"{if is_set( $select_id )} id="{$select_id|wash}"{/if} size="{$select_size}"{if $select_class|ne('')} class="{$select_class|wash}"{/if}{if $country_select_autocomplete|ne( '' )} autocomplete="{$country_select_autocomplete|wash}"{/if}>
{if and( is_set( $default_val ), is_set( $default_desc ) )}
    <option {if eq( $current_val, false )}selected="selected"{/if} value="{$default_val}">{$default_desc|wash}</option>
{elseif $country_select_current|eq( '' )}
    <option value="" selected="selected">{'Choose a country'|i18n( 'kernel/country' )}</option>
{/if}
{if is_set( $countries )}
{foreach $countries as $country}
    <option {if eq( $country['Name'], $current_val )} selected="selected" {/if} value="{if $use_country_code}{$country['Alpha2']}{else}{$country['Name']}{/if}">
    {if gt( $max_len, 0 )}{$country['Name']|shorten( $max_len )|wash}{else}{$country['Name']|wash}{/if}
    </option>
{/foreach}
{else}
{include uri='design:country/options.tpl'
         country_value_field=cond( $use_country_code, 'Alpha2', 'Name' )
         country_selected=array( $country_select_current )
         country_max_len=$max_len}
{/if}
</select>
{undef $country_select_autocomplete $country_select_current}
{/default}
