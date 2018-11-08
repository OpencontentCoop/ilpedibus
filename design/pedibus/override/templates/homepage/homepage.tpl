{ezpagedata_set('has_container',  true())}
{def $__HOME_BLOCKS = $node.data_map.homepage_blocks.content.relation_list}
{def $__HOME_BLOCK = ""}
{def $__TITLE = ''}
<div class="container-fluid main_cage first_row_hp">
    <div class="row">
    {cache-block subtree_expiry=$__HOME_BLOCKS keys=concat($node.name|wash(),$node.node_id)}
        {foreach $__HOME_BLOCKS as $__KEY => $__NODE_RELATION}
            {set $__HOME_BLOCK = fetch('content','node',hash('node_id',$__NODE_RELATION.node_id))}

{*                {$__HOME_BLOCK.data_map.image.content['hpedi_block']|attribute(show)}*}

            {set $__TITLE = $__HOME_BLOCK.name|wash()}
            <div class="col-sm-4 col-lg-3{if $__KEY|eq(0)} col-lg-offset-1{/if} single_block">
                <a href="{$__HOME_BLOCK.url|ezurl('no')}">
                    {if $__HOME_BLOCK.data_map.image.has_content}
                    <div class="contain-img" style="background-image:url({$__HOME_BLOCK.data_map.image.content['hpedi_block'].url|ezroot('no')})">
                    </div>
                    {/if}
                     <div class="btn_over_box">
                        <span>{$__TITLE}</span>
                    </div>
                    {if $__HOME_BLOCK.data_map.abstract.has_content}
                        <div class="box_caption">
                            <p>{$__HOME_BLOCK.data_map.abstract.content|wash()}</p>
                        </div>
                    {/if}
                </a>
            </div>
        {/foreach}
    {/cache-block}
    </div>
</div>

{*{def $__HOME_NODE = fetch('content','node',hash('node_id',2))}

{$__HOME_NODE.data_map.page|attribute(show)}

{attribute_view_gui attribute=$__HOME_NODE.data_map.page}*}

{*{def $openpa = object_handler($__HOME_NODE)}*}

{*{$openpa|attribute(show)}*}

{*{if openpaini('SemanticClassGroup_classificazione','Classes',array())|contains($node.class_identifier)}
<p>
    PRIMO
</p>
    {include uri="design:openpa/full/_classificazione.tpl"}
{else}
<p>
    SECONDO
</p>
    {include uri=$openpa.control_template.full}
{/if}*}

{undef}

