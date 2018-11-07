{ezpagedata_set('has_container',  true())}
{def $__TITLE = $node.name|wash()}

{if $node.data_map.short_name.has_content}
    {set $__TITLE = $node.data_map.short_name.content|wash()}
{/if}
{def $current_user = fetch( 'user', 'current_user' )}


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
    <div class="container-fluid main_cage row_main_title">
        <div class="row">
            <div class="col-xs-12">
                <h1>{$__TITLE}</h1>
            </div>
        </div>
    </div>

    {def $__STOP_TIME_FIELD = ezini( 'IlPedibus', 'MapFermataOrario', 'ilpedibus.ini' )[$node.data_map.line_state.content.main_node.name]}

    {def $__MODULISTICA_URI = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'Modulistica', 'ilpedibus.ini' )))}

    {def $__DISPONIBILITA = fetch(
                                    'content',
                                    'reverse_related_objects',
                                    hash(
                                            'object_id',$node.object.id,
                                            'sort_by',  array( 'name', true() ),
                                            'all_relations', true(),
                                            'attribute_identifier', 'disponibilita/linea'
                                    )
                    )
    }

    {def $__ADESIONI = fetch(
                                    'content',
                                    'reverse_related_objects',
                                    hash(
                                            'object_id',$node.object.id,
                                            'sort_by',  array( 'name', true() ),
                                            'all_relations', true(),
                                            'attribute_identifier', 'adesione/linea'
                                    )
                    )
    }


    <div class="container-fluid main_cage row_content_with_side margin-both">
        <div class="row">
            <div class="col-sm-9 col-md-8 small_content">
                {if $node.data_map.fermate.content.relation_list|count()}
                    {cache-block subtree_expiry=$node.data_map.fermate.content.relation_list keys=concat($node.name|wash(),$node.node_id,"stop")}
                            <p><strong>Fermate e orari:</strong></p>

                            {if $node.data_map.fermate.content.relation_list|count()}
                                {cache-block subtree_expiry=$node.data_map.fermate.content.relation_list keys=concat($node.name|wash(),$node.node_id,"stop-time")}
                                    <div class="stops_and_times row_list_stops">
                                        <!--<p class="side_title"><i class="glyphicon glyphicon-time"></i><span>Orari:</span></p>-->
                                        <ul>
                                            {foreach $node.data_map.fermate.content.relation_list as $__SINGLE_FERMATA_REF}
                                                {def $__FERMATA = fetch('content','node',hash('node_id', $__SINGLE_FERMATA_REF.node_id))}
                                                <li>
                                                    <a href="{$__FERMATA.url|ezurl('no')}">
                                                        {if $__STOP_TIME_FIELD|eq("ora_andata")}
                                                            {if $__FERMATA.data_map.ora_andata.content|count_chars()}
                                                                <span class="times">
                                                                    {$__FERMATA.data_map.ora_andata.content}
                                                                </span>
                                                            {/if}
                                                        {else}
                                                            {if $__FERMATA.data_map.ora_ritorno.content|count_chars()}
                                                                <span class="times">
                                                                    {$__FERMATA.data_map.ora_ritorno.content}
                                                                </span>
                                                            {/if}
                                                        {/if}

            {*                                          {$__FERMATA.data_map.geo.content.address}*}
                                                        {$__FERMATA.name|wash()}

                                                    </a>
                                                </li>
                                                {undef $__FERMATA}
                                            {/foreach}
                                        </ul>
                                    </div>
                                {/cache-block}
                         {/if}
    <!--
                            <ul>
                            {foreach $node.data_map.fermate.content.relation_list as $__KEY => $__SINGLE_STOP_REF}
                                {def $__SINGLE_STOP = fetch('content', 'node', hash('node_id', $__SINGLE_STOP_REF.node_id))}

                                <li>{$__SINGLE_STOP.name|wash()}</li>

                                {undef $__SINGLE_STOP}
                            {/foreach}
                            </ul>
    -->
                    {/cache-block}
                {/if}

                 <p class="white-space">
                    {attribute_view_gui attribute=$node.data_map.description}
                </p>


                {if $node.data_map.image.has_content}
                    <img src="{$node.data_map.image.content['pedibus_line_full_image'].url|ezroot('no')}" alt="{$node.data_map.image.content.alternative_text|wash()}" title="{$node.data_map.image.content.alternative_text|wash()}" class="image_border"/>
                {/if}

    {*            <img src="images/ph_map.jpg"/>*}

    {*            <a href="#" class="btn btn_green"><i class="fa fa-map-marker"></i> Come Arrivare</a>*}
            </div>
            <div class="col-xs-12 col-sm-3 col-md-4">
                <div class="sidebar">
                    <p class="sidebar_title">Riferimenti</p>
                    {if $__DISPONIBILITA|count()}
                        {cache-block subtree_expiry=$__DISPONIBILITA keys=concat($node.name|wash(),$node.node_id,"avaiable")}
                            <div class="side_block side_volunteers">
                                <p class="side_title">
                                    <i class="fa fa-user" aria-hidden="true"></i>
                                    <span>Volontari:</span>
                                </p>
                                <ul>
                                {foreach $__DISPONIBILITA as $__SINGLE_DISPONIBILITA}
                                    {foreach $__SINGLE_DISPONIBILITA.main_node.data_map.volontario.content.relation_list as $__SINGLE_VOLONTARIO}
                                        {def $__VOLONTARIO = fetch('content','node',hash('node_id', $__SINGLE_VOLONTARIO.node_id))}

                                        <li>
                                            <a href="{$__VOLONTARIO.url|ezurl(no)}">{concat($__VOLONTARIO.data_map.nome.content," ", $__VOLONTARIO.data_map.cognome.content)}</a>
                                        </li>

                                        {undef $__VOLONTARIO_NAME}
                                        {undef $__VOLONTARIO}
                                    {/foreach}
                                {/foreach}
                                {undef $__SINGLE_VOLONTARIO}
                                {undef $__DISPONIBILITA}
                                </ul>
                            </div>
                        {/cache-block}
                    {/if}



                    {if and(
                            $__ADESIONI|count(),
                            $current_user.is_logged_in
                        )
                    }

                            <div class="side_block side_volunteers">
                                <p class="side_title">
                                    <i class="fa fa-user" aria-hidden="true"></i>
                                    <span>Bambini aderenti:</span>
                                </p>
                                <ul>
                                {foreach $__ADESIONI as $__SINGLE_ADESIONE}
                                    {foreach $__SINGLE_ADESIONE.main_node.data_map.bambino.content.relation_list as $__SINGLE_CHILD}
                                        {def $__CHILD = fetch('content','node',hash('node_id', $__SINGLE_CHILD.node_id))}

                                        {def $__REVERSE_RELATED_ITEMS_CHILD = fetch(
                                                                                'content',
                                                                                'reverse_related_objects',
                                                                                hash(
                                                                                        'object_id',$__CHILD.object.id,
                                                                                        'class_identifier', 'adulto',
                                                                                        'all_relations', true()
                                                                                )
                                                                        )
                                        }

                                        {def $__ADULT = ""}
                                        {foreach $__REVERSE_RELATED_ITEMS_CHILD as $__CONTENT_OBJ}
                                            {if $__CONTENT_OBJ.class_identifier|eq('adulto')}
                                                {set $__ADULT = $__CONTENT_OBJ.main_node}
                                                {break}
                                            {/if}
                                        {/foreach}

                                        <li>
                                            <a href="{$__ADULT.url|ezurl(no)}">
                                                {concat($__CHILD.data_map.nome.content," ", $__CHILD.data_map.cognome.content)}
                                            </a>
                                        </li>

                                        {undef $__ADULT}
                                        {undef $__REVERSE_RELATED_ITEMS_CHILD}
                                        {undef $__CHILD}
                                    {/foreach}
                                {/foreach}
                                {undef $__SINGLE_CHILD}
                                {undef $__ADESIONI}
                                </ul>
                            </div>
                    {/if}




    {*                {if $node.data_map.fermate.content.relation_list|count()}
                        {cache-block subtree_expiry=$node.data_map.fermate.content.relation_list keys=concat($node.name|wash(),$node.node_id,"stop-time")}
                            <div class="side_block side_times">
                                <p class="side_title"><i class="glyphicon glyphicon-time"></i><span>Orari:</span></p>
                                <ul>
                                    {foreach $node.data_map.fermate.content.relation_list as $__SINGLE_FERMATA_REF}
                                        {def $__FERMATA = fetch('content','node',hash('node_id', $__SINGLE_FERMATA_REF.node_id))}
                                        <li>
                                            <a href="{$__FERMATA.url|ezurl('no')}">
                                                {if $__STOP_TIME_FIELD|eq("Andata")}
                                                    {if $__FERMATA.data_map.ora_andata.content|count_chars()}
                                                        <span>
                                                            {$__FERMATA.data_map.ora_andata.content}
                                                        </span>
                                                    {/if}
                                                {else}
                                                    {if $__FERMATA.data_map.ora_ritorno.content|count_chars()}
                                                        <span>
                                                            {$__FERMATA.data_map.ora_ritorno.content}
                                                        </span>
                                                    {/if}
                                                {/if}
                                                {$__FERMATA.name|wash()}
                                            </a>
                                        </li>
                                        {undef $__FERMATA}
                                    {/foreach}
                                </ul>
                            </div>
                        {/cache-block}
                    {/if}*}
                    {if $__MODULISTICA_URI.url|count_chars()}
                        <div class="side_block side_docs">
                            <p class="side_title"><i class="fa fa-file-text" aria-hidden="true"></i><span>Iscrizione:</span></p>
                            <ul>
                                {if $__MODULISTICA_URI.url|count_chars()}
                                    <li><a href="{$__MODULISTICA_URI.url|ezurl(no)}" target="_blank">Modulistica</a></li>
                                {/if}
                            </ul>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>

    {undef}


</div>
