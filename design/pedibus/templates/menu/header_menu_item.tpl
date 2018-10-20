{set_defaults( hash(
  'has_link', true()
))}

{if $has_link}
  {if $menu_item.item.internal}
      {def $href = $menu_item.item.url|ezurl(no)}
  {else}
      {def $href = $menu_item.item.url}
  {/if}
{else}
  {def $href = '#'}
{/if}

<a class="{if $current} current{/if}{if $menu_item.has_children} dropdown-toggle{/if}" href="{$href}"{if $menu_item.has_children}  data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"{/if}>
    {$menu_item.item.name|wash()}{if $menu_item.has_children} <span class="caret"></span>{/if}
</a>
{*{$menu_item|attribute(show)}*}

{*<a class="{if $current} current{/if}" href="{$href}" {if $menu_item.item.target}target="{$menu_item.item.target}"{/if} title="Vai a {$menu_item.item.name|wash()}">
    {$menu_item.item.name|wash()}
</a>*}

{undef $href}
