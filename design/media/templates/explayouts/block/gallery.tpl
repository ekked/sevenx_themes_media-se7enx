{* Gallery block dispatcher: drawn by gallery/<view type>.tpl. Only a view type this theme has a template for is
   included (a stored view type is otherwise used as part of an include path); any other - 'default', 'gallery', an
   unknown value - falls back to the resolved gallery view type of the block handler when the theme has it, else to
   grid_gallery. *}
{def $gb_known = array( 'grid_gallery', 'slider', 'sushi_bar', 'thumb_gallery' )
     $gb_vt = first_set( $block.view_type, '' )}
{if $gb_known|contains( $gb_vt )|not}
    {set $gb_vt = first_set( $block.values.view_type, '' )}
    {if $gb_known|contains( $gb_vt )|not}{set $gb_vt = 'grid_gallery'}{/if}
{/if}
{include uri=concat( 'design:explayouts/block/gallery/', $gb_vt, '.tpl' ) block=$block module_result=first_set( $module_result, hash() )}
{undef $gb_known $gb_vt}
