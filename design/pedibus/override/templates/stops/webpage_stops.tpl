{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__TITLE = $node.name|wash()}
{def $__LIMIT = ezini( 'IlPedibus', 'stops_page_limit', 'ilpedibus.ini' )}
{def $__STOPS = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', $node.node_id,
                            'class_identifier', 'fermata',
                            'sort_by', array( 'priority', true() )
                        )
                )
}

{if $node.data_map.short_name.has_content}
    {set $__TITLE = $node.data_map.short_name.content|wash()}
{/if}
<div class="container-fluid main_cage row_main_title">
    <div class="row">
        <div class="col-xs-12">
            <h1>{$__TITLE}</h1>
        </div>
    </div>
</div>

{*{ fetch('content', 'node', hash('node_id', $__LINEE[0].data_map.fermate.content.relation_list[0]))|attribute(show)}*}

{if $__STOPS|count()}
    {def $current_user = fetch( 'user', 'current_user' )}
    {def $__LINES_FILTER = array()}
    {if $current_user.is_logged_in}
        {if $current_user.contentobject.class_identifier|eq("user_pedibus")}
            {foreach $current_user.contentobject.data_map.lines_enable_to_read.content.relation_list as $__LINE_REF}
                {set $__LINES_FILTER = $__LINES_FILTER|append($__LINE_REF.node_id)}
            {/foreach}
        {/if}
    {/if}

    {cache-block subtree_expiry=$__STOPS keys=concat($node.name|wash(),$node.node_id,"stops",$view_parameters.offset,$__LIMIT,$current_user.is_logged_in,$current_user.contentobject.name)}
        <div class="container-fluid main_cage row_list_stops line margin-bottom">
            <div class="row">
                <div class="col-xs-12">
                    <ul>
                    {def $__BUTTON_CLASS = ""}
                    {foreach $__STOPS|extract($view_parameters.offset,$__LIMIT) as $__SINGLE_STOP}
                        {*--------------------------------*}
                        {def $__JUMP_LOOP = false()}
                        {if $__LINES_FILTER|count()}
                            {def $__LINES_RELATIVE = 0}
                            {def $__LINES = fetch(
                                                            'content',
                                                            'reverse_related_objects',
                                                            hash(
                                                                    'object_id',$__SINGLE_STOP.object.id,
                                                                    'sort_by',  array( 'name', true() ),
                                                                    'all_relations', true(),
                                                                    'attribute_identifier', 'linea/fermate'
                                                            )
                                            )
                            }

                            {if $__LINES|count()|eq(0)}
                                {set $__JUMP_LOOP = true()}
                            {/if}

                            {foreach $__LINES as $__SINGLE_ITEM}
                                {if $__SINGLE_ITEM.class_identifier|eq("linea")}
                                    {set $__LINES_RELATIVE = $__SINGLE_ITEM.main_node..node_id}
                                    {skip}
                                {/if}
                            {/foreach}

                            {if $__LINES_FILTER|contains($__LINES_RELATIVE)|not()}
                                {set $__JUMP_LOOP = true()}
                            {/if}
                            {undef $__LINES}
                            {undef $__LINES_RELATIVE}
                        {/if}
                        {*--------------------------------*}
                        {if $__JUMP_LOOP|not()}
                            {if $__SINGLE_STOP.name|downcase()|contains("linea rossa")}
                                {set $__BUTTON_CLASS = " red_line"}
                            {elseif $__SINGLE_STOP.name|downcase()|contains("linea verde")}
                                {set $__BUTTON_CLASS = " green_line"}
                            {elseif $__SINGLE_STOP.name|downcase()|contains("linea gialla")}
                                {set $__BUTTON_CLASS = " yellow_line"}
                            {elseif $__SINGLE_STOP.name|downcase()|contains("linea blu")}
                                {set $__BUTTON_CLASS = " blue_line"}
                            {/if}
                            <li class="{$__BUTTON_CLASS}">
                                <a href="{$__SINGLE_STOP.url|ezurl(no)}">{$__SINGLE_STOP.name|wash()}</a>
                            </li>
                        {/if}
                    {/foreach}
                    {undef $__BUTTON_CLASS}
                    </ul>
                </div>
            </div>
        </div>
    {/cache-block}
    {include name=navigator
            uri='design:navigator/google.tpl'
            page_uri=$node.url_alias
            item_count=$__STOPS|count()
            view_parameters=$view_parameters
            item_limit=$__LIMIT}
{/if}
{undef}