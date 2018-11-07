{ezpagedata_set('has_container',  true())}
{def $__LIMIT = ezini( 'IlPedibus', 'max_childs_under_users_page', 'ilpedibus.ini' )}
{def $__TITLE = $node.name|wash()}
{if $node.data_map.short_name.has_content}
    {set $__TITLE = $node.data_map.short_name.content|wash()}
{/if}

{def $__OBJS = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', $node.node_id,
                            'sort_by', array( 'priority', true() ),
                            'offset', $view_parameters.offset,
                            'limit', $__LIMIT
                        )
                    )
}

{def $__OBJS_COUNT = fetch(
                            'content',
                            'list_count',
                            hash(
                                'parent_node_id', $node.node_id,
                                'class_identifier', 'fermata'
                            )
                    )
}
<div class="container-fluid main_cage row_main_title">
    <div class="row">
        <div class="col-xs-12">
            <h1>{$__TITLE}</h1>
        </div>
    </div>
</div>

{if $__OBJS_COUNT|count()}
    <div class="container-fluid main_cage row_list_box margin-bottom">
        <div class="row">
        {foreach $__OBJS as $__OBJ}
            <div class="col-xs-6 col-sm-3 single_block">
                <a href="{$__OBJ.url|ezurl('no')}">
                    {if $__OBJ.data_map.image.has_content}
                        <div class="contain-img" style="background-image:url({$__OBJ.data_map.image.content['pedibus_generic_image'].url|ezroot('no')})" >

                        </div>
                    {else}
                        <div class="contain-img" style="background-image:url({'placeholder-volontario.png'|ezimage('no')})" >

                        </div>
                    {/if}

                    <div class="btn_over_box">
                        <span>{$__OBJ.name|wash()}</span>
                    </div>
                    {if $__OBJ.data_map.abstract.has_content}
                        <div class="box_caption">
                        {attribute_view_gui attribute=$__OBJ.data_map.abstract}
                        </div>
                    {/if}
                </a>
            </div>
        {/foreach}
        </div>
    </div>
    {include name=navigator
            uri='design:navigator/google.tpl'
            page_uri=$node.url_alias
            item_count=$__OBJS_COUNT
            view_parameters=$view_parameters
            item_limit=$__LIMIT}
{/if}
