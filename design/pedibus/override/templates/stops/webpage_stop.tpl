{def $__TITLE = $node.name|wash()}

{if $node.data_map.short_name.has_content}
    {set $__TITLE = $node.data_map.short_name.content|wash()}
{/if}

{def $__BUTTON_CLASS = ""}
{if $__TITLE|downcase()|contains("linea rossa")}
    {set $__BUTTON_CLASS = " red_line"}
{elseif $__TITLE|downcase()|contains("linea verde")}
    {set $__BUTTON_CLASS = " green_line"}
{elseif $__TITLE|downcase()|contains("linea gialla")}
    {set $__BUTTON_CLASS = " yellow_line"}
{elseif $__TITLE|downcase()|contains("linea blu")}
    {set $__BUTTON_CLASS = " blue_line"}
{/if}
<div class="{$__BUTTON_CLASS}">
{undef $__BUTTON_CLASS}

    <div class="container-fluid main_cage row_main_title">
        <div class="row">
            <div class="col-xs-12">
                <h1>{$__TITLE}</h1>
            </div>
        </div>
    </div>

    {def $__LINES = fetch(
                                    'content',
                                    'reverse_related_objects',
                                    hash(
                                            'object_id',$node.object.id,
                                            'sort_by',  array( 'name', true() ),
                                            'all_relations', true(),
                                            'attribute_identifier', 'linea/fermate'
                                    )
                    )
    }

    {def $__MODULISTICA_URI = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'Modulistica', 'ilpedibus.ini' )))}

    <div class="container-fluid main_cage row_content_with_side margin-both">
        <div class="row">
            <div class="col-sm-9 col-md-8 small_content">

                 <p><strong>Fermate e orari:</strong></p>

                <div class="stops_and_times row_list_stops">
                    <ul>
                        <li>
                            <span class="times">{$node.data_map.ora_andata.content}</span>
                            <span class="name_lines"></span> {$__TITLE}
                        </li>
                        {if $node.data_map.ora_ritorno.has_content}
                            <li>
                                <span class="times">{$node.data_map.ora_ritorno.content}</span>
                                <span class="name_lines"></span> {$__TITLE}
                            </li>
                        {/if}
                    </ul>
                </div>



                <p class="white-space">
                    {attribute_view_gui attribute=$node.data_map.description}
                </p>

                {attribute_view_gui attribute=$node.data_map.geo}
            </div>
            <div class="col-sm-3 col-md-4">
                <div class="sidebar">
                    {if $__LINES|count()}
                        {cache-block subtree_expiry=$__LINES keys=concat($node.name|wash(),$node.node_id,"avaiable")}
                            <div class="side_block side_volunteers">
                                <p class="side_title">
                                    <i class="fa{* fa-user*}" aria-hidden="true"></i>
                                    <span>Riferimenti:</span>
                                </p>
                                <ul>
                                {foreach $__LINES as $__SINGLE_LINE}
                                    {if $__SINGLE_LINE.main_node.class_identifier|eq("linea")}
                                        <li>
                                            <a href="{$__SINGLE_LINE.main_node.url|ezurl(no)}">{$__SINGLE_LINE.main_node.name|wash()}</a>
                                        </li>
                                    {/if}
                                {/foreach}
                                {undef $__SINGLE_LINE}
                                </ul>
                            </div>
                        {/cache-block}
                    {/if}


                    {if $__MODULISTICA_URI.url|count_chars()}
                        <div class="side_block side_docs">
                            <p class="side_title"><i class="fa fa-file-text" aria-hidden="true"></i><span>Iscrizione:</span></p>
                            <ul>
                                {if $__MODULISTICA_URI.url|count_chars()}
                                    <li><a href="{$__MODULISTICA_URI.url|ezurl(no)}" target="_blank">Accedi alla modulistica per l'iscrizione</a></li>
                                {/if}
                            </ul>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>
{undef}