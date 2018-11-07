{ezpagedata_set('has_container',  true())}
{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__OBJECTS = fetch(
                                'content',
                                'list',
                                hash(
                                    'parent_node_id', $node.node_id
                                )
                        )
}

{if $__OBJECTS|count()}
    {def $current_user = fetch( 'user', 'current_user' )}
    {def $__LINES_FILTER = array()}
    {if $current_user.is_logged_in}
        {if $current_user.contentobject.class_identifier|eq("user_pedibus")}
            {foreach $current_user.contentobject.data_map.lines_enable_to_read.content.relation_list as $__LINE_REF}
                {set $__LINES_FILTER = $__LINES_FILTER|append($__LINE_REF.node_id)}
            {/foreach}
        {/if}
    {/if}

    {literal}
    <style>

    body {
        margin: 40px 10px;
        padding: 0;
        font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
        font-size: 14px;
    }

    #pedibuscalendar
    {
        max-width: 900px;
        margin: 0 auto;
        padding: 0 10px;
    }

    </style>
    {/literal}
    <script type="text/javascript">
    {literal}
        document.addEventListener("DOMContentLoaded", function()
        {
            (function ($)
            {
                $(document).ready(function ()
                {
                    $('#pedibuscalendar').fullCalendar(
                    {
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay,listMonth'
                        },
                    {/literal}
                        defaultDate: '{currentdate()|datetime('custom', '%Y-%m-%d')}',
                    {literal}
                        buttonIcons: true,
                        weekNumbers: false,
                        navLinks: true,
                        editable: false,
                        eventLimit: false,
                        events: [
    {/literal}
    {foreach $__OBJECTS as $__A_KEY => $__ITEM}
        {def $__LINES_STR = ""}
        {def $__ADULTS = array()}
        {def $__DATA = ""}
        {def $__SKIP_LOOP = false()}

        {* ASSENZA *}
        {if $__ITEM.object.contentclass_id|eq(ezini( 'IlPedibus', 'adult_not_avaiable', 'ilpedibus.ini' ))}
            {set $__LINES_STR = "Assenza - "}

            {if $__ITEM.data_map.linea.content.relation_list|count()}
                {foreach $__ITEM.data_map.linea.content.relation_list as $__KEY => $__ITEM_REF}
                    {if $__LINES_FILTER|count()}
                        {if $__LINES_FILTER|contains($__ITEM_REF.node_id)|not()}
                            {set $__SKIP_LOOP = true()}
                            {skip}
                        {/if}
                    {/if}
                    {def $__ITEM_ITEM = fetch('content', 'node', hash('node_id', $__ITEM_REF.node_id))}
                    {set $__LINES_STR = concat($__LINES_STR, $__ITEM_ITEM.name|wash())}

                    {if inc($__KEY)lt($__ITEM_ITEM.data_map.linea.content.relation_list|count())}
                        {set $__LINES_STR = concat($__LINES_STR, ", ")}
                    {/if}
                    {undef $__ITEM_ITEM}
                {/foreach}
            {else}
                {* Non ho una linea relazionata, salto tutto *}
                {set $__SKIP_LOOP = true()}
            {/if}

            {if $__SKIP_LOOP|not()}
                {foreach $__ITEM.data_map.volontario.content.relation_list as $__KEY => $__ITEM_REF}
                    {def $__ITEM_ITEM = fetch('content', 'node', hash('node_id', $__ITEM_REF.node_id))}
                    {set $__ADULTS = $__ADULTS|merge( hash($__ITEM_ITEM.name|wash(), $__ITEM_ITEM.url|ezurl(,'full')))}
                    {undef $__ITEM_ITEM}
                {/foreach}

                {set $__DATA = $__ITEM.data_map.data.data_int|datetime('custom', '%Y-%m-%d')}
            {/if}

        {*
            SOSTITUZIONE
            Relazione con Assenze, quindi si possono avere "N date" come "N Assenze"
        *}
        {elseif $__ITEM.object.contentclass_id|eq(ezini( 'IlPedibus', 'adult_replace', 'ilpedibus.ini' ))}
            {set $__LINES_STR = array()}
            {set $__DATA = array()}

            {foreach $__ITEM.data_map.assenza.content.relation_list as $__KEY => $__ITEM_REF}
                {def $__ITEM_NOT_AVAIABLE = fetch('content', 'node', hash('node_id', $__ITEM_REF.node_id))}

                {if $__ITEM_NOT_AVAIABLE.data_map.linea.content.relation_list|count()}
                    {foreach $__ITEM_NOT_AVAIABLE.data_map.linea.content.relation_list as $__KEY => $__ITEM_LINE_REF}
                        {if $__LINES_FILTER|count()}
                            {if $__LINES_FILTER|contains($__ITEM_LINE_REF.node_id)|not()}
                                {set $__SKIP_LOOP = true()}
                                {skip}
                            {/if}
                        {/if}
                        {def $__ITEM_LINE_OBJ = fetch('content', 'node', hash('node_id', $__ITEM_LINE_REF.node_id))}

                        {set $__LINES_STR = $__LINES_STR|append(concat("Sostituzione - ", $__ITEM_LINE_OBJ.name|wash()))}
                        {undef $__ITEM_LINE_OBJ}

                    {/foreach}
                {else}
                    {* Non ho una linea relazionata, salto tutto *}
                    {set $__SKIP_LOOP = true()}
                {/if}

                {if $__SKIP_LOOP|not()}
                    {set $__DATA = $__DATA|append($__ITEM_NOT_AVAIABLE.data_map.data.data_int|datetime('custom', '%Y-%m-%d')) }
                {/if}
                {undef $__ITEM_NOT_AVAIABLE}
            {/foreach}

            {if $__SKIP_LOOP|not()}
                {foreach $__ITEM.data_map.volontario.content.relation_list as $__KEY => $__ITEM_REF}
                    {def $__ITEM_ITEM = fetch('content', 'node', hash('node_id', $__ITEM_REF.node_id))}
                    {set $__ADULTS = $__ADULTS|merge( hash($__ITEM_ITEM.name|wash(), $__ITEM_ITEM.url|ezurl(,'full')))}
                    {undef $__ITEM_ITEM}
                {/foreach}
            {/if}
        {/if}

        {if $__SKIP_LOOP|not()}
            {if $__DATA|is_array()|not()}
                {foreach $__ADULTS as $__ADULT => $__ADULT_URI}
                    {ldelim}
                        title: '{concat($__LINES_STR, " - ", $__ADULT)}',
                        url: {$__ADULT_URI},
                        start: '{$__DATA}',
                        end: '{$__DATA}'
                    {rdelim}{if inc($__A_KEY)lt($__OBJECTS|count())},{/if}
                {/foreach}
            {else}
                {foreach $__DATA as $__DATA_POS => $__DATA_DETAIL}
                    {foreach $__ADULTS as $__ADULT => $__ADULT_URI}
                        {ldelim}
                            title: '{concat($__LINES_STR[$__DATA_POS], " - ", $__ADULT)}',
                            url: {$__ADULT_URI},
                            start: '{$__DATA_DETAIL}',
                            end: '{$__DATA_DETAIL}'
                        {rdelim}{if inc($__A_KEY)lt($__OBJECTS|count())},{/if}
                    {/foreach}
                {/foreach}
            {/if}
        {/if}
        {undef $__LINES_STR}
        {undef $__ADULTS}
        {undef $__DATA}
        {undef $__SKIP_LOOP}
    {/foreach}
    {literal}
                        ],
                        eventRender: function(event, eventElement)
                        {
                            if(event.title.toLowerCase().indexOf(" verde ") > 0)
                            {
                                eventElement.addClass('green');
                            }

                            if(event.title.toLowerCase().indexOf(" blu ") > 0)
                            {
                                eventElement.addClass('blue');
                            }

                            if(event.title.toLowerCase().indexOf(" rossa ") > 0)
                            {
                                eventElement.addClass('red');
                            }

                            if(event.title.toLowerCase().indexOf(" gialla ") > 0)
                            {
                                eventElement.addClass('yellow');
                            }
                        },
                    });
                });
            })(jQuery);
        });
    {/literal}
    </script>

    <div id='pedibuscalendar'></div>
{else}
    <p>Nessuna Assenza o Sostituzione presente</p>
{/if}
