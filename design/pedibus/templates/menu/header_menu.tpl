{if and( $pagedata.is_login_page|not(), array( 'edit', 'browse' )|contains( $ui_context )|not(), openpaini( 'TopMenu', 'ShowMegaMenu', 'enabled' )|eq('enabled') )}

{def $is_area_tematica = is_area_tematica()}
{if and($is_area_tematica, $is_area_tematica|has_attribute('link_al_menu_orizzontale'))}
    {def $top_menu_node_ids = array()}
    {foreach $is_area_tematica|attribute('link_al_menu_orizzontale').content.relation_list as $item}
        {set $top_menu_node_ids = $top_menu_node_ids|append($item.node_id)}
    {/foreach}
{else}
    {def $top_menu_node_ids = openpaini( 'TopMenu', 'NodiCustomMenu', array() )}
{/if}
{def $top_menu_node_ids_count = $top_menu_node_ids|count()}

{def $main_styles = openpaini( 'Stili', 'Nodo_NomeStile', array() )}
{def $item_class = "no-main-style"}

{if $top_menu_node_ids_count}
    <nav class="row" id="navigator">
        <div id="block-nav" class="container-fluid row-eq-height">
            <div class="navbar-header visible-xs-block no_pad">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Espandi menu</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-header" href="#"><img class="img-responsive main_logo" src="images/logo.png" alt="" title="" /></a>
            </div>
            <div id="navbar" class="navbar-collapse collapse" aria-expanded="false" style="height: 1px;">
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a href="/">Home</a>
                    </li>
                {foreach $top_menu_node_ids as $id}
                    {def $tree_menu = tree_menu( hash( 'root_node_id', $id, 'scope', 'top_menu'))}
                    <li{*{if $tree_menu.has_children} class="dropdown"{/if}*}>
                        {include recursion=0
                                    name=top_menu
                                    uri='design:menu/header_menu_item.tpl'
                                    menu_item=$tree_menu
                                    current=or($tree_menu.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($tree_menu.item.node_id))
                                    has_link=cond( $tree_menu.has_children, false(), true())}
                        {if $tree_menu.has_children}
                            {if $tree_menu.max_recursion|eq(1)}
                                <ul class="dropdown-menu">
                                    {foreach $tree_menu.children as $child}
                                            <li>
                                                {include
                                                recursion=1
                                                name="top_sub_menu" uri='design:menu/header_menu_item.tpl'
                                                menu_item=$child
                                                current=or($child.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($child.item.node_id))}
                                            </li>
                                    {/foreach}
                                </ul>
                            {else}
                                <ul class="dropdown-menu">
                                    {foreach $tree_menu.children as $child}
                                        <li>
                                            {include
                                            recursion=2
                                            name="top_sub_menu"
                                            uri='design:menu/header_menu_item.tpl'
                                            menu_item=$child
                                            current=or($child.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($child.item.node_id))}
                                            <ul>
                                                {if $child.has_children}
                                                    {foreach $child.children as $sub_child}
                                                        <li>{include
                                                            recursion=3
                                                            name="top_sub_menu"
                                                            uri='design:menu/header_menu_item.tpl'
                                                            menu_item=$sub_child
                                                            current=or($sub_child.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($sub_child.item.node_id))}
                                                        </li>
                                                    {/foreach}
                                                {/if}
                                            </ul>
                                        </li>
                                    {/foreach}
                                </ul>
                            {/if}
                        {/if}
                    </li>
                    {undef $tree_menu}
                {/foreach}
            {/if}
                </ul>
            </div>{*<!--/.nav-collapse -->*}
        </div>{*<!--/.container-fluid -->*}
    </nav>

{undef $is_area_tematica}
{/if}