{def $path_array = $current_node.path_string|explode( '/' )
$current_node_id = $current_node.node_id
$is_current = $menu_item.item.node_id|eq($current_node_id)
$is_active = $path_array|contains($menu_item.item.node_id)}

<li class="{if or($is_active, $is_current)}active current{/if}">
    <a href="{if $menu_item.item.internal}{$menu_item.item.url|ezurl(no)}{else}{$menu_item.item.url}{/if}"
            {def $class = ''}
            {if or($is_active, $is_current)}
                {set $class = concat("Linklist-link Linklist-link--lev", $recursion)}
                aria-expanded="true"
            {else}
                aria-expanded="false"
            {/if}
            {if $menu_item.item.target}target="{$menu_item.item.target}"{/if}
       title="Vai a {$menu_item.item.name|wash()}" class="{$class}">

        {$menu_item.item.name|wash()}
    </a>

    {if $menu_item.has_children}
        {set $recursion = $recursion|inc()}
        <ul>
            {foreach $menu_item.children as $child}
                {include name="side_sub_menu" uri='design:menu/side_menu_item.tpl' menu_item=$child current_node=$current_node recursion=$recursion}
            {/foreach}
        </ul>
    {/if}
</li>

{undef $path_array $current_node_id $is_current $is_active}
