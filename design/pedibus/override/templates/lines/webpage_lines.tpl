{ezpagedata_set('has_container',  true())}
{*set-block scope=root variable=cache_ttl}0{/set-block*}
{def $__LIMIT = ezini( 'IlPedibus', 'max_lines', 'ilpedibus.ini' )}
{def $__TITLE = $node.name|wash()}
{def $__LINEE = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', $node.node_id,
                            'class_identifier', 'linea',
                            'sort_by', array( 'priority', true() ),
                            'offset', $view_parameters.offset,
                            'limit', $__LIMIT
                        )
                    )}

{def $__LINEE_COUNT = fetch(
                            'content',
                            'list_count',
                            hash(
                                'parent_node_id', $node.node_id,
                                'class_identifier', 'linea'
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

{if $__LINEE_COUNT|count()}
    {def $current_user = fetch( 'user', 'current_user' )}
    {def $__LINES_FILTER = array()}
    {if $current_user.is_logged_in}
        {if $current_user.contentobject.class_identifier|eq("user_pedibus")}
            {foreach $current_user.contentobject.data_map.lines_enable_to_read.content.relation_list as $__LINE_REF}
                {set $__LINES_FILTER = $__LINES_FILTER|append($__LINE_REF.node_id)}
            {/foreach}
        {/if}
    {/if}

    {*cache-block subtree_expiry=$node.url_alias keys=concat($node.name|wash(),$node.node_id,"linee",$current_user.is_logged_in,$current_user.contentobject.name)*}
        <div class="container-fluid main_cage row_list_lines margin-bottom">
            <div class="row">
            {foreach $__LINEE as $__SINGLE_LINE}
                {if $__LINES_FILTER|count()}
                    {if $__LINES_FILTER|contains($__SINGLE_LINE.node_id)|not()}
                        {skip}
                    {/if}
                {/if}
                <div class="single_block col-sm-6">
                    <a href="{$__SINGLE_LINE.url}" class="row-eq-height">
                        {if $__SINGLE_LINE.data_map.image.has_content}
                            <div class="col-sm-4 col-sm-3">
                                <div class="contain-img" style="background: url({$__SINGLE_LINE.data_map.image.content['pedibus_line_image'].url|ezroot('no')})">
                                </div>
                            </div>
                        {/if}

                        <div class="col-sm-8 col-sm-9 line_caption">
                            {def $__BUTTON_CLASS = ""}
                            {if $__SINGLE_LINE.name|downcase()|contains("linea rossa")}
                                {set $__BUTTON_CLASS = " red_line"}
                            {elseif $__SINGLE_LINE.name|downcase()|contains("linea verde")}
                                {set $__BUTTON_CLASS = " green_line"}
                            {elseif $__SINGLE_LINE.name|downcase()|contains("linea gialla")}
                                {set $__BUTTON_CLASS = " yellow_line"}
                            {elseif $__SINGLE_LINE.name|downcase()|contains("linea blu")}
                                {set $__BUTTON_CLASS = " blue_line"}
                            {/if}
                            <p class="line_title{$__BUTTON_CLASS}">{$__SINGLE_LINE.name|wash()}</p>
                            {if $__SINGLE_LINE.data_map.fermate.content.relation_list|count()}
                                {*cache-block subtree_expiry=$__SINGLE_LINE.data_map.fermate.content.relation_list keys=concat($node.name|wash(),$node.node_id,"stops")*}
                                    <p class="white-space">
                                        <strong>Fermate</strong>
                                        {foreach  $__SINGLE_LINE.data_map.fermate.content.relation_list as $__KEY => $__SINGLE_STOP_REF}
                                            {def $__SINGLE_STOP = fetch('content', 'node', hash('node_id', $__SINGLE_STOP_REF.node_id))}

                                            {$__SINGLE_STOP.name|wash()}{if inc($__KEY)|lt($__SINGLE_LINE.data_map.fermate.content.relation_list|count())}&nbsp;-{/if}
                                            {undef $__SINGLE_STOP}
                                        {/foreach}
                                    </p>
                                {*/cache-block*}
                            {/if}
                            {undef $__BUTTON_CLASS}
                        </div>
                    </a>
                </div>
            {/foreach}
            </div>
        </div>
    {*/cache-block*}
    {include name=navigator
            uri='design:navigator/google.tpl'
            page_uri=$node.url_alias
            item_count=$__LINEE_COUNT
            view_parameters=$view_parameters
            item_limit=$__LIMIT}
{/if}
{undef}
