{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__TITLE = $node.name|wash()}
{def $__LIMIT = ezini( 'IlPedibus', 'adults_page_limit', 'ilpedibus.ini' )}
{def $__ADULTS = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', $node.node_id,
                            'class_identifier', 'adulto',
                            'sort_by', array( 'priority', true() ),
                            'offset', $view_parameters.offset,
                            'limit', $__LIMIT
                        )
                )
}

{def $__ADULTS_COUNT = fetch(
                            'content',
                            'list_count',
                            hash(
                                'parent_node_id', $node.node_id,
                                'class_identifier', 'adulto'
                            )
                    )
}


{if $node.data_map.short_name.has_content}
    {set $__TITLE = $node.data_map.short_name.content|wash()}
{/if}
<div class="container-fluid main_cage row_main_title adults">
    <div class="row">
        <div class="col-xs-12">
            <h1>{$__TITLE}</h1>
        </div>
    </div>
</div>

{if $__ADULTS_COUNT|count()}
    {def $current_user = fetch( 'user', 'current_user' )}
    {def $__LINES_FILTER = array()}
    {if $current_user.is_logged_in}
        {if $current_user.contentobject.class_identifier|eq("user_pedibus")}
            {foreach $current_user.contentobject.data_map.lines_enable_to_read.content.relation_list as $__LINE_REF}
                {set $__LINES_FILTER = $__LINES_FILTER|append($__LINE_REF.node_id)}
            {/foreach}
        {/if}
    {/if}

    {cache-block subtree_expiry=$node.url_alias keys=concat($node.name|wash(),$node.node_id,"adults",$view_parameters.offset,$__LIMIT,$current_user.is_logged_in,$current_user.contentobject.name)}
        <div class="container-fluid main_cage row_list_box margin-bottom">
            <div class="row">
                {foreach $__ADULTS as $__SINGLE_ADULT}

                    {def $__JUMP_ADULT = false()}

                    {if $__LINES_FILTER|count()}
                        {def $__LINES_RELATIVE_ADULT = 0}
                        {def $__LINES_RELATIVE_ADULT_TMP = array()}

                        {foreach $__SINGLE_ADULT.data_map.figli.content.relation_list as $__CHILD_REF}

                            {set $__LINES_RELATIVE_ADULT_TMP = fetch(
                                                                        'content',
                                                                        'reverse_related_objects',
                                                                        hash(
                                                                                'object_id',$__CHILD_REF.contentobject_id,
                                                                                'sort_by',  array( 'name', true() ),
                                                                                'all_relations', true(),
                                                                                'attribute_identifier', 'adesione/bambino'
                                                                        )
                                                                    )
                            }
                            {if $__LINES_RELATIVE_ADULT_TMP|count()}
                                {break}
                            {/if}


                            {undef $__LINES_RELATIVE_ADULT_TMP}
                        {/foreach}


                        {* Non ho nulla relazionato: in questo caso lo salto *}
                        {if $__LINES_RELATIVE_ADULT_TMP|count()|eq(0)}
                            {set $__JUMP_ADULT = true()}
                        {/if}

                        {foreach $__LINES_RELATIVE_ADULT_TMP as $__SINGLE_ITEM}

                            {if $__SINGLE_ITEM.contentclass_id|eq(ezini( 'IlPedibus', 'adesione_class_id', 'ilpedibus.ini' ))}
                                {set $__LINES_RELATIVE_ADULT = $__SINGLE_ITEM.main_node.data_map.linea.content.relation_list[0].node_id}
                                {skip}
                            {/if}
                        {/foreach}

                        {if $__LINES_RELATIVE_ADULT|gt(0)}
                            {if $__LINES_FILTER|contains($__LINES_RELATIVE_ADULT)|not()}
                                {set $__JUMP_ADULT = true()}
                            {/if}
                        {/if}
                        {undef $__LINES_RELATIVE_ADULT_TMP}
                        {undef $__LINES_RELATIVE_ADULT}
                    {/if}

                    {if $__JUMP_ADULT|not()}
                        <div class="col-xs-6 col-sm-3 single_block">
                            <a href="{$__SINGLE_ADULT.url|ezurl(no)}">
                            {cache-block keys=concat($__SINGLE_ADULT.name|wash(),$__SINGLE_ADULT.node_id,"pedibus_adult_full_image")}

                                {if $__SINGLE_ADULT.data_map.image.has_content}
                                    <div class="contain-img" style="background-image:url({$__SINGLE_ADULT.data_map.image.content['pedibus_adult_image'].url|ezroot('no')})" ></div>
                                {else}
                                    <div class="contain-img" style="background-image:url({'placeholder-volontario.png'|ezimage('no')})" ></div>
                                {/if}

                                <div class="btn_over_box">
                                        <span>{$__SINGLE_ADULT.name|wash()}</span>
                                    </div>
                                {if $__SINGLE_ADULT.data_map.abstract.has_content}
                                    <div class="box_caption">
                                        <p>{$__SINGLE_ADULT.data_map.abstract.content}</p>
                                    </div>
                                {/if}
                            {/cache-block}
                            </a>
                        </div>
                    {/if}
                    {undef $__JUMP_ADULT}
                {/foreach}
            </div>
        </div>
    {/cache-block}
    {include name=navigator
            uri='design:navigator/google.tpl'
            page_uri=$node.url_alias
            item_count=$__ADULTS_COUNT
            view_parameters=$view_parameters
            item_limit=$__LIMIT}
{/if}
{undef}