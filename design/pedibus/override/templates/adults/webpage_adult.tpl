{ezpagedata_set('has_container',  true())}
{def $current_user = fetch( 'user', 'current_user' )}

{def $__TITLE = $node.name|wash()}


{def $__CALENDARIO_DISPONIBILITA_URI = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'CalendarioDisponibilita', 'ilpedibus.ini' )))}

{def $__MODULISTICA_URI = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'Modulistica', 'ilpedibus.ini' )))}

{def $__REVERSE_RELATED_ITEMS = fetch(
                                        'content',
                                        'reverse_related_objects',
                                        hash(
                                                'object_id',$node.object.id,
                                                'sort_by',  array( 'name', true() ),
                                                'all_relations', true()
                                        )
                                )
}

{def $__CHILDS = array()}

{if and(
        $current_user.is_logged_in,
        $node.data_map.figli.content.relation_list|count()
    )
}
    {foreach $node.data_map.figli.content.relation_list as $__USER_CHILD_REF }
        {def $__CHILD = fetch('content','node',hash('node_id', $__USER_CHILD_REF.node_id))}

        {def $__REVERSE_RELATED_ITEMS_CHILD = fetch(
                                                'content',
                                                'reverse_related_objects',
                                                hash(
                                                        'object_id',$__CHILD.object.id,
                                                        'class_identifier', 'adesione',
                                                        'all_relations', true()
                                                )
                                        )
        }

{def $__CHILD_LINES = array()}
{def $__CHILD_STOPPED = array()}
{def $__CHILD_DATA = ""}
{foreach $__REVERSE_RELATED_ITEMS_CHILD as $__POPP => $__OBJ_RELATED}
    {if $__OBJ_RELATED.main_node.class_identifier|eq('adesione')}
{*        <p>
            {$__POPP}){$__OBJ_RELATED.main_node.data_map.dal|attribute(show)}
        </p>
        <hr><br/>*}

        {foreach $__OBJ_RELATED.main_node.data_map.linea.content.relation_list as $__KEY => $__LINE_RELATED_REF}
            {def $__TEMP = fetch('content','node',hash('node_id', $__LINE_RELATED_REF.node_id))}

            {if $__CHILD_LINES|contains($__TEMP.name|wash())|not()}
                {set $__CHILD_LINES = $__CHILD_LINES|append($__TEMP.name|wash())}
            {/if}

            {undef $__TEMP}
        {/foreach}

        {foreach $__OBJ_RELATED.main_node.data_map.stopped.content.relation_list as $__KEY => $__STOP_RELATED_REF}
            {def $__TEMP = fetch('content','node',hash('node_id', $__STOP_RELATED_REF.node_id))}

            {if $__CHILD_STOPPED|contains($__TEMP.name|wash())|not()}
                {set $__CHILD_STOPPED = $__CHILD_STOPPED|append($__TEMP.name|wash())}
            {/if}

            {undef $__TEMP}
        {/foreach}


        {set $__CHILD_DATA = concat("Dal ", $__OBJ_RELATED.main_node.data_map.dal.data_int|datetime('custom', '%d/%m/%Y') ," al ",$__OBJ_RELATED.main_node.data_map.al.data_int|datetime('custom', '%d/%m/%Y'))}

    {/if}
{/foreach}
{undef $__REVERSE_RELATED_ITEMS_CHILD}


        {def $__CHILD_INFO = hash(
                                    'name', $__CHILD.name|wash(),
                                    'class_room', $__CHILD.data_map.child_school_room.content|wash(),
                                    'note', $__CHILD.data_map.note.content|wash(),
                                    'linee', $__CHILD_LINES|implode( ', ' ),
                                    'fermate', $__CHILD_STOPPED|implode( ', ' ),
                                    'data', $__CHILD_DATA
        )}
{*{$__CHILD_INFO|attribute(show)}*}


        {set $__CHILDS = $__CHILDS|append($__CHILD_INFO)}

{*        {set $__CHILDS = $__CHILDS|append($__CHILD.name|wash())}*}
        {undef $__CHILD_LINES}
        {undef $__CHILD_STOPPED}
        {undef $__CHILD_DATA}
        {undef $__CHILD_INFO}
        {undef $__CHILD}
    {/foreach}
{/if}


{*{$__CHILDS|attribute(show)}*}

<div class="container-fluid main_cage row_main_title">
    <div class="row">
        <div class="col-xs-12">
            <h1>{$__TITLE}</h1>
        </div>
    </div>
</div>


<div class="container-fluid main_cage row_content_with_side margin-both">

    <div class="row">

        <div class="col-sm-9 col-md-8 small_content">

            <div class="row">
                <div class="col-md-3">
                    {if $node.data_map.image.has_content}
                        {*cache-block keys=concat($node.name|wash(),$node.node_id,"pedibus_adult_full_image")*}
                            <img src="{$node.data_map.image.content['pedibus_adult_full_image'].url|ezroot('no')}" alt="{$node.data_map.image.content.alternative_text|wash()}" title="{$node.data_map.image.content.alternative_text|wash()}"/>
                        {*/cache-block*}
                    {else}
                        <img src="{'placeholder-volontario.png'|ezimage('no')}" title="{$node.data_map.image.content.alternative_text|wash()}"/>
                    {/if}
                </div>
                    <div class="col-md-9">
                    {if $current_user.is_logged_in}
                        {if $node.data_map.indirizzo.has_content}
                            <p class="white-space" id="address">
                                Indirizzo: {$node.data_map.indirizzo.content|wash()}
                            </p>
                        {/if}
                        {if $node.data_map.telefono.has_content}
                            <p class="white-space" id="tel">
                                <i class="fa fa-phone" aria-hidden="true"></i>
                                <strong>Telefono:</strong> <a href="tel:{$node.data_map.telefono.content}">{$node.data_map.telefono.content}</a>
                            </p>
                        {/if}
                        {if $node.data_map.email.has_content}
                            <p class="white-space" id="email">
                                <i class="fa fa-envelope" aria-hidden="true"></i>
                                <strong>Email:</strong> <a href="mailto:{$node.data_map.email.content}">{$node.data_map.email.content|wash()}</a>
                            </p>
                        {/if}
                    {/if}
                {if $__CHILDS|count()}
                    <p class="white-space" id="genitore">
                        <strong>Genitore di:</strong>
                        <ul>

                                {foreach $__CHILDS as $__POS => $__CHILD}
                                <li>
                                    {$__CHILD['name']}<br>
                                    {if $__CHILD['class_room']|count_chars}
                                        Classe: {$__CHILD['class_room']} <br>
                                    {/if}
                                    {if $__CHILD['linee']|count_chars}
                                        Iscritto alla linea: {$__CHILD['linee']} <br>
                                    {/if}
                                    {if $__CHILD['fermate']|count_chars}
                                        Fermata: {$__CHILD['fermate']}<br>
                                    {/if}
                                    {if $__CHILD['data']|count_chars}
                                        Periodo: {$__CHILD['data']}<br>
                                    {/if}
                                    {if $__CHILD['note']|count_chars}
                                        Note varie: {$__CHILD['note']}
                                    {/if}
                                </li>
                                {/foreach}

                        </ul>

                    </p>
                {/if}
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <p class="white-space">
                        {attribute_view_gui attribute=$node.data_map.body}
                    </p>
                </div>
            </div>
            <div class="row absences_substitutions block">
                <div class="col-md-12">
                    {if $current_user.is_logged_in}
                    {*cache-block subtree_expiry=$__REVERSE_RELATED_ITEMS keys=concat($node.name|wash(),$node.node_id,"adult_not_avaiable")*}
                        <div class="side_block side_absences">
                            <p class="side_title"><i class="glyphicon glyphicon-time"></i><span>Assenze:</span></p>
                            <div class="list_availability">
                                <ul>
                                {foreach $__REVERSE_RELATED_ITEMS as $__SINGLE_ITEM}
                                    {if $__SINGLE_ITEM.contentclass_id|eq(ezini( 'IlPedibus', 'adult_not_avaiable', 'ilpedibus.ini' ))}
                                        <li>
                                        {foreach $__SINGLE_ITEM.main_node.data_map.linea.content.relation_list as $__SINGLE_ITEM_REF}
                                            {def $__SINGLE_ITEM_OBJ = fetch('content','node',hash('node_id', $__SINGLE_ITEM_REF.node_id))}
                                            <span class="line_name">
                                                <a href="{$__SINGLE_ITEM_OBJ.url|ezurl(no)}">{$__SINGLE_ITEM_OBJ.name|wash()}</a>
                                            </span>
                                            {undef $__SINGLE_ITEM_OBJ}
                                        {/foreach}
                                        <span class="ava_date"><span>nel giorno: </span>{$__SINGLE_ITEM.main_node.data_map.data.data_int|datetime('custom', '%l %d %F %Y')}</span>
                                        {def $__REVERSE_RELATED_REPLACEMENTS = fetch(
                                                                                    'content',
                                                                                    'reverse_related_objects',
                                                                                hash(
                                                                                        'object_id',$__SINGLE_ITEM.main_node.contentobject_id,
                                                                                        'sort_by',  array( 'name', true() ),
                                                                                        'all_relations', true()
                                                                                )
                                                                        )
                                        }

                                        {foreach $__REVERSE_RELATED_REPLACEMENTS as $__SINGLE_ITEM}
                                            {foreach $__SINGLE_ITEM.main_node.data_map.volontario.content.relation_list as $__SINGLE_REPLACE_VOLONTARIO_REF}
                                                {def $__SINGLE_REPLACE_VOLONTARIO = fetch('content','node',hash('node_id', $__SINGLE_REPLACE_VOLONTARIO_REF.node_id))}

                                                <span class="replacement">sostituito da: <a href="{$__SINGLE_REPLACE_VOLONTARIO.url|ezurl(no)}">{$__SINGLE_REPLACE_VOLONTARIO.name|wash()}</a></span>
                                                {undef $__SINGLE_REPLACE_VOLONTARIO}
                                            {/foreach}
                                        {/foreach}
                                    </li>
                                    {/if}
                                {/foreach}
                                </ul>
                            </div>
                        </div>
                    {*/cache-block*}
                
                    {*cache-block subtree_expiry=$__REVERSE_RELATED_ITEMS keys=concat($node.name|wash(),$node.node_id,"adult_replace")*}
                        <div class="side_block side_replacements">
                            <p class="side_title"><i class="glyphicon glyphicon-time"></i><span>Sostituzioni:</span></p>
                            <div class="list_availability">
                                <ul>
                                    {foreach $__REVERSE_RELATED_ITEMS as $__SINGLE_ITEM}
                                    {if $__SINGLE_ITEM.contentclass_id|eq(ezini( 'IlPedibus', 'adult_replace', 'ilpedibus.ini' ))}
                                        <li>
                                        {foreach $__SINGLE_ITEM.main_node.data_map.assenza.content.relation_list as $__SINGLE_ITEM_REF}
                                            {def $__SINGLE_ITEM_OBJ = fetch('content','node',hash('node_id', $__SINGLE_ITEM_REF.node_id))}

                                            {foreach $__SINGLE_ITEM_OBJ.data_map.linea.content.relation_list as $__SINGLE_ITEM_TEM_REF}
                                                {def $__SINGLE_ITEM_ITEM_OBJ = fetch('content','node',hash('node_id', $__SINGLE_ITEM_TEM_REF.node_id))}
                                                <span class="line_name">
                                                    <a href="{$__SINGLE_ITEM_ITEM_OBJ.url|ezurl(no)}">{$__SINGLE_ITEM_ITEM_OBJ.name|wash()}</a>
                                                </span>
                                                <span class="ava_date"><span>nel giorno: </span>{$__SINGLE_ITEM_OBJ.data_map.data.data_int|datetime('custom', '%l %d %F %Y')}</span>

                                            {/foreach}

                                            {foreach $__SINGLE_ITEM_OBJ.data_map.volontario.content.relation_list as $__SINGLE_ITEM_REF}
                                                {def $__SINGLE_ITEM_OBJ = fetch('content','node',hash('node_id', $__SINGLE_ITEM_REF.node_id))}
                                                <span class="replacement">in sostituzione a: <a href="{$__SINGLE_ITEM_OBJ.url|ezurl(no)}">{$__SINGLE_ITEM_OBJ.name|wash()}</a></span>
                                                {undef $__SINGLE_ITEM_OBJ}
                                            {/foreach}

                                            {undef $__SINGLE_ITEM_OBJ}
                                        {/foreach}
                                        </li>
                                    {/if}
                                {/foreach}
                                </ul>
                            </div>
                        </div>
                    {*/cache-block*}
                {/if}

                </div>
            </div>
        </div>

        {if $__REVERSE_RELATED_ITEMS|count()}
        <div class="col-sm-3 col-md-4">
            <div class="sidebar">
                <p class="sidebar_title">Riferimenti</p>
                {*cache-block subtree_expiry=$__REVERSE_RELATED_ITEMS keys=concat($node.name|wash(),$node.node_id,"avaiable")*}
                    <div class="side_block ">
                        <p class="side_title"><i class="fa fa-user" aria-hidden="true"></i><span>Disponibilità:</span></p>
                        <div class="list_availability">
                        {foreach $__REVERSE_RELATED_ITEMS as $__SINGLE_ITEM}
                            {if $__SINGLE_ITEM.contentclass_id|eq(ezini( 'IlPedibus', 'adult_avaiable', 'ilpedibus.ini' ))}
                                {foreach $__SINGLE_ITEM.main_node.data_map.linea.content.relation_list as $__SINGLE_LINE_REF}
                                    {def $__SINGLE_LINE = fetch('content','node',hash('node_id', $__SINGLE_LINE_REF.node_id))}
                                    <p class="line_name">
                                        <a href="{$__SINGLE_LINE.url|ezurl(no)}">{$__SINGLE_LINE.name|wash()}</a>
                                    </p>
                                    {if $__SINGLE_ITEM.main_node.data_map.giorno.content.relation_list|count()}
                                        <p class="ava_date">
                                            <span>giorni: </span>
                                            {foreach $__SINGLE_ITEM.main_node.data_map.giorno.content.relation_list as $__KEY => $__SINGLE_DAY_REF}
                                                {def $__SINGLE_DAY = fetch('content','node',hash('node_id', $__SINGLE_DAY_REF.node_id))}
                                                {$__SINGLE_DAY.name|wash()}{if inc($__KEY)lt($__SINGLE_ITEM.main_node.data_map.giorno.content.relation_list|count())},&nbsp;{/if}
                                                {undef $__SINGLE_DAY}
                                            {/foreach}
                                            {undef $__SINGLE_LINE_REF}
                                        </p>
                                    {/if}
                                    {undef $__SINGLE_LINE}
                                {/foreach}
                            {/if}
                        {/foreach}
                        </div>
                    </div>
                {*/cache-block*}

                

                {if or(
                        $__CALENDARIO_DISPONIBILITA_URI.url|count_chars(),
                        $__MODULISTICA_URI.url|count_chars()
                    )
                }
                    <div class="side_block side_docs">
                        <p class="side_title"><i class="fa fa-file-text" aria-hidden="true"></i><span>Iscrizione:</span></p>
                        <ul>
                            {if $__CALENDARIO_DISPONIBILITA_URI.url|count_chars()}
                                <li><a href="{$__CALENDARIO_DISPONIBILITA_URI.url|ezurl(no)}" target="_blank">Calendario disponibilità</a></li>
                            {/if}
                            {if $__MODULISTICA_URI.url|count_chars()}
                                <li><a href="{$__MODULISTICA_URI.url|ezurl(no)}" target="_blank">Modulistica</a></li>
                            {/if}
                        </ul>
                    </div>
                {/if}
            </div>
        </div>
        {/if}
    </div>
</div>

{undef}
