{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__TITLE = $node.name|wash()}
{def $__LIMIT = ezini( 'IlPedibus', 'childs_page_limit', 'ilpedibus.ini' )}
{* Deciso di prendere solo i bambini che sono sotto adesioni  *}
{def $__ACCESSIONS = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', ezini( 'IlPedibus', 'Adesioni', 'ilpedibus.ini' ),
                            'class_identifier', 'adesione',
                            'sort_by', array( 'name', true() ),
                            'offset', $view_parameters.offset,
                            'limit', $__LIMIT
                        )
                    )}
{def $__ACCESSIONS_COUNT = fetch(
                            'content',
                            'list_count',
                            hash(
                                'parent_node_id', $node.node_id,
                                'class_identifier', 'adesione'
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

{if $__ACCESSIONS_COUNT|count()}
    {def $current_user = fetch( 'user', 'current_user' )}
    {def $__LINES_FILTER = array()}
    {if $current_user.is_logged_in}
        {if $current_user.contentobject.class_identifier|eq("user_pedibus")}
            {foreach $current_user.contentobject.data_map.lines_enable_to_read.content.relation_list as $__LINE_REF}
                {set $__LINES_FILTER = $__LINES_FILTER|append($__LINE_REF.node_id)}
            {/foreach}
        {/if}
    {/if}

    {cache-block subtree_expiry=$node.url_alias keys=concat($node.name|wash(),$node.node_id,"accessions",$view_parameters.offset,$__LIMIT,$current_user.is_logged_in,$current_user.contentobject.name)}
        <div class="container-fluid main_cage row_list_stops margin-bottom">
            <div class="row">
                <div class="col-xs-12">
                    <ul>
                        {foreach $__ACCESSIONS as $__ACCESSION_REF}
                            {def $__ACCESSION = fetch('content', 'node', hash('node_id', $__ACCESSION_REF.node_id))}
                            {if $__ACCESSION.data_map.bambino.content.relation_list|count()}

                                {if $__LINES_FILTER|count()}
                                    {if $__LINES_FILTER|contains($__ACCESSION.data_map.linea.content.relation_list[0].node_id)|not()}
                                        {skip}
                                    {/if}
                                {/if}

                                {def $__SINGLE_CHILD = fetch(
                                                                'content',
                                                                'node',
                                                                hash(
                                                                    'node_id',
                                                                    $__ACCESSION.data_map.bambino.content.relation_list[0].node_id
                                                                )
                                                            )
                                }

                                {def $__REVERSE_RELATED_OBJS = fetch(
                                        'content',
                                        'reverse_related_objects',
                                        hash(
                                                'object_id',$__SINGLE_CHILD.contentobject_id,
                                                'sort_by',  array( 'name', true() ),
                                                'attribute_identifier', 'adulto/figli'
                                        )
                                    )
                                }


                                <li>
                                    <div class="name_child col-md-3">{$__SINGLE_CHILD.name|wash()}</div>
                                    <div class="name_adult col-md-9">
                                        {* Prendo sempre il primo genitore *}
                                        {if $__REVERSE_RELATED_OBJS|count()}
                                            <a href="{$__REVERSE_RELATED_OBJS[0].main_node.url|ezroot('no')}" class="btn">
                                                Accedi ai dati del genitore di <strong>{$__SINGLE_CHILD.name|wash()}</strong>
                                            </a>
                                        {/if}
                                    </div>
                                </li>
                            {/if}
                        {undef $__REVERSE_RELATED_OBJS}
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
    {/cache-block}
    {include name=navigator
            uri='design:navigator/google.tpl'
            page_uri=$node.url_alias
            item_count=$__ACCESSIONS_COUNT
            view_parameters=$view_parameters
            item_limit=$__LIMIT}
{/if}
{undef}